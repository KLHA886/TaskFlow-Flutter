import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:taskflow/app/taskflow_app.dart';
import 'package:taskflow/features/tasks/data/local_task_repository.dart';
import 'package:taskflow/features/tasks/presentation/tasks_view_model.dart';

void main() {
  testWidgets('TaskFlow muestra las cinco tareas locales', (tester) async {
    final repository = LocalTaskRepository();

    await tester.pumpWidget(
      ChangeNotifierProvider<TasksViewModel>(
        create: (_) => TasksViewModel(repository)..loadTasks(),
        child: const TaskFlowApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Mis tareas'), findsOneWidget);
    expect(find.text('Estudiar para el examen'), findsOneWidget);
    expect(find.text('Realizar tarea de matemáticas'), findsOneWidget);
    expect(find.text('Preparar exposición'), findsOneWidget);
    expect(find.text('Leer material de clase'), findsOneWidget);
    expect(find.text('Entregar proyecto Flutter'), findsOneWidget);
  });
}
