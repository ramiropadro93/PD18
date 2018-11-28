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

<h2>Modificaciones</h2>

<h4> Items a agregar: </h4>
<ul>
  <li> Sistema de niveles.</li>
  <li> Colisiones con paredes</li>
  
</ul>

<h4> Posibles nuevo features: </h4>
<ol>
  <li> Interfaz gráfica integrando Haskell con OpenGL.</li>
  <li> En caso de agregar interfaz gráfica -> agregar musicalizació.n</li>
  <li> Autogenerador de niveles.</li>
  <li> Tomar los controles automáticamente. (sin tener que presionar enter) </li>
  <li> Limpiar pantalla en cada movimiento. </li>
  <li> Reiniciar nivel / juego con tecla R.</li>
  <li> Salir del juego con tecla.</li>
<ol>
