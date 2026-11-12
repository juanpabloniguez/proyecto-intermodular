\# Warhammer: The Old World — Especificación para Flutter



\*\*Versión:\*\* 1.0 · \*\*Fecha:\*\* 12 de noviembre de 2026 · \*\*Idioma del documento:\*\* español.



\## 1. Propósito y fuentes



Documento de referencia para recrear en Flutter la estructura, el aspecto y el comportamiento de una aplicación móvil de seguimiento de partidas de \*\*Warhammer: The Old World\*\*. Combina los requisitos del usuario con las pantallas y variables del prototipo actual.



Referencia de diseño: https://www.figma.com/design/v2ANrW0luVijNGV71BV24k



\### Cómo interpretar esta especificación



\- \*\*Requisito:\*\* comportamiento o contenido solicitado por el usuario.

\- \*\*Diseño actual:\*\* decisión visible en las pantallas de Figma, no necesariamente validada como regla del juego.

\- \*\*Recomendación Flutter:\*\* propuesta técnica o de adaptación; no implica una decisión previamente acordada.

\- \*\*Pendiente:\*\* caso no definido. No sustituirlo silenciosamente por una regla oficial, una suposición o una convención de otra edición.



El prototipo se solicitó inicialmente \*\*sin lógica de aplicación, salvo el flujo entre pantallas\*\*. Esta especificación describe también el comportamiento deseado para una futura versión funcional. No confundir una interacción de demostración con una función ya implementada.



\## 2. Estado real del proyecto y alcance



En el momento de documentarlo existen \*\*31 pantallas/estados principales, 14 pantallas comparativas de color y un overlay de confirmación +1\*\*. Las comparativas son referencias visuales, no nuevas funciones ni destinos del menú.



| Área | Representado actualmente | Por implementar en Flutter |

|---|---|---|

| Navegación | Menú, ida y vuelta a las herramientas y Preferencias; formularios y estados de ejemplo enlazados | Navegación real con conservación coherente del estado |

| Combate | Dos contadores ilustrativos, siete bonos por bando, feedback +1, resultado 7–4 y Liderazgo 8 | Sumas, cálculo del ganador, diferencia y clasificación de tiradas |

| Victoria | Dos contadores a cero, incrementos y entrada personalizada de ejemplo | Entrada por teclado y actualización del jugador correcto |

| Impactar/Herir | Dos vistas con valores, reglas y resultados de ejemplo | Edición numérica y cálculo reactivo |

| Magos | Lista, alta, edición, confirmación de borrado, estado vacío y siete casillas | Edición, guardado, borrado y persistencia; catálogo de conocimientos y conjuros |

| Fases | Plan libre, formularios de recordatorios, estados pendientes y completados de Juego | Casillas individuales, bloqueo real, recordatorios editables y reinicio del ciclo |

| Preferencias | Español y cinco apariencias, con muestras; Reikland seleccionado | Selección efectiva de idioma/tema y persistencia según decisiones finales |



\*\*Fuera de alcance solicitado:\*\* cuentas, autenticación, servidor, sincronización, multijugador en red, creación de listas de ejército, tiradas aleatorias automáticas y catálogo completo de reglas. No incorporarlos como requisitos implícitos.



\## 3. Arquitectura de información y navegación



\### 3.1 Menú principal



Cabecera actual: \*\*THE OLD WORLD\*\*, título \*\*Cuaderno de batalla\*\*. Introducción: «Tu turno, bajo control.» y «Herramientas de consulta y seguimiento para tus partidas.».



Seis botones, en este orden:



| Botón | Texto de apoyo actual | Destino |

|---|---|---|

| Resultados de Combate | Bonos, resultado y Liderazgo | Calcular Resultados de Combate |

| Puntos de Victoria | Lleva la cuenta de ambos jugadores | Puntos de Victoria |

| Impactar/Herir | Consulta la tirada objetivo | Impactar, con acceso a Herir |

| Magos | Gestiona tus magos y conjuros | Lista de magos |

| Fases | Planifica y recorre cada turno | Fases, modo Plan |

| Preferencias | Idioma y apariencia | Preferencias |



Las pantallas interiores muestran \*\*‹ Menú\*\*. Su destino es el menú, no simplemente la última entrada del historial.



\### 3.2 Rutas lógicas propuestas



Los identificadores siguientes son una propuesta Flutter; no son nombres existentes de rutas de una aplicación implementada.



| Ruta propuesta | Vista o estado |

|---|---|

| `/` | Menú principal |

| `/combat` | Contadores y bonos de combate |

| `/combat/result` | Ganador, diferencia y entrada de Liderazgo |

| `/combat/leadership` | Resultados objetivos de Liderazgo |

| `/victory` | Dos jugadores y sus puntos |

| `/victory/custom` | Entrada personalizada; recibe identificador del jugador |

| `/rolls` | Calculadora con pestañas Impactar / Herir |

| `/wizards` | Lista o estado vacío |

| `/wizards/new` | Nuevo mago |

| `/wizards/:id/edit` | Edición del mago |

| `/wizards/:id/delete` | Confirmación de borrado, mediante pantalla o diálogo equivalente |

| `/phases` | Fase y modo actuales |

| `/phases/reminder` | Nuevo recordatorio; recibe fase de origen |

