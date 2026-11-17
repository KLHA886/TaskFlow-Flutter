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
