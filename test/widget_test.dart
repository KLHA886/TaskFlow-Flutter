import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/main.dart';

void main() {
  testWidgets('Verificar estado y acciones de TaskFlow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TaskFlowApp());

    // Verificar estado inicial.
    expect(find.text('¡Hola, Karen Holguin!'), findsOneWidget);
    expect(find.text('Tareas pendientes: 3'), findsOneWidget);
    expect(find.text('Completadas hoy: 0 de 5'), findsOneWidget);

    // Agregar una tarea.
    await tester.tap(find.text('Agregar tarea'));
    await tester.pump();

    expect(find.text('Tareas pendientes: 4'), findsOneWidget);

    // Completar una tarea.
    await tester.tap(find.text('Completar una tarea'));
    await tester.pump();

    expect(find.text('Tareas pendientes: 3'), findsOneWidget);
    expect(find.text('Completadas hoy: 1 de 5'), findsOneWidget);

    // Completar las tareas restantes.
    for (int i = 0; i < 3; i++) {
      await tester.tap(find.text('Completar una tarea'));
      await tester.pump();
    }

    expect(find.text('Tareas pendientes: 0'), findsOneWidget);
    expect(find.text('Completadas hoy: 4 de 5'), findsOneWidget);
    expect(
      find.text('¡Excelente! No tienes tareas pendientes.'),
      findsOneWidget,
    );

    // Verificar que el botón esté deshabilitado.
    final button = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
    expect(button.onPressed, isNull);
  });
}