| `/preferences` | Idioma y Apariencia |



\*\*Recomendación:\*\* devolver resultados de formularios a su pantalla de origen, en vez de duplicar una pantalla por jugador o por fase. El prototipo separa esas variantes únicamente para representar el flujo.



\## 4. Resultados de Combate



\### 4.1 Contadores



Título: \*\*Calcular Resultados de Combate\*\*. Dos columnas equivalentes: \*\*Atacante\*\* y \*\*Defensor\*\*, cada una con su total y estos siete botones:



1\. Estandarte.

2\. Estandarte de Batalla.

3\. Heridas sin Salvar.

4\. Bono por Filas.

5\. Formación Cerrada.

6\. Infantería Concentrada.

7\. Otros.



\*\*Requisito:\*\* cada pulsación suma exactamente \*\*+1\*\* al total del bando correspondiente y muestra una animación que comunique claramente la suma. Las pulsaciones en un bando no modifican el otro. No se han solicitado límites de una pulsación para los estandartes: no imponerlos por conocimiento externo del juego.



\*\*Recomendación:\*\* almacenar cantidades por categoría y obtener el total mediante su suma. Inicializar en cero al crear un combate nuevo. Los valores \*\*Atacante 7 / Defensor 4\*\* de Figma son ejemplos, no valores iniciales de producción.



Acción \*\*Calcular\*\* al pie de la pantalla. Debe utilizar los totales actuales y abrir el resultado.



\### 4.2 Feedback de suma



El prototipo abre un overlay \*\*+1 / Bono añadido · demo\*\*, con entrada por fundido de aproximadamente \*\*120 ms\*\* y cierre tras \*\*650 ms\*\*. Es una demostración visual: no altera los contadores.



En la versión funcional, actualizar realmente el total y reproducir feedback asociado al botón o contador pulsado. Esos tiempos pueden servir de referencia. Evitar una animación bloqueante o un aviso global que oculte los controles ante pulsaciones rápidas. El texto «· demo» no forma parte de la interfaz final.



\### 4.3 Resultado



Para totales distintos:



\- Vence el bando con más puntos.

\- \*\*Diferencia = valor absoluto de (Atacante − Defensor)\*\*.

\- Mostrar explícitamente ganador, diferencia y puntuación de ambos.

\- Ejemplo actual: «Gana el Atacante», diferencia \*\*+3\*\*, puntuación \*\*7–4\*\*.



\*\*Pendiente:\*\* comportamiento en un empate. No declarar ganador ni inventar un chequeo del perdedor para ese caso.



La pantalla incorpora un campo numérico \*\*Liderazgo\*\* del bando perdedor y \*\*Volver al combate\*\*. Al introducir un valor válido se muestra un cuadro con los resultados objetivos. Figma representa la entrada y la consulta como dos pantallas; Flutter puede mantenerlas en una misma vista reactiva si conserva la información y el recorrido.



\### 4.4 Liderazgo: reglas y prioridad



Variables: \*\*r\*\* = tirada natural sin modificar; \*\*d\*\* = diferencia positiva del combate; \*\*L\*\* = Liderazgo del perdedor.



Evaluar en este orden para que los resultados sean excluyentes:



1\. Si \*\*r > L\*\*: \*\*Huida\*\*.

2\. Si no se cumple lo anterior y \*\*r + d ≤ L\*\*: \*\*Cede Terreno\*\*.

3\. En los demás casos: \*\*Retirada en Buen Orden\*\*.



La comprobación de \*\*Huida natural tiene prioridad\*\* sobre la tirada modificada. No sumar la diferencia antes de comprobar la tirada natural.



El diseño presenta objetivos para \*\*2D6\*\*, dominio de 2 a 12, sin lanzar dados automáticamente. El usuario no indicó expresamente el número de dados; 2D6 es la interpretación visible del prototipo y debe confirmarse antes de cerrar las reglas.



Ejemplo visible: \*\*L = 8, d = 3\*\*.



| Tirada natural | Resultado |

|---|---|

| 2–5 | Cede Terreno |

| 6–8 | Retirada en Buen Orden |

| 9–12 | Huida |



Para otros valores, clasificar cada resultado del dominio y agrupar intervalos consecutivos. Puede haber categorías sin resultados: mostrarlas como «Sin resultados posibles» u omitir su intervalo de forma clara, nunca generar rangos invertidos.



\*\*Pendientes:\*\* límites admitidos de Liderazgo, excepciones por dobles naturales y cualquier otra regla especial. No se han especificado.



\## 5. Puntos de Victoria



Dos bloques verticales: \*\*Jugador 1\*\* y \*\*Jugador 2\*\*. Cada uno muestra su contador y seis botones en dos filas de tres:



| Primera fila | Segunda fila |

|---|---|

| +10, +25, +50 | +100, +250, Personalizado |



\*\*Requisitos:\*\*



\- Cada incremento se aplica únicamente al jugador al que pertenece el botón.

\- \*\*Personalizado\*\* abre una entrada numérica mediante el teclado.

\- Confirmar añade la cantidad al contador del jugador de origen.

\- Cancelar no altera ningún contador.



El prototipo muestra ambos totales a \*\*0\*\* y una cantidad personalizada de ejemplo \*\*125\*\*. Su teclado dibujado no es una implementación de entrada real.



