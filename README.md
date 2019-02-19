# PD18
#Trabajo Final: Programación Declarativa UBP 2018

##Descripcion del proyecto
Para este trabajo final decidimos desarrollar un juego de consola estilo puzzle llamado MoveTheBox en el lenguaje de programación Haskell. 

##Descripción del juego

####Objetivo
La idea del juego es llevar todas las cajas a los lugares de extraccion.

####Controles
Para mover el personaje, se utilizan las teclas: W(arriba) - S(abajo) - A(izquierda) - D(derecha)
Para que el juego tome el movimiento hay que presionar Enter porque están cargados como Inputs.

####Desarrollo del juego
El juego comienza en un nivel básico y va dificultándose a medida que se avanza de nivel. Al llevar todas las cajas a los puntos de extraccion, el juego emite mensaje de felicitaciones y se autocarga el próximo nivel.

####Niveles
Los niveles se cargan de una lista de niveles preestablecidos.

##Como compilar

C:\path\to\file> ghc MoveTheBox.hs 
  
##Como ejecutar

Desde GHCI ir a C:\path\to\file>MoveTheBox.hs
Funcion main y se carga el juego.
