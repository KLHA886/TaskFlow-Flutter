import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tasks_view_model.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.taskId});

  final int? taskId;

  @override
  Widget build(BuildContext context) {
    final task = context.watch<TasksViewModel>().findTask(taskId);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de tarea')),
      body: task == null
          ? const Center(child: Text('No se encontró esta tarea.'))
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text(task.description),
                const SizedBox(height: 16),
                Text('Prioridad: ${task.priority}'),
                Text(
                  task.isCompleted ? 'Estado: completada' : 'Estado: pendiente',
                ),
                Text('Usuario: ${task.userId}'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.read<TasksViewModel>().toggleCompleted(task.id);
                  },
                  child: Text(
                    task.isCompleted
                        ? 'Marcar como pendiente'
                        : 'Marcar como completada',
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar tarea'),
                  onPressed: () async {
                    String editedTitle = task.title;

                    final newTitle = await showDialog<String>(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          title: const Text('Editar tarea'),
                          content: TextFormField(
                            initialValue: task.title,
                            decoration: const InputDecoration(
                              labelText: 'Título',
                            ),
                            onChanged: (value) {
                              editedTitle = value;
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(
                                  dialogContext,
                                  editedTitle.trim(),
                                );
                              },
                              child: const Text('Guardar'),
                            ),
                          ],
                        );
                      },
                    );

                    if (!context.mounted ||
                        newTitle == null ||
                        newTitle.length < 3) {
                      return;
                    }

                    try {
                      await context.read<TasksViewModel>().updateTask(
                        task.copyWith(title: newTitle),
                      );

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tarea actualizada correctamente.'),
                        ),
                      );
                    } catch (error) {
                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No se pudo actualizar la tarea.'),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Eliminar tarea'),
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          title: const Text('Eliminar tarea'),
                          content: Text('¿Eliminar ${task.title}?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext, false);
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext, true);
                              },
                              child: const Text('Eliminar'),
                            ),
                          ],
                        );
                      },
                    );

                    if (!context.mounted || confirmed != true) {
                      return;
                    }

                    try {
                      await context.read<TasksViewModel>().deleteTask(task.id);

                      if (!context.mounted) return;

                      Navigator.pop(context);
                    } catch (error) {
                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No se pudo eliminar la tarea.'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
    );
  }
}