\*\*Recomendación Flutter:\*\* entrada numérica nativa, con el nombre del jugador visible. No incrustar el teclado de muestra como teclado obligatorio. No aceptar un campo vacío o una entrada que no pueda interpretarse como número entero.



\*\*Pendientes:\*\* posibilidad de cantidades negativas, corrección/resta de puntos, reinicio, límites máximos y persistencia de la partida. La tecla «−» del teclado ilustrativo no establece por sí sola una regla sobre puntos negativos.



\## 6. Impactar / Herir



Una herramienta con dos vistas o pestañas, \*\*Impactar\*\* y \*\*Herir\*\*, con selección visual clara. Cada vista contiene dos campos numéricos enfrentados, controles \*\*− / +\*\*, una tarjeta grande \*\*TIRADA OBJETIVO\*\* y una explicación breve.



\*\*Recomendación:\*\* actualizar el resultado al cambiar una entrada válida. No aplicar límites 1–10 u otros máximos no acordados. Para la comparación de HA se recomienda exigir enteros positivos; la política definitiva de validación queda pendiente.



\### 6.1 Impactar



Entradas: \*\*HA atacante\*\* y \*\*HA defensor\*\*. Resolver las condiciones específicas antes de la condición general «igual o menor»:



| Condición | Objetivo |

|---|---|

| HA atacante > 2 × HA defensor | 2+ |

| En caso contrario, HA atacante > HA defensor | 3+ |

| En caso contrario, HA defensor > 2 × HA atacante | 5+ |

| En los demás casos | 4+ |



«Más que el doble» significa \*\*estrictamente mayor\*\*, no mayor o igual. Ejemplo visible: HA 4 contra HA 3 → \*\*3+\*\*. No interpretar el signo + como una suma pendiente: significa «ese resultado o superior».



\### 6.2 Herir



Entradas: \*\*F atacante\*\* y \*\*R defensor\*\*.



Reglas expresamente solicitadas:



\- Si \*\*F = R\*\*, objetivo \*\*4+\*\*.

\- Si \*\*F \\< R\*\*, por cada punto de diferencia se suma 1 al objetivo base 4+, hasta un máximo de \*\*6+\*\*.

\- El usuario indicó además: «Si la diferencia entre la F y la R es igual o mayor a 6 puntos, la herida es imposible».



\*\*Interpretación del diseño actual, pendiente de confirmación de dirección:\*\* se aplica la imposibilidad cuando \*\*R − F ≥ 6\*\*, no cuando F supera a R en seis. Para F inferior a R y diferencia menor de seis, usar \*\*mínimo de (6, 4 + R − F)\*\*.



| Caso según esa interpretación | Resultado |

|---|---|

| F = R | 4+ |

| R − F = 1 | 5+ |

| R − F = 2, 3, 4 o 5 | 6+ |

| R − F ≥ 6 | Herida imposible |

| F > R | Regla pendiente de definir |



Ejemplo visible: \*\*F 3 / R 4 → 5+\*\*. No inventar resultados 3+ o 2+ para F > R ni aplicar una tabla oficial sin confirmación. Representar «Herida imposible» como un estado distinto de un objetivo numérico.



\## 7. Magos



\### 7.1 Lista y acciones



La herramienta permite \*\*crear, modificar, guardar y borrar magos\*\*. Mostrar la lista de fichas y una acción \*\*Crear mago\*\*. Cada ficha presenta nombre, facción, nivel, conocimiento, conjuros seleccionados y acciones \*\*Modificar\*\* / \*\*Borrar\*\*.



Ejemplo de diseño, no contenido obligatorio inicial:



\- Nombre: \*\*Aelthar\*\*.

\- Facción: \*\*Altos Elfos\*\*.

\- Nivel: \*\*2\*\*.

\- Conocimiento: \*\*Alta Magia\*\*.

\- Conjuros marcados: \*\*Conjuro identificativo\*\* y \*\*Conjuro 2\*\*.



\### 7.2 Formulario



Campos: \*\*Nombre\*\*, \*\*Facción\*\*, \*\*Nivel\*\*, \*\*Conocimiento\*\*. Nombre y facción ocupan filas completas; nivel y conocimiento comparten una fila. Debajo, lista con \*\*exactamente siete conjuros\*\* del conocimiento, cada uno con una casilla independiente.



El diseño usa nombres temporales: \*\*Conjuro identificativo\*\* y \*\*Conjuro 1\*\* a \*\*Conjuro 6\*\*. No se han definido los siete nombres reales por conocimiento, un catálogo completo de facciones ni los niveles admitidos.



\- \*\*Guardar mago:\*\* crear o actualizar la ficha y volver a la lista.

\- \*\*Cancelar:\*\* descartar la edición no confirmada y volver al origen.

\- \*\*Borrar:\*\* pedir confirmación; el diseño muestra «¿Borrar a Aelthar?», \*\*Borrar mago\*\* y \*\*Conservar mago\*\*.

\- Si se elimina el último, mostrar \*\*No hay magos guardados\*\* y acceso a \*\*Crear mago\*\*.



\*\*Requisito de alcance:\*\* basta inicialmente la estructura; no desarrollar reglas profundas de magia.



