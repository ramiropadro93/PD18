module MoveTheBox where

import Test.HUnit
import Test.QuickCheck
import Prelude hiding (Either(..))
import Data.List (sort,delete)
import Control.Monad (forM_)
import System.IO (stdin, stdout, hSetEcho, hSetBuffering, BufferMode(..))
import System.Console.ANSI

type Coord = (Int, Int)

data World = World  {wWalls
                    ,wCrates
                    ,wStorages   :: [Coord]
                    ,wWorker    :: Coord
                    ,wMax       :: Coord
                    ,wSteps     :: Int
                    } deriving (Show)

emptyWorld = World {wWalls      = []
                   ,wCrates      = []
                   ,wStorages   = [] 
                   ,wWorker     = (0,0)
                   ,wMax        = (0,0)
                   ,wSteps      = 0
                   }

data Input  = Up
            | Down
            | Left
            | Right
            deriving (Show, Eq, Ord)

add :: Coord -> Input -> Coord
add (x,y) input =
    case input of
        Up      -> (x   , y-1)
        Down    -> (x   , y+1)
        Left    -> (x-1 , y)
        Right   -> (x+1 , y)

--creacion de niveles: 
level1 = unlines
    ["|||||||||||||||"
    ,"|.. o   o     |"
    ,"|..           |"
    ,"|             |"
    ,"|oo           |"
    ,"|             |"
    ,"|  P          |"
    ,"|             |"
    ,"|             |"
    ,"|             |"
    ,"|||||||||||||||"
    ]

level2 = unlines
    ["|||||||||||||||"
    ,"|.. o   o     |"
    ,"|..           |"
    ,"|             |"
    ,"|oo    o o    |"
    ,"|             |"
    ,"|  P          |"
    ,"|        o  o |"
    ,"|             |"
    ,"|      ..   ..|"
    ,"|||||||||||||||"
    ]

levelList = [level1,level2]

loadLevel :: String -> World
loadLevel str = foldl consume (emptyWorld{wMax = maxi}) elems
    where   lns     = lines str
            coords  = [[(x,y) | x <- [0..]] | y <- [0..]]
            elems   = concat $ zipWith zip coords lns
            maxX    = maximum . map (fst . fst) $ elems
            maxY    = maximum . map (snd . fst) $ elems
            maxi    = (maxX,maxY)
            consume wld (c,elt) = case elt of
                'P' -> wld{wWorker  = c}
                'o' -> wld{wCrates   = c:wCrates wld}
                '|' -> wld{wWalls   = c:wWalls wld}
                '.' -> wld{wStorages = c:wStorages wld}
                ' ' -> wld
                otherwise -> error (show elt ++ " not recognized")


displayWorld :: World -> IO()
displayWorld w = putStrLn . unlines . map (map func) $ coords
    where   (maxX, maxY)    = wMax w
            coords          = [[(x,y) | x <- [0..maxX]] | y <- [0..maxY]]
            isWorker  w c   = wWorker w == c
            func c          =
                case () of ()   | isCrate w c && isStorage w c -> '*'
                                | isWorker w c && isStorage w c -> 'P'
                                | isWall w c        -> '|'
                                | isWorker w c      -> 'P'
                                | isCrate w c         -> 'o'
                                | isStorage w c     -> '.'
                                | otherwise         -> ' '
                
modifyWorld :: World -> Input -> World
modifyWorld world input = 
    case () of ()   | isCrate world newPos    -> moveCrate world' newPos newPos'
                    | otherwise             -> world'
    where   oldPos  = wWorker world
            newPos  = add oldPos input
            newPos' = add newPos input
            world'  = world{wWorker = newPos, wSteps = wSteps world + 1}
            moveCrate w old new = w{wCrates = new:delete old (wCrates world)}

getInput :: IO Input
getInput = do
    char <- getChar
    case char of
        'w' -> return Up
        'a' -> return Left
        's' -> return Down
        'd' -> return Right
        otherwise -> getInput

isWall :: World -> Coord -> Bool
isWall world coord = elem coord (wWalls world) 

isCrate :: World -> Coord -> Bool
isCrate world coord = elem coord (wCrates world)

isStorage :: World -> Coord -> Bool
isStorage world coord = elem coord (wStorages world)

isValid :: World -> Input -> Bool
isValid world input = 
    case () of 
      () | isWall    world newPos -> False
         | isCrate     world newPos -> 
            not(isCrate world newPos') && not(isWall world newPos')
         | otherwise              -> True
    where   oldPos = wWorker world  
            newPos  = add oldPos input
            newPos' = add newPos input


isFinished :: World -> Bool
isFinished world = sort (wCrates world) == sort (wStorages world)

main :: IO()
main = do
    hSetEcho stdin False
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering

    gameLoop $ loadLevel level1

clear = putStr "\ESC[2J"

gameLoop world = do
    displayWorld world
    input <- getInput
    let world' = if isValid world input
                    then do
                        modifyWorld world input
                    else world

    if isFinished world'
        then do
            displayWorld world' >> print "well done! Prepare for next level"
            gameLoop $ loadLevel (levelList!!1)
        else gameLoop world'



--Testing