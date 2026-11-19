# Old World Companion - instrucciones del proyecto

## Resumen

Old World Companion será una aplicación Android de apoyo para partidas de Warhammer: The Old World.
Reducirá la carga mental del jugador con calculadoras, seguimiento de puntos y consultas rápidas.
El MVP funcionará sin conexión y guardará los datos en el dispositivo.

## Tecnologías

- Flutter y Dart.
- SQLite para el almacenamiento local.
- Git y GitHub para el control de versiones.
- Android Studio o un entorno equivalente, con emulador o dispositivo Android para las pruebas.

## Funcionalidades del MVP

1. Calculadora de resultado de combate y comprobación de Liderazgo.
2. Contador de puntos de victoria para dos jugadores.
3. Calculadora de impactos y heridas.
4. Gestión de magos, saberes y hechizos seleccionados.
5. Fases con pasos predeterminados, recordatorios personalizados y partidas guardadas con nombre, fecha, jugadores y puntos.

## Fuera del MVP

- Cuentas de usuario.
- Servidor, API propia o sincronización en la nube.
- Uso de la aplicación con conexión como requisito.
- Funcionalidades no esenciales que amplíen el alcance de las cinco herramientas.
- Reproducción de textos extensos o contenido protegido del reglamento.

## Plan de trabajo

- [ ] Diseño y plan de trabajo — diseño básico y planificación realista — fecha objetivo: 15/11/2026.
- [ ] Aplicación y repositorio — estado final del desarrollo del MVP — fecha objetivo: 31/01/2027.
- [ ] Memoria — memoria final del proyecto — fecha objetivo: 07/02/2027.

## Estado

- Documentación inicial leída.
- Se ha resuelto según el diseño la contradicción sobre las partidas guardadas: forman parte del MVP.
- `AGENTS.md` y `docs/decisiones.md` creados.
- Proyecto base Flutter creado con el identificador `com.juanpabloniguez.oldworldcompanion`.
- `flutter analyze`, las pruebas y `flutter build apk --debug` pasan correctamente.
- Dependencia `sqflite` añadida y clase inicial de acceso a SQLite creada.
- El hot reload no se pudo ejecutar porque no había ninguna aplicación Flutter activa en VS Code.
- Se ha aplicado la primera estructura de `Pantallas.md`: menú principal, seis destinos navegables, pantallas base y cinco apariencias visuales.
- `flutter analyze` y `flutter test` pasan tras sustituir la prueba del contador por pruebas del menú y la navegación inicial.
- Las decisiones pendientes están registradas en `docs/decisiones.md`.
- La interfaz está organizada en `lib/screens/`, `lib/theme/`, `lib/widgets/` y `lib/app.dart`; `lib/main.dart` contiene únicamente el arranque de Flutter.
- La pantalla `rolls_screen` calcula y muestra las tiradas objetivo de Impactar y Herir, incluyendo Combate y Disparo, con controles de modificadores adaptados a Android y pruebas automatizadas.
- El selector de BS en Disparo tiene separación superior para evitar solaparse con la barra de pestañas.
- La calculadora de Herir usa 4+, 3+ o 2+ cuando la F iguala, supera en uno o supera en más de un punto a la R.
- `combat_screen` permite acumular bonos para ambos bandos, calcular el vencedor y consultar los rangos de Liderazgo.
- En `combat_screen`, los bonos únicos se controlan con checkbox y `Reiniciar` limpia los dos contadores.
- En `combat_screen`, Heridas sin Salvar es un botón acumulable y aparece junto a Bono por Filas y Otros debajo de los checkboxes.
- Los rangos mostrados de Liderazgo están limitados a tiradas naturales entre 2 y 12.

## Reglas de trabajo

- Trabaja por pasos pequeños que compilen y se puedan probar.
- Antes de cada paso, dime qué vas a hacer y qué archivos tocarás, y espera mi OK.
- Si algo no está en `docs/`, no lo inventes: pregúntame con 2-3 opciones y tu recomendación.
- Hazme las preguntas de una en una.
- Apunta cada decisión que tomemos en `docs/decisiones.md`.
- No añadas librerías ni servicios externos sin preguntarme.
- Mantén un `.gitignore` adecuado: a GitHub nunca se suben contraseñas, claves ni archivos de compilación.
- Al terminar cada paso: compila, dime cómo probarlo, propón el mensaje de commit, actualiza "Estado" y para.
- Explícame lo que haces como a un alumno de DAM.
- Todas las instrucciones van en `AGENTS.md`: no crees `CLAUDE.md` ni `.github/copilot-instructions.md`.
