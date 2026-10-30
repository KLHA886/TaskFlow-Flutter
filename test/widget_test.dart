
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/main.dart';

void main() {
  testWidgets('Verificar pantalla de bienvenida TaskFlow',
      (WidgetTester tester) async {
    // Iniciar la aplicación TaskFlow.
    await tester.pumpWidget(const TaskFlowApp());

    // Verificar el título.
    expect(find.text('TaskFlow'), findsOneWidget);

    // Verificar el nombre.
    expect(
      find.text('¡Hola, Karen Holguin!'),
      findsOneWidget,
    );

    // Verificar las tareas pendientes.
    expect(
      find.text('Tareas pendientes: 5'),
      findsOneWidget,
    );

    // Verificar el icono.
    expect(
      find.byIcon(Icons.check_circle_outline),
      findsOneWidget,
    );
  });
}
