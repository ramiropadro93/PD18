import Prelude hiding (Either(..))
import System.IO  (stdin, stdout, hSetEcho, hSetBuffering
                  ,BufferMode(..))
import Control.Monad (forM_, liftM)    
import Data.List (sort, delete, unfoldr)           

data Input  = Up 
            | Down 
            | Left 
            | Right
            deriving (Show, Eq, Ord)

type Coord = (Int, Int)

data Map = Map  {wWalls
                ,wBoxes
                ,wStorages  :: [Coord]
                ,wWorker    :: Coord
                ,wMax       :: Coord
                ,wSteps     :: Int
                }

emptyMap = Map  {wWalls    = []
                  ,wBoxes   = []
                  ,wStorages = []
                  ,wWorker   = (0,0)
                  ,wMax      = (0,0)
                  ,wSteps    = 0
                  }

instance Show Map where
  show w = unlines chars
    where (maxX, maxY)  = wMax w
          chars         = [[func (x,y)  | x <- [0..maxX]] 
                                        | y <- [0..maxY]]
          func c 
            | isBox   w c && isStorage w c  = '*'
            | isWorker  w c && isStorage w c  = 'p'
            | isWall    w c                   = '#'
            | isWorker  w c                   = 'P'
            | isBox   w c                   = 'o'
            | isStorage w c                   = '.'
            | otherwise                       = ' '

getInput :: IO Input
getInput = do
  char <- getChar
  case char of
    'w' -> return Up
    'a' -> return Left
    's' -> return Down
    'd' -> return Right
    otherwise -> getInput

add :: Coord -> Input -> Coord
add (x,y) input = 
  case input of
    Up    -> (x  , y-1)
    Down  -> (x  , y+1)
    Left  -> (x-1, y  )
    Right -> (x+1, y  )

isWall :: Map -> Coord -> Bool
isWall map coord = elem coord (wWalls map)

isBox :: Map -> Coord -> Bool
isBox map coord = elem coord (wBoxes map)

isStorage :: Map -> Coord -> Bool
isStorage map coord = elem coord (wStorages map)

isWorker :: Map -> Coord -> Bool
isWorker w c  = wWorker w == c


---sistema de niveles - se parsea el txt esperando linea en blanco para diferencia de un nivel a otro
loadLevels :: String -> IO [Map]
loadLevels filename = do
  lns <- liftM lines . readFile $ filename
  return $ unfoldr draw lns
  where isEmptyLine = all (' '==)
        draw [] = Nothing
        draw ls = let (a,b) = break isEmptyLine ls
                     in return (loadLevel $ unlines a, drop 1 b)

--carga el nivel actual
loadLevel :: String -> Map
loadLevel str = foldl draw (emptyMap{wMax = maxi}) elems
  where lns     = lines str
        coords  = [[(x,y) | x <- [0..]] | y <- [0..]]
        elems   = concat $ zipWith zip coords lns
        maxX    = maximum . map (fst . fst) $ elems
        maxY    = maximum . map (snd . fst) $ elems
        maxi    = (maxX, maxY)
        draw wld (c, elt) = 
          case elt of
            'P' -> wld{wWorker      = c}
            'o' -> wld{wBoxes       = c:wBoxes wld}
            '#' -> wld{wWalls       = c:wWalls wld}
            '.' -> wld{wStorages    = c:wStorages wld} 
            '*' -> wld{wBoxes       = c:wBoxes wld
                      ,wStorages    = c:wStorages wld}
            'p' -> wld{wStorages    = c:wStorages wld
                      ,wWorker      = c}
            ' ' -> wld
            otherwise -> error (show elt ++ " error")

--funcion principal, modifica el mapa en cada movimiento del jugador
modifyMap :: Map -> Input -> Maybe Map
modifyMap map input 
  | isWall    map newPos  = Nothing
  | isBox   map newPos  = 
      if isBox map newPos' || isWall map newPos'
        then Nothing
        else return $ moveCrate map' newPos newPos'
  | otherwise               = return map'
  where moveCrate w old new = w{wBoxes = new:delete old (wBoxes w)}
        
        oldPos  = wWorker map
        newPos  = add oldPos input
        newPos' = add newPos input
        map'  = map{wWorker = newPos, wSteps = wSteps map + 1}
        
--nivel terminado
isFinished :: Map -> Bool
isFinished map = 
  sort (wBoxes map) == sort (wStorages map)

--funcion de manejo del juego
gameLoop map = do
  putStr "\ESC[2J"
  print map
  input <- getInput
  let map' = case modifyMap map input of
                  Just x  -> x
                  Nothing -> map
  if isFinished map'
    then putStr "\ESC[2J" >> print map'
    else gameLoop map'  

main :: IO ()
main = do
  hSetEcho stdin False
  hSetBuffering stdin NoBuffering
  hSetBuffering stdout NoBuffering

  levels <- loadLevels "levels.txt"
  forM_ (zip [1..] levels) $ \(n,l) -> do
    putStrLn $ "Level " ++ show n ++ ":"
    gameLoop l