\*\*Recomendaciones:\*\* identificadores estables, guardado local, validación de nombre no vacío y consistencia entre conocimiento y conjuros. No limitar automáticamente la cantidad de conjuros seleccionables según el nivel: esa relación no se ha solicitado.



\*\*Pendientes:\*\* catálogo definitivo, reglas de selección, política al cambiar de conocimiento y tratamiento de cambios sin guardar al salir por «Menú» o por atrás.



\## 8. Fases del turno



Secuencia requerida: \*\*Fase de Estrategia → Fase de Movimiento → Fase de Disparo → Fase de Combate → Fase de Estrategia\*\*.



La pantalla muestra un selector \*\*Modo plan / Modo juego\*\*, una guía horizontal numerada con las cuatro fases, el nombre de la fase actual y sus subfases.



\### 8.1 Subfases representadas actualmente



El usuario pidió subfases, pero no dio sus nombres. Estos pasos fueron incorporados al diseño como \*\*secuencia de referencia, pendiente de validación reglamentaria\*\*, no como una transcripción certificada del reglamento.



| Fase | Subfases o pasos, en orden |

|---|---|

| Estrategia | Inicio de turno; Mando; Conjuración; Reagrupar unidades que huyen |

| Movimiento | Declarar cargas y reacciones; Mover unidades que cargan; Movimientos obligatorios; Resto de movimientos |

| Disparo | Elegir unidad y objetivo; Resolver impactos y heridas; Salvaciones y retirada de bajas; Resolver pánico |

| Combate | Elegir y resolver un combate; Calcular resultado del combate; Chequear desmoralización; Huidas y persecuciones |



\### 8.2 Modo Plan



\*\*Requisitos:\*\* recorrido libre, sin exigir completar casillas. Permitir entrar directamente a cualquier fase y recorrer anterior/siguiente. Debajo de las subfases aparece \*\*nuevo recordatorio\*\*.



El formulario de recordatorio contiene:



\- Texto personalizado.

\- Asociación opcional a una subfase de la fase de origen.

\- Opción \*\*Sin subfase\*\*.

\- \*\*Guardar recordatorio\*\* y \*\*Cancelar\*\*.



Guardar devuelve a la fase de origen con el recordatorio añadido. Cancelar no añade nada. El ejemplo actual «Revisar efectos activos / Sin subfase · ejemplo» no debe sembrarse automáticamente en todas las fases de una partida real.



\*\*Recomendación de presentación:\*\* situar las notas asociadas junto a su subfase y agrupar las no asociadas bajo «Recordatorios». No convertirlas automáticamente en nuevos pasos bloqueantes.



\### 8.3 Modo Juego



\*\*Requisitos:\*\*



1\. Cada subfase tiene una casilla.

2\. No se puede pasar a la siguiente fase mientras quede alguna casilla sin marcar en la fase actual.

3\. Al completarlas todas, habilitar \*\*Siguiente fase\*\*.

4\. Mantener el orden Estrategia → Movimiento → Disparo → Combate.

5\. Tras completar Combate y avanzar, volver a Estrategia y \*\*desmarcar todas las casillas de todas las fases\*\*.



La condición de habilitación debe calcularse a partir de las casillas de la fase, no mediante un botón que marque todo por su cuenta. Evitar habilitar accidentalmente una fase sin subfases por una lista vacía no configurada.



El prototipo usa estados de ejemplo \*\*0 de 4\*\* y \*\*4 de 4\*\* y un botón \*\*Ver fase completada · demo\*\*. Este último es un atajo de demostración y \*\*no debe sustituir las casillas individuales en la versión funcional\*\*.



El final del prototipo vuelve a Estrategia pendiente, pero sigue mostrando «Turno 1»: no existe un incremento real del turno. \*\*Recomendación Flutter:\*\* incrementar el número de turno al cerrar el ciclo; la mecánica de alternancia entre jugadores no se ha definido.



\*\*Recomendación de estado:\*\* separar la fase consultada en Plan de la fase activa de Juego, para que consultar libremente el plan no eluda el bloqueo. Conservar los recordatorios al iniciar el siguiente turno; el reinicio solicitado afecta a casillas, no a las notas.



\*\*Pendientes:\*\* si los recordatorios tienen casillas propias, si cuentan para bloquear, edición/borrado de notas, navegación hacia atrás en Juego y comportamiento exacto al cambiar de modo.



\## 9. Preferencias



Una pantalla accesible mediante \*\*Preferencias\*\* en el menú. Solo dos secciones: \*\*Idioma\*\* y \*\*Apariencia\*\*. No añadir notificaciones, cuenta, sonido u otras opciones no solicitadas.



\### 9.1 Idioma



Diseño actual: \*\*Español\*\*, con indicador \*\*Actual\*\*. No se ha definido ningún idioma adicional ni un selector funcional. Preparar traducciones centralizadas en Flutter es una recomendación, no permiso para inventar idiomas disponibles.



\### 9.2 Apariencia: cinco modos definitivos de la lista



| Identificador técnico propuesto | Nombre visible | Descripción visible | Familia visual |

|---|---|---|---|

| `reikland` | Reikland | Diurno - Rojo | Día, acento rojo granate |

| `middenland` | Middenland | Diurno - Azul | Día, acento azul |

| `stirland` | Stirland | Diurno - Verde | Día, acento verde |

