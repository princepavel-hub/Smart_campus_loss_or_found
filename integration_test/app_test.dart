import 'package:campus_lost/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('launches the recovery overview', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text('CampusLost'), findsOneWidget);
    expect(find.text('Recent reports'), findsOneWidget);
  });
}
