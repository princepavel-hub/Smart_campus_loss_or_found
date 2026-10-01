import 'package:campus_lost/core/models/campus_item.dart';
import 'package:campus_lost/features/report/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final kind in ReportKind.values) {
    testWidgets('${kind.name} report accepts custom category and location', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(home: ReportScreen(kind: kind)),
        ),
      );

      await tester.tap(find.byKey(const Key('report_category')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Other').last);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('report_other_category')), findsOneWidget);
      await tester.enterText(
        find.byKey(const Key('report_other_category')),
        'Musical Instrument',
      );

      await tester.ensureVisible(find.byKey(const Key('report_location')));
      await tester.tap(find.byKey(const Key('report_location')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Other').last);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('report_other_location')), findsOneWidget);
      await tester.enterText(
        find.byKey(const Key('report_other_location')),
        'Engineering Block Courtyard',
      );

      expect(find.text('Musical Instrument'), findsOneWidget);
      expect(find.text('Engineering Block Courtyard'), findsOneWidget);
    });
  }
}