| `nuln` | Nuln | Noche - Azul | Noche, acento azul claro |

| `talabecland` | Talabecland | Clásico | Pergamino cálido, rojo óxido |



\*\*Corrección definitiva:\*\* Nuln es \*\*Noche - Azul\*\*, no Noche rojo ni Noche verde.



Diseño: cinco filas con indicador circular, nombre, descripción y una pequeña muestra del fondo, texto y acento. \*\*Reikland\*\* aparece seleccionado inicialmente. La muestra de Nuln es oscura y azul; la de Talabecland es pergamino y roja.



La selección y el cambio global no están implementados en Figma. \*\*Recomendación funcional:\*\* una sola apariencia activa; aplicarla a toda la aplicación al seleccionarla y guardar la elección localmente. El usuario ha solicitado hasta ahora mostrar las opciones, no ha decidido si habrá botón «Aplicar»; no añadirlo como obligación.



Las antiguas comparativas Noche granate `#D69AA7` y Noche verde `#8DB29E` se conservan como exploraciones visuales. \*\*No son modos adicionales de Preferencias.\*\*



\## 10. Sistema visual: medidas y componentes



\### 10.1 Escala y composición



\- Referencia móvil: \*\*390 × 844 unidades de Figma\*\*, orientación vertical.

\- En Flutter, usar unidades lógicas y diseño adaptable; no tratar 390 × 844 como resolución física obligatoria ni escalar la aplicación como una imagen.

\- Pantallas de una sola columna, salvo comparaciones de dos valores y filas concretas.

\- Fondo plano; sin fotografías, ilustraciones, texturas de pergamino ni sombras de elevación relevantes.

\- Esquinas habituales de tarjetas y botones: \*\*8\*\*. Muestras de tema: \*\*6\*\*. Overlay +1: \*\*12\*\*.

\- Borde habitual: \*\*1\*\*, selección de apariencia: \*\*2\*\*. No depender solo del color para indicar selección.

\- Padding lateral del cuerpo: \*\*20\*\*; anchura útil habitual: \*\*350\*\*.

\- Espaciados frecuentes: \*\*4, 8, 10, 12, 14, 16, 20 y 24\*\*.

\- Cuerpo general: padding 20 en los cuatro lados. Menú: separación vertical \*\*14\*\* tras añadir Preferencias. Combate y fases: separación habitual \*\*12\*\*.

\- Cabecera interior: padding superior \*\*14\*\*, laterales \*\*20\*\*, inferior \*\*16\*\*; separación entre bloques \*\*15\*\*. Alto observado aproximado: \*\*127\*\*.

\- Pie: laterales \*\*20\*\*, superior \*\*12\*\*, inferior \*\*14\*\*, separación \*\*12\*\*. Botón principal estándar: alto aproximado \*\*44\*\*.



Las barras de estado con «9:41», los símbolos de señal/batería y el indicador inferior dibujado de \*\*112 × 4\*\* son referencias del dispositivo. \*\*En Flutter usar las áreas seguras y los elementos del sistema operativo; no dibujar encima una segunda barra de estado o de gestos.\*\* La altura 127 incluye esos elementos de maqueta y no debe fijarse ciegamente como altura de AppBar.



\### 10.2 Tipografía



Familia actual: \*\*Inter\*\*, estilos \*\*Regular (400)\*\* y \*\*Semi Bold (600)\*\*. No se han creado estilos tipográficos locales independientes; los valores están en las capas de texto.



| Función | Tamaño de referencia | Peso |

|---|---|---|

| Título del menú | 24 | 600 |

| Título de pantalla interior | 22 | 600 |

| Encabezado destacado de sección | 20 | 600 |

| Subtítulo de sección | 16–18 | 600 |

| Títulos de tarjetas y botones | 14–16 | 600 |

| Texto general y campos | 14 | 400 / 600 |

| Filas, explicaciones, etiquetas | 12–13 | 400 / 600 |

| Notas de demostración | 11 | 400 |

| Etiquetas compactas del flujo | 10 | 400 |

| Puntuación de combate | 36 | 600 |

| Puntuación de victoria / campos destacados | 32 | 600 |

| Diferencia de combate | 48 | 600 |

| Tirada objetivo | 56 | 600 |



Interlineado observado: \*\*130 %\*\* en la mayoría de contenidos y \*\*135 %\*\* en menú y cabeceras. Conservar ajuste de línea; no truncar «Estandarte de Batalla» o «Infantería Concentrada».



\*\*Recomendaciones de accesibilidad:\*\* respetar escalado de texto del sistema, permitir scroll y usar objetivos táctiles de al menos 44–48 unidades lógicas aunque el glifo sea pequeño. Las etiquetas 10–11 son una característica de la maqueta, no una obligación de mantener texto diminuto en producción. Verificar licencia y distribución de la fuente Inter.



\### 10.3 Componentes a reutilizar en Flutter



| Componente | Referencia visual y comportamiento |

|---|---|

| Tarjeta de menú | Radio 8, borde 1, padding vertical 15 / horizontal 16, separación de textos 4, título 16/600 y apoyo 12 |

| Acción principal | Fondo de acento, texto on-primary, radio 8, padding aproximado 12 |

| Acción secundaria | Superficie de tarjeta y borde neutro; texto principal |

