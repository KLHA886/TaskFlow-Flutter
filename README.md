# taskflow

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Alcance de TaskFlow

**Problema:** Necesito organizar mis actividades académicas y saber cuáles están pendientes.

**Usuario objetivo:** Estudiantes que necesitan planificar sus tareas, proyectos y entregas semanales.

### Historias de usuario y criterios de aceptación

1. **Listar tareas**
   Como estudiante, quiero visualizar mis tareas para organizar mis actividades.
   - Criterio: la lista muestra el título, la prioridad y el estado de cada tarea.

2. **Consultar el detalle**
   Como estudiante, quiero abrir una tarea para conocer su descripción.
   - Criterio: al seleccionar una tarea aparece su información correspondiente.

3. **Crear tareas**
   Como estudiante, quiero registrar nuevas tareas para recordar mis pendientes.
   - Criterio: el formulario permite guardar una tarea válida y mostrarla en la lista.

4. **Editar tareas**
   Como estudiante, quiero modificar mis tareas para actualizar su información.
   - Criterio: los cambios guardados se muestran en la lista y en el detalle.

5. **Eliminar tareas**
   Como estudiante, quiero eliminar tareas que ya no necesito.
   - Criterio: después de confirmar la eliminación, la tarea desaparece del listado.

### Modelo de datos

La entidad Task contiene:

- id: identificador entero único.
- title: título de la tarea.
- description: descripción de la tarea.
- priority: prioridad Alta, Media o Baja.
- isCompleted: indica si la tarea está completada.
- userId: identificador del usuario de prueba.

### Pantallas previstas

- Lista: muestra las tareas y permitirá crear nuevas.
- Detalle: muestra la información de una tarea y permitirá editarla o eliminarla.
- Formulario: permitirá ingresar título, descripción y prioridad.

### Requisitos no funcionales

- La navegación debe ser sencilla y comprensible.
- Si una tarea no existe, se debe mostrar un mensaje en lugar de cerrar la aplicación.

### Contrato de API que necesitaremos

- GET /tasks: listar tareas.
- GET /tasks/:id: consultar el detalle de una tarea.
- POST /tasks: crear una tarea.
- PATCH /tasks/:id: actualizar una tarea.
- DELETE /tasks/:id: eliminar una tarea.

La API se seleccionará más adelante. Estas rutas representan las operaciones previstas y todavía no están conectadas a un servidor.

## API de tareas

TaskFlow utiliza la API pública JSONPlaceholder para consultar tareas mediante peticiones HTTP GET.

**URL base:** https://jsonplaceholder.typicode.com

**Endpoint utilizado:** `GET /todos?userId=2`

**URL completa:** https://jsonplaceholder.typicode.com/todos?userId=2

### Datos recibidos

La API devuelve las tareas del usuario 2 en formato JSON. Cada tarea contiene los siguientes campos:

- `userId`: identificador del usuario.
- `id`: identificador de la tarea.
- `title`: título de la tarea.
- `completed`: indica si la tarea está completada.

### Adaptación al modelo Task

El modelo `Task` de nuestra aplicación utiliza seis propiedades. Como la API no proporciona todos los campos, TaskFlow realiza las siguientes adaptaciones:

- `completed` se convierte en `isCompleted`.
- `description` recibe el valor predeterminado `Sin descripción (API)`.
- `priority` recibe el valor predeterminado `Sin prioridad (API)`.

Los valores predeterminados son agregados por TaskFlow y no provienen del servidor.

### Arquitectura utilizada

La aplicación conserva la arquitectura MVVM con Provider:

1. `TaskApiService` utiliza Dio para consultar la API REST.
2. `RemoteTaskRepository` obtiene las tareas mediante el servicio.
3. `Task.fromJson()` convierte los datos JSON en objetos `Task`.
4. `TasksViewModel` carga las tareas de forma asíncrona y notifica los cambios.
5. `TaskListScreen` muestra las tareas y permite acceder a sus detalles.

### Actualización de tareas

Actualmente, el botón para marcar una tarea como completada modifica únicamente los datos almacenados temporalmente en memoria.

Estos cambios no se guardan en JSONPlaceholder. Al reiniciar la aplicación, las tareas recuperan los estados enviados por la API.

### Verificación

Se comprobó la conexión mediante la respuesta:

`GET /todos?userId=2 → HTTP 200`

También se verificó que TaskFlow muestra las tareas remotas y permite navegar a su pantalla de detalle.

## Semana 4 – Sesión 8: Estados de carga y recuperación

En esta sesión se mejoró TaskFlow para gestionar los diferentes resultados de una consulta HTTP a la API JSONPlaceholder.

### Estados implementados

- **Carga:** se muestra un indicador circular mientras se esperan las tareas.
- **Datos:** se presenta la lista de tareas obtenidas de la API.
- **Vacío:** cuando la API devuelve una lista sin tareas, aparece el mensaje «Todavía no hay tareas para mostrar» y el botón «Actualizar».
- **Error:** cuando falla la conexión, aparece el mensaje «No se pudieron cargar las tareas» y el botón «Reintentar».

### Acciones del usuario

Se incorporó un botón de actualización en la barra superior y la opción de deslizar hacia abajo para volver a consultar las tareas.

El botón «Reintentar» permite repetir una consulta cuando ocurre un error, sin necesidad de reiniciar la aplicación.

### Pruebas realizadas

Se verificaron los siguientes escenarios:

1. Consulta correcta con `userId = 2`.
2. Lista vacía utilizando temporalmente `userId = 9999`.
3. Error de conexión utilizando temporalmente `https://jsonplaceholder.invalid`.
4. Restauración de la dirección correcta de JSONPlaceholder.
5. Ejecución de `flutter analyze` sin problemas.
6. Ejecución de `flutter test` con todas las pruebas aprobadas.

### Resultado

TaskFlow conserva su arquitectura MVVM con Provider y ahora permite mostrar estados de carga, datos, vacío y error, además de ofrecer acciones para actualizar y reintentar consultas.

### Evidencia de recuperación sin reiniciar

Para comprobar el funcionamiento del botón «Reintentar», se utilizó Chrome DevTools, en la pestaña Network.

Primero se activó el modo Offline y se intentó actualizar la lista, provocando un error de conexión. TaskFlow mostró el mensaje correspondiente y el botón «Reintentar».

Después se restauró la conexión seleccionando No throttling y se presionó «Reintentar», sin reiniciar Flutter ni Chrome.

La lista de tareas volvió a aparecer correctamente. En Network se observó una respuesta HTTP 304 (Not Modified), que permitió reutilizar los datos almacenados en caché.

**Resultado:** se comprobó que TaskFlow puede recuperarse de un error de conexión mediante el botón «Reintentar», sin reiniciar la aplicación.