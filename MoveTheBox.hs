import Prelude hiding (Either(..))
import Data.List (sort,delete)
import System.IO (stdin, stdout, hSetEcho, hSetBuffering, BufferMode(..))

type Coord = (Int, Int)

data Map = Map  {wWalls
                ,wBoxes
                ,wStorages   :: [Coord]
                ,wWorker    :: Coord
                ,wMax       :: Coord
                ,wSteps     :: Int
                } deriving (Show)

emptyMap = Map  {wWalls      = []
                ,wBoxes      = []
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


--carga de coordenadas. 
add :: Coord -> Input -> Coord
add (x,y) input =
    case input of
        Up      -> (x   , y-1)
        Down    -> (x   , y+1)
        Left    -> (x-1 , y)
        Right   -> (x+1 , y)


--CONSTRUCCION DE NIVELES - LA IDEA ES HACERLO A PARTIR DE UN ARCHIVO
--La idea es tener una lista de niveles creando un sistema de niveles controlado automaticamente a medida que el juego avanza. FALTA HACER

--seleccion de nivel: 
level = unlines
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



--carga de nivel
loadLevel :: String -> Map
loadLevel str = foldl consume (emptyMap{wMax = maxi}) elems
    where   lns     = lines str
            coords  = [[(x,y) | x <- [0..]] | y <- [0..]]
            elems   = concat $ zipWith zip coords lns
            maxX    = maximum . map (fst . fst) $ elems
            maxY    = maximum . map (snd . fst) $ elems
            maxi    = (maxX,maxY)
            consume mapp (c,element) = case element of
                'P' -> mapp{wWorker  = c}
                'o' -> mapp{wBoxes   = c:wBoxes mapp}
                '|' -> mapp{wWalls   = c:wWalls mapp}
                '.' -> mapp{wStorages = c:wStorages mapp}
                ' ' -> mapp
                otherwise -> error (show element ++ " not recognized")


--mustra el mapa
showMap :: Map -> IO()
showMap w = putStrLn . unlines . map (map func) $ coords
    where   (maxX, maxY)    = wMax w
            coords          = [[(x,y) | x <- [0..maxX]] | y <- [0..maxY]]
            isWorker  w c   = wWorker w == c
            func c  | isBox     w c && isStorage w c    = '*'
                    | isWorker  w c && isStorage w c    = 'P'
                    | isWall    w c                     = '|'
                    | isWorker  w c                     = 'P'
                    | isBox     w c                     = 'o'
                    | isStorage w c                     = '.'
                    | otherwise                         = ' '
                
--funcion principal, maneja la modificacion del mapa con cada movimiento
modifyMap :: Map -> Input -> Map
modifyMap map input
    | isWall    map newPos    = map'
    | isBox   map newPos    =
        if isBox map newPos' || isWall map newPos'
            then map'
            else moveBox map' newPos newPos'
    | otherwise                 = map'
    where   moveBox w old new = w{wBoxes = new:delete old (wBoxes map)}
            oldPos  = wWorker map
            newPos  = add oldPos input
            newPos' = add newPos input
            map'  = map{wWorker = newPos, wSteps = wSteps map + 1}

--ingreso de teclas
getInput :: IO Input
getInput = do
    char <- getChar
    case char of
        'w' -> return Up
        'a' -> return Left
        's' -> return Down
        'd' -> return Right
        otherwise -> getInput

--Encontre pared
isWall :: Map -> Coord -> Bool
isWall map coord = elem coord (wWalls map) 

--Encontré caja
isBox :: Map -> Coord -> Bool
isBox map coord = elem coord (wBoxes map)

--Punto de extraccion
isStorage :: Map -> Coord -> Bool
isStorage map coord = elem coord (wStorages map)

--Nivel terminado
isFinished :: Map -> Bool
isFinished map = sort (wBoxes map) == sort (wStorages map)

isValid :: Map -> Input -> Bool
isValid map input   | isWall    map newPos  = False
                    | isBox     map newPos  = not(isBox map newPos') && not(isWall map newPos')
                    | otherwise             = True
    where   oldPos = wWorker map  
            newPos  = add oldPos input
            newPos' = add newPos input

main :: IO()
main = do
--bloquea al sistema para evitar que se muestren los inputs (w-a-s-d)
    hSetEcho stdin False
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering

    gameLoop $ loadLevel level

gameLoop map = do
    showMap map
    input <- getInput
    let map' = if isValid map input
                    then modifyMap map input
                    else map
    if isFinished map'
        then showMap map' >> print "GOOD JOB WORKER !!" 
        else gameLoop map'