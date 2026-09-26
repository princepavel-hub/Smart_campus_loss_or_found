import 'package:campus_lost/core/models/campus_item.dart';
import 'package:campus_lost/widgets/status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('status badge renders readable state', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: StatusBadge(ItemStatus.returned))),
    );
    expect(find.text('Returned'), findsOneWidget);
    expect(find.bySemanticsLabel('Status: Returned'), findsOneWidget);
    semantics.dispose();
  });
}
