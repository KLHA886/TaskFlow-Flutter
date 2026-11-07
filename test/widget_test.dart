
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/main.dart';

void main() {
  testWidgets('Verificar listado local de TaskFlow',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TaskFlowApp());

    expect(find.text('Mis tareas'), findsOneWidget);
    expect(find.byType(TaskCard), findsNWidgets(5));

    expect(
      find.text('Diseñar pantalla de bienvenida'),
      findsOneWidget,
    );

    expect(
      find.text('Implementar contador de tareas'),
      findsOneWidget,
    );

    expect(
      find.text('Crear listado de tareas'),
      findsOneWidget,
    );

    expect(find.byIcon(Icons.check_circle), findsNWidgets(3));
    expect(
      find.byIcon(Icons.radio_button_unchecked),
      findsNWidgets(2),
    );
  });
}