| Acción destructiva | Color danger, no reutilizar el acento de la facción para significar borrar |

| Contador de combate | Dos columnas de 169 con separación 12; botones de bono de alto 52 y texto 12, +1 a la derecha |

| Tarjeta de jugador | Jugador 1 arriba, Jugador 2 abajo; seis acciones en dos filas |

| Entrada numérica enfrentada | Dos tarjetas con etiqueta, valor 32 y controles − / + |

| Resultado de tirada | Tarjeta centrada con etiqueta 12 y valor 56 |

| Selector de modo / pestañas | Dos botones, activo con fondo de acento; inactivo con superficie y borde |

| Flujo de fases | Cuatro celdas numeradas, una activa; no habilitar saltos futuros en Juego |

| Casilla | Caja de 18–20, radio 3, marca visible y etiqueta textual |

| Apariencia | Fila de ancho 350, alto aproximado 68–70, padding 12, radio circular 20 y muestra 52 × 42 |



No adoptar sin ajustes las elevaciones, radios, colores o tipografía predeterminados de Material: deben corresponder a esta referencia.



\## 11. Paletas exactas



Los tres modos físicos de variables de Figma son \*\*Día\*\*, \*\*Clásico\*\* y \*\*Noche\*\*. Los cinco modos de la aplicación combinan esas superficies con los acentos correspondientes. Flutter debe exponer los cinco nombres de Preferencias, no únicamente tres familias.



\### 11.1 Variables semánticas principales



Todos los valores son hexadecimales RGB opacos; añadir alfa FF cuando un formato lo requiera.



| Rol | Reikland | Middenland | Stirland | Nuln | Talabecland |

|---|---|---|---|---|---|

| background/base | #FFFFFF | #FFFFFF | #FFFFFF | #15181D | #F1E5CC |

| surface/card | #F4F5F7 | #F4F5F7 | #F4F5F7 | #222730 | #FAF3E3 |

| surface/input | #FFFFFF | #FFFFFF | #FFFFFF | #1B2028 | #FFF8EB |

| text/primary | #20242A | #20242A | #20242A | #F1EEE7 | #33291F |

| text/secondary | #59616C | #59616C | #59616C | #B4BAC4 | #6D5A43 |

| border/default | #D7DBE0 | #D7DBE0 | #D7DBE0 | #414954 | #CAB892 |

| action/primary | #7B293B | #23486C | #224E3C | #91ADCB | #803629 |

| text/on-primary | #FFFFFF | #FFFFFF | #FFFFFF | #15181D | #FFFFFF |

| status/danger | #A32732 | #A32732 | #A32732 | #F0A0A8 | #9C3029 |

| text/on-danger | #FFFFFF | #FFFFFF | #FFFFFF | #15181D | #FFFFFF |

| overlay/background | #20242A | #20242A | #20242A | #F1EEE7 | #33291F |

| overlay/text | #FFFFFF | #FFFFFF | #FFFFFF | #15181D | #FAF3E3 |



Los azules y verdes alternativos se eligieron con luminosidad similar a los rojos de referencia. No sustituirlos por los colores predeterminados de Flutter.



\### 11.2 Colores de bandos y jugadores



Mantenerlos separados del acento de apariencia: \*\*Atacante / Jugador 1 azul\*\*, \*\*Defensor / Jugador 2 violeta\*\*, acompañados siempre de sus nombres.



| Rol | Reikland / Middenland / Stirland | Nuln | Talabecland |

|---|---|---|---|

| player/one | #285B8C | #94C4EE | #375E73 |

| player/two | #6B4B8E | #C8A9E9 | #6F4B76 |

| player/one-surface | #EAF2FA | #1C3043 | #E3EAE6 |

| player/two-surface | #F2ECF8 | #33283F | #EBDFE8 |



El tema azul no convierte al Defensor en azul ni elimina la distinción entre bandos. El verde no debe ser la única señal de una acción confirmada o un resultado favorable.



\### 11.3 Correspondencia con Figma



\- Colección primitiva: \*\*TOW · Paleta\*\*, identificador `VariableCollectionId:8:2`.

\- Colección semántica: \*\*TOW · Modos de color\*\*, identificador `VariableCollectionId:8:3`.

\- Día: `8:1`; Clásico: `8:2`; Noche: `8:3`.

\- Acento original: `action/primary`, `VariableID:8:45`.

\- Azul alternativo: `comparison/action-blue`, `VariableID:8:900`.

\- Verde alternativo: `comparison/action-green`, `VariableID:8:903`.



Para Reikland usar Día y acento original; para Middenland, Día y azul alternativo; para Stirland, Día y verde alternativo; para Nuln, Noche y azul alternativo; para Talabecland, Clásico y acento original. No tomar el acento nocturno original rosa como el definitivo de Nuln.



\## 12. Orientación de implementación en Flutter



Esta sección es una \*\*propuesta técnica\*\*, no una ampliación automática del alcance funcional.



\### 12.1 Organización



\- Capa de presentación por funciones: menú, combate, victoria, tiradas, magos, fases y preferencias.

\- Dominio separado para cálculo de combate, Liderazgo y objetivos de tirada, con pruebas unitarias independientes de la interfaz.

\- Definición central de temas, tipografía, espaciados y componentes compartidos.

