# PD18
<h1>Trabajo Final: Programación Declarativa UBP 2018</h1>

<h2>Descripcion del proyecto </h2>
<p>Para este trabajo final decidí desarrollar un juego de consola estilo puzzle llamado MoveTheBox en el lenguaje de programación Haskell. </p>

<h2>Descripción del juego</h2>

<h4>Objetivo</h4>
<p>La idea del juego es llevar todas las cajas a los lugares de extraccion.</p>

<h4>Controles</h4>
<p>Para mover el personaje, se utilizan las teclas: W(arriba) - S(abajo) - A(izquierda) - D(derecha)</p>
<p>Para que el juego tome el movimiento hay que presionar Enter porque están cargados como Inputs.</p>

<h4>Desarrollo del juego</h4>
<p>El juego comienza en un nivel básico y va dificultándose a medida que se avanza de nivel. Al llevar todas las cajas a los puntos de extraccion, el juego emite mensaje de felicitaciones y se autocarga el próximo nivel.</p>

<h4>Niveles</h4>
<p>Los niveles se cargan de una lista de niveles preestablecidos.</p>

<h2>Como compilar</h2>

<p>C:\path\to\file> ghc MoveTheBox.hs <p>
  
<h2> Como ejecutar </h2>

<p> Desde GHCI ir a C:\path\to\file>MoveTheBox.hs <p>
<p> Funcion main y se carga el juego.</p>

<h2>Aprendizaje </h2>

<p>Mi objetivo para este proyecto fue poder practicar lo aprendido en clase sobre el lenguaje Haskell. Además la idea de comenzar un proyecto desde cero y afrontar los múltiples problemas que se fueron dando me ayudó a entender aún mejor muchas características del lenguaje que no conocía.</p>
<p> Antes de comenzar a desarrollar, decidí hacer un modelo del proyecto a afrontar. Parecía que iba a ser algo no muy complicado pero cuando empecé el desarrollo me di cuenta que no se iba a resolver tan fácilmente como había creído. El sistema de niveles no fue una tarea sencilla. Para el desarrollo de un único nivel, la tarea era fácil pero al tener que ir cargando nuevos niveles, tuve que jugar un poco con listas para lograr terminarlo. Otra cosa que fue complicada fue desarrollar la función que generará los movimientos del personaje. Decidí que la mejor forma era volver a cargar el mapa con la nueva posición del jugador.</p>
