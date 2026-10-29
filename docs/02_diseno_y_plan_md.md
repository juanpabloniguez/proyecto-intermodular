# PLANTILLA: DISEÑO Y PLAN DE TRABAJO
**Proyecto Intermodular II DAM Curso 2026/2027**

| Alumno/a | Juan Pablo Níguez |
| --- | --- |
| **Proyecto** | Old World Companion |
| **Objetivo del MVP** | Desarrollar una aplicación Android que agilice las partidas de Warhammer: The Old World reduciendo la carga mental sobre el jugador. |

## 1. MVP, objetivos y requisitos principales

| Funcionalidad del MVP | Qué debe hacer | Cómo sabrás que funciona |
| --- | --- | --- |
| 1. Calculadora de resultado de combate | Introducir los datos necesarios para calcular el resultado del combate y realizar la comprobación de Liderazgo del bando perdedor. | Probar varios escenarios con valores conocidos y comprobar que el resultado y la comprobación mostrados son coherentes con los cálculos esperados. |
| 2. Contador de puntos de victoria | Registrar y actualizar los puntos de victoria de los dos jugadores durante una partida. | Introducir y modificar puntos para ambos jugadores y comprobar que los totales se muestran correctamente. |
| 3. Calculadora de impactos y heridas | Calcular el resultado correspondiente a impactos o heridas a partir de los atributos necesarios, como HA o Fuerza y Resistencia. | Introducir combinaciones de valores de prueba y verificar que el resultado calculado coincide con el esperado. |
| 4. Gestión de magos y hechizos | Crear magos con nombre, nivel y saber de magia, y asociarles los hechizos disponibles de ese saber para consultarlos durante la partida. | Crear un mago, seleccionar sus hechizos, cerrar y volver a abrir la aplicación, y comprobar que los datos se conservan y pertenecen al saber elegido. |
| 5. Fases, recordatorios y partidas guardadas | Mostrar las fases y pasos predeterminados, permitir guardar recordatorios personalizados asociados a una fase y registrar partidas con nombre, fecha, dos jugadores y sus puntos de victoria. | Comprobar que cada recordatorio aparece en su fase, que sigue disponible al reiniciar la aplicación y que una partida guardada puede consultarse con sus jugadores, fecha y puntuaciones. |

## 2. Flujo inicial de la aplicación

```mermaid
graph TD
    PI[Pantalla inicial] --> PG[Partidas guardadas]
    PI --> CNaP[Crear nueva partida]
    PI --> CA M1[Crear/Añadir Magos]
    PI --> CIH[Calculadora de impactar y herir]
    PI --> CRC[Calculadora de resultado de combate]

    CNaP --> CAM2[Crear/Añadir Magos]
    CAM2 -. Opcional .-> CAM3[Crear/Añadir Magos]
    CNaP --> CPV[Contador de puntos de victoria]
    CNaP --> RF[Recordatorios de fase]
    CNaP --> CRC

    CPV --> FYGP[Finalizar y guardar partida]
    FYGP --> PI
```

## 3. Diseño técnico y viabilidad

| Aspecto | Descripción |
| --- | --- |
| **Arquitectura** | La aplicación se organizará en tres capas sencillas: interfaz de usuario en Flutter, lógica de negocio en Dart y acceso a datos mediante SQLite. La lógica gestionará los cálculos y las operaciones; la capa de datos guardará y recuperará la información persistente. |
| **Tecnologías y servicios** | Flutter y Dart para desarrollar la aplicación Android; SQLite para almacenamiento local; Git y GitHub para control de versiones. El MVP funcionará sin conexión y no necesitará cuentas de usuario, servidor, API propia ni sincronización en la nube. |
| **Datos** | Se almacenarán los saberes y hechizos de referencia, los magos y sus hechizos seleccionados, las partidas con nombre y fecha y los dos jugadores con sus puntos, además de las fases y los recordatorios personalizados asociados a cada fase. Los pasos predeterminados se distinguirán de los recordatorios del usuario. Los cálculos temporales no necesitarán persistencia. |
| **Interfaz** | La interfaz incluirá una pantalla principal para acceder a las herramientas, vistas para las calculadoras, gestión de magos y hechizos, consulta de fases y recordatorios, y listado/detalle de partidas guardadas. La navegación permitirá entrar en cada herramienta y volver a la pantalla principal. El diseño de pantallas y el diagrama de flujo se documentan por separado. |
| **Justificación y viabilidad** | La solución es adecuada para un MVP de alcance acotado: Flutter permite desarrollar la interfaz y Dart la lógica; SQLite permite guardar los datos en el dispositivo y utilizar la aplicación sin conexión. Se mantendrá una separación básica entre interfaz, lógica y datos para facilitar cambios futuros. Las principales dependencias son la instalación del SDK de Flutter, el entorno Android y las bibliotecas que se decida incorporar. |
| **Recursos, permisos y coste** | Se necesitará un ordenador de desarrollo, Flutter SDK, Android Studio o entorno equivalente, un emulador o dispositivo Android para pruebas y una cuenta/repositorio de GitHub. No se prevén costes de servidor ni servicios de pago para el MVP. Se revisarán las licencias de las dependencias utilizadas y se evitará reproducir textos extensos o contenido protegido del reglamento del juego. |

## 4. Plan de trabajo

| Tarea o bloque | Resultado esperado | Responsable / recurso clave | Fecha objetivo |
| --- | --- | --- | --- |
| Diseño y plan de trabajo | Se debe presentar el diseño básico del proyecto y un plan de trabajo realista para desarrollar el MVP. | Alumno / Procesador de texto | 15/11/2026 |
| Aplicación y repositorio | Se debe presentar el estado final del desarrollo del MVP. | Alumno / Flutter/SQLite/GitHub | 31/01/2027 |
| Memoria | Se debe presentar la memoria final del proyecto. | Alumno / Procesador de textos | 07/02/2027 |

## 5. Riesgos y condicionantes

| Riesgo o condicionante | Cómo piensas afrontarlo |
| --- | --- |
| Alcance demasiado amplio o cambios durante el desarrollo. | Priorizar las cinco funcionalidades del MVP y dejar mejoras no esenciales para una versión posterior. Documentar y justificar cualquier cambio de alcance. |
| Errores en los cálculos de las herramientas. | Separar los cálculos de la interfaz y probarlos con casos de ejemplo variados antes de integrar las pantallas. |
| Errores de persistencia o relaciones entre datos en SQLite. | Definir las relaciones entre magos, hechizos, partidas, jugadores, fases y recordatorios; comprobar altas, consultas y modificaciones con pruebas de uso. |

## 6. Validación con usuario prevista

| Aspecto | Descripción |
| --- | --- |
| **Perfil previsto** | Un jugador de Warhammer: The Old World que conozca el funcionamiento habitual de una partida y que pueda valorar la utilidad de una aplicación de consulta. |
| **Qué probará** | Pedirle que utilice las calculadoras, cree un mago y seleccione hechizos, consulte los pasos de una fase, añada un recordatorio personalizado y guarde/consulte una partida con los dos jugadores y sus puntos. Recoger dificultades, errores y sugerencias de mejora. |