\- Repositorios locales para magos, recordatorios y preferencias si se implementa persistencia.

\- Textos centralizados para facilitar localización futura; español como contenido disponible actual.



\### 12.2 Composición de vistas



\- `MaterialApp` con tema configurado explícitamente, rutas coherentes y apariencia activa.

\- `Scaffold` y `SafeArea`; contenido mediante `Column`, `Expanded` y una vista desplazable cuando haga falta.

\- Acciones inferiores visibles sin cubrir campos o teclado. Evitar overflows con pantallas pequeñas o texto ampliado.

\- `Row` y anchuras flexibles para comparaciones; no trasladar coordenadas absolutas de Figma a todo el layout.

\- `TextField` / `TextFormField` para entradas; `CheckboxListTile` o equivalente estilizado para conjuros y subfases.

\- Selector exclusivo de apariencia mediante el grupo de selección soportado por la versión de Flutter elegida, con fila completa pulsable y semántica accesible.

\- `ColorScheme` junto con una extensión de tema para roles propios: bandos, superficies de bandos, texto secundario y overlays.



No se fija una versión de Flutter ni paquetes concretos. Utilizar una versión estable y verificar las APIs vigentes antes de implementar.



\### 12.3 Estado y persistencia



Separar estado de preferencias, partida, formularios temporales y datos guardados. Para un primer alcance puede bastar un controlador observable; no existe una decisión acordada sobre Provider, Riverpod, BLoC u otra biblioteca.



\*\*Recomendación:\*\* conservar el estado al navegar entre herramientas de la misma partida; no reiniciar contadores por reconstruir un widget. Definir una acción explícita de nueva partida o nuevo combate antes de incorporar reinicios destructivos no solicitados.



Guardar magos debe producir datos reales recuperables según la política de almacenamiento elegida. Persistir también tema y recordatorios es una recomendación razonable. La conservación de contadores y progreso tras cerrar la aplicación debe confirmarse. No se requiere conexión de red.



\### 12.4 Modelos de datos propuestos



| Modelo | Campos principales |

|---|---|

| Preferencias | identificador de apariencia, locale |

| Combate | valores por cada una de las siete categorías de Atacante y Defensor; totales derivados |

| Resultado de combate | ganador o empate, diferencia, totales, Liderazgo opcional |

| Objetivo de Liderazgo | intervalo de tirada natural y clasificación |

| Puntos de victoria | total Jugador 1, total Jugador 2 |

| Valores de tirada | HA atacante/defensor, F atacante, R defensor, tipo de calculadora |

| Mago | id, nombre, facción, nivel, conocimientoId, ids de conjuros seleccionados |

| Conocimiento | id, nombre, exactamente siete definiciones de conjuro |

| Conjuro | id, nombre y, opcionalmente, índice 0–6 |

| Definición de fase | id, nombre, orden y definiciones de subfase |

| Progreso del turno | turno, fase activa, casillas completadas por fase, modo de vista |

| Recordatorio | id, texto, faseId, subfaseId opcional |



No guardar un total y su desglose como dos fuentes independientes que puedan divergir. No usar nombres traducidos como identificadores persistentes. No duplicar un conocimiento completo dentro de cada mago si basta con referencias estables.



\## 13. Criterios de aceptación y ejemplos de prueba



\### Navegación y conservación de contenido



\- Los seis botones del menú abren su destino; «Menú» vuelve al menú.

\- Cancelar una entrada personalizada o un formulario no ejecuta la acción de guardar.

\- Las pantallas comparativas no aparecen como nuevas herramientas.

\- No se copian a producción los datos de muestra ni las etiquetas «demo», «Valores de ejemplo», «Wireframe» o «sin cálculo automático».



\### Casos funcionales



| Prueba | Resultado esperado |

|---|---|

| Pulsar tres veces Estandarte del Atacante | Su total aumenta 3, el Defensor no cambia; tres sumas reales |

| Combate 7 frente a 4 | Gana Atacante por 3 |

| Combate 2 frente a 5 | Gana Defensor por 3 |

| Combate 4 frente a 4 | Caso pendiente; no inventar ganador |

| L 8, diferencia 3, natural 5 | Cede Terreno |

| L 8, diferencia 3, natural 6 | Retirada en Buen Orden |

| L 8, diferencia 3, natural 8 | Retirada en Buen Orden, no Huida |

| L 8, diferencia 3, natural 9 | Huida por natural |

| Jugador 2 en 0, +25 y personalizado 125 | Jugador 2 en 150; Jugador 1 no cambia |

| HA 7 contra 3 | 2+ |

| HA 4 contra 2 | 3+: igual a dos veces no es más del doble |

| HA 4 contra 4 | 4+ |

| HA 2 contra 4 | 4+: el defensor no supera estrictamente el doble |

| HA 2 contra 5 | 5+ |

| F 3 contra R 3 | 4+ |

| F 3 contra R 4 | 5+ |

| F 3 contra R 5 | 6+ |

| F 3 contra R 8 | 6+, según la interpretación actual |

| F 3 contra R 9 | Imposible, si se confirma R − F ≥ 6 |

| F 5 contra R 3 | Pendiente; no mostrar un objetivo inventado |

| Guardar y editar un mago | Misma ficha e identidad, siete casillas correspondientes al conocimiento |

