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