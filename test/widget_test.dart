import 'package:flutter_test/flutter_test.dart';
import 'package:sufian_group/main.dart';

void main() {
  testWidgets('Landing page shows the construction hero content', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('SUFIAN GROUP'), findsWidgets);
    expect(
      find.text('Crafting Excellence in Every Square Foot.'),
      findsOneWidget,
    );
  });
}
