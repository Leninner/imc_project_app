import 'package:flutter_test/flutter_test.dart';
import 'package:imc_project_app/main.dart';

void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    final titleFinder = find.text('Hello World!');

    expect(titleFinder, findsOneWidget);
  });
}