| Cancelar borrado | El mago permanece |

| Eliminar último mago | Estado vacío y acción Crear mago |

| Juego con tres de cuatro casillas | Siguiente fase deshabilitada |

| Juego con cuatro de cuatro | Siguiente fase habilitada |

| Completar Combate y avanzar | Estrategia activa y todas las casillas de las cuatro fases desmarcadas |

| Plan sin casillas completadas | Navegación libre |

| Crear recordatorio sin subfase | Se guarda asociado a la fase, sin exigir una subfase |

| Elegir Nuln en una versión funcional | Fondo #15181D y acento #91ADCB; no el acento rosa antiguo |



\### Pruebas visuales recomendadas



\- Capturas de referencia por cada uno de los cinco temas, al menos de menú, combate, fases y Preferencias.

\- Verificar 390 × 844, una pantalla menor y texto del sistema ampliado.

\- Probar teclado visible, etiquetas largas, listas de magos extensas y varios recordatorios.

\- Mantener contraste de texto normal suficiente y selección comprensible sin depender exclusivamente del color.

\- Comprobar que el estado deshabilitado no permite navegar mediante otro control equivalente.



\## 14. Decisiones pendientes antes de cerrar la versión funcional



1\. Regla de Herir cuando \*\*F > R\*\* y dirección exacta de la diferencia que causa imposibilidad.

2\. Resultado y recorrido en \*\*empate de combate\*\*.

3\. Confirmación de \*\*2D6\*\*, rango de Liderazgo y excepciones de tiradas naturales.

4\. Rangos numéricos de HA, F, R y nivel de mago; límites y política sobre puntos personalizados negativos.

5\. Catálogos de facciones, conocimientos y nombres reales de los siete conjuros.

6\. Validación reglamentaria de las subfases incorporadas al diseño.

7\. Si los recordatorios son bloqueantes o tienen casillas, si pueden editarse/borrarse y cómo se comportan entre modos.

8\. Qué estado persiste entre sesiones y cómo se inicia o reinicia una partida/combate.

9\. Idiomas adicionales y reglas de edición no guardada.

10\. Aplicación inmediata o confirmada de la apariencia y posible seguimiento del tema del sistema; esta última opción no forma parte de las cinco opciones solicitadas.



Estos pendientes no impiden reproducir fielmente la interfaz y su navegación. Sí impiden afirmar que todas las reglas funcionales están completamente definidas.



\## Anexo A. Referencias de pantallas de Figma



Los IDs sirven para localizar referencias visuales; no deben convertirse en identificadores internos de entidades de Flutter. En una URL de Figma, usar el parámetro `node-id` cambiando los dos puntos del ID por guion.



| Pantalla/estado | IDs de referencia |

|---|---|

| Menú | 5:2 |

| Calcular combate / Resultado / Objetivos de Liderazgo | 5:6 / 5:10 / 5:14 |

| Victoria / Personalizado Jugador 1 / Personalizado Jugador 2 | 5:18 / 5:22 / 5:1175 |

| Impactar / Herir | 5:26 / 5:30 |

| Lista de magos / Nuevo / Editar / Borrar / Vacío | 5:34 / 5:98 / 5:38 / 5:42 / 5:102 |

| Plan: Estrategia / Movimiento / Disparo / Combate | 5:46 / 5:50 / 5:54 / 5:58 |

| Recordatorio: Estrategia / Movimiento / Disparo / Combate | 5:62 / 5:1224 / 5:1255 / 5:1286 |

| Juego pendiente: Estrategia / Movimiento / Disparo / Combate | 5:66 / 5:70 / 5:74 / 5:78 |

| Juego completado: Estrategia / Movimiento / Disparo / Combate | 5:82 / 5:86 / 5:90 / 5:94 |

| Preferencias | 14:2 |

| Overlay de feedback +1 | 5:1317 |

| Comparativa Día rojo: Menú / Combate | 8:55 / 8:157 |

| Comparativa Clásico: Menú / Combate | 8:89 / 8:240 |

| Antigua comparativa Noche granate: Menú / Combate | 8:123 / 8:323 |

| Día azul: Combate / Fases | 8:406 / 8:674 |

| Día verde: Combate / Fases | 8:473 / 8:730 |

| Noche azul: Combate / Fases | 8:540 / 8:786 |

| Noche verde exploratorio: Combate / Fases | 8:607 / 8:842 |



Las comparativas antiguas del menú se crearon antes de añadir Preferencias y no contienen esa sexta opción. Para reconstruir el menú actual, la fuente de referencia es \*\*5:2\*\*, no esas comparativas.



\## Anexo B. Orden de trabajo recomendado



1\. Reproducir componentes, temas y navegación con valores de muestra claramente identificados durante el desarrollo.

2\. Resolver las decisiones pendientes de cálculo antes de sustituir las pantallas de muestra por resultados definitivos.

3\. Implementar contadores, calculadoras y pruebas de dominio.

4\. Implementar formularios, guardado de magos y recordatorios.

5\. Implementar el estado de Juego, su bloqueo y el reinicio de casillas.

6\. Conectar preferencias globales y la persistencia acordada.

7\. Retirar las ayudas de demostración y probar todos los recorridos y las cinco apariencias.



\*\*Fin de la especificación v1.0.\*\*



