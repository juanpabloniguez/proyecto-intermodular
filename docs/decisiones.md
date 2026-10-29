# Decisiones del proyecto

## Decididas

- El nombre provisional del proyecto es **Old World Companion**.
- La aplicación será Android y se desarrollará con Flutter y Dart.
- La persistencia será local mediante SQLite.
- El MVP funcionará sin conexión, sin cuentas, servidor, API propia ni sincronización en la nube.
- La aplicación tendrá cinco áreas principales: resultado de combate, puntos de victoria, impactos y heridas, magos y hechizos, y fases/recordatorios.
- Las partidas guardadas forman parte del MVP. El diseño prevalece sobre la propuesta cuando se contradicen.
- Se evitará reproducir textos extensos o contenido protegido del reglamento.
- Se mantendrá una separación básica entre interfaz, lógica de negocio y acceso a datos.
- El identificador Android será `com.juanpabloniguez.oldworldcompanion`.
- El proyecto base se generó con Flutter estable 3.47.8 en `C:\src\flutter`; el SDK de Android está disponible para las pruebas.
- Se usará `sqflite` para acceder a SQLite desde Flutter.

## Pendientes

- La propuesta indica que el gestor de partidas queda fuera del MVP, pero el diseño lo incluye dentro de «Fases, recordatorios y partidas guardadas». Se adopta el diseño, pero conviene confirmar y documentar esta decisión con el tutor si procede.
- No se ha elegido la biblioteca concreta de Flutter para acceder a SQLite.
- No se han definido el esquema completo de tablas, claves, relaciones ni estrategia de migraciones de SQLite.
- No se han especificado las fórmulas, límites y casos especiales exactos de las calculadoras.
- No se han definido los valores predeterminados de puntos de victoria.
- No se han definido las fases ni los pasos predeterminados concretos de la checklist.
- No se ha decidido si un hechizo puede pertenecer a más de un saber ni el catálogo inicial de saberes y hechizos.
- No se han detallado las pantallas, componentes visuales, navegación final ni criterios de accesibilidad.
- No se ha definido la estrategia concreta de pruebas automatizadas y manuales.
- No se han fijado versiones de Flutter, Dart, Android SDK ni versión mínima de Android.
- No se ha concretado el formato de la fecha de las partidas ni si se podrá editar o eliminar información guardada.
- No se han definido las licencias concretas de las dependencias ni el contenido propio que se utilizará para los datos de referencia.
