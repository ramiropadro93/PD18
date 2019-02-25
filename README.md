# PD18
# Trabajo Final: Programación Declarativa UBP 2019

## Descripcion del proyecto
Para este trabajo final decidimos desarrollar un juego de consola estilo puzzle llamado MoveTheBox en el lenguaje de programación Haskell. 

## Descripción del juego

#### Objetivo
La idea del juego es llevar todas las cajas a los lugares de extraccion.

#### Controles
Para mover el personaje, se utilizan las teclas: W(arriba) - S(abajo) - A(izquierda) - D(derecha).

#### Desarrollo del juego
El juego comienza en un nivel básico y va dificultándose a medida que se avanza de nivel. Al llevar todas las cajas a los puntos de extraccion, se autocarga el próximo nivel. En el caso de bloquear alguna de las cajas, se debe salir del mismo y comenzar desde el principio.

#### Niveles
Los niveles se cargan de una lista de niveles preestablecidos.

Los objetos dentro del nivel están representados por:
- pared : '#'
- caja  : 'o'
- caja en punto de extraccion : '*'
- punto de extraccion : '.'
- jugador : P

## Como compilar

C:\path\to\file> ghc MoveTheBox.hs 
  
## Como ejecutar

Desde GHCI ir a C:\path\to\file>MoveTheBox.hs
Funcion main y se carga el juego.

## Conclusión

Nuestro objetivo para este proyecto era afianzar los conocimientos aprendidos en la materia y adquirir nuevos en el lenguaje de Haskell. Planteamos hacer un juego ya que antes habiamos desarrollado videojuegos en otros lenguajes, pensando que sería algo sencillo pero no fue tan fácil. 

Tuvimos algunas dificultades en el manejo del mapa del juego, solucionados con funciones de control. El primer problema fue restringir el mapa de juego para que el personaje no pudiera atravesar las paredes. Luego de resolverlo tuvimos que hacer lo mismo para las cajas que tenian el mismo problema.
Otro problema fue en tiempo de ejecución del juego. Cada vez que el jugador intentaba moverse debia presionar 'enter' para que el movimiento se realizara, lo cual era algo muy molesto.

Quedó una única tarea pendiente que es la opción de presionar una tecla para reiniciar el juego, que no pudo ser solucionada aún. 

## Referencias

[Información sobre el juego](https://en.wikipedia.org/wiki/Sokoban)

[Juego de sokoban online](http://www.game-sokoban.com)

[Aprende Haskell](http://aprendehaskell.es/content/EntradaSalida.html)

[Inputs movimiento de personaje](https://www.haskell.org/onlinereport/haskell2010/haskellch7.html)

[Limpieza de pantalla](http://hackage.haskell.org/package/base-4.12.0.0/docs/System-IO.html)
