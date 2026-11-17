import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/main.dart';

void main() {
  testWidgets('Verificar listado local de TaskFlow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TaskFlowApp());

    expect(find.text('Mis tareas'), findsOneWidget);

    // Verificar las cinco tareas personalizadas.
    expect(find.byType(ListTile), findsNWidgets(5));

    expect(find.text('Estudiar para el examen'), findsOneWidget);
    expect(find.text('Realizar tarea de matemáticas'), findsOneWidget);
    expect(find.text('Preparar exposición'), findsOneWidget);
    expect(find.text('Leer material de clase'), findsOneWidget);
    expect(find.text('Entregar proyecto Flutter'), findsOneWidget);

    // Verificar una tarea completada y cuatro pendientes.
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    expect(find.byIcon(Icons.radio_button_unchecked), findsNWidgets(4));
  });
}
