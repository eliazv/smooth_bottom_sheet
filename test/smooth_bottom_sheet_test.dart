import 'package:flutter_test/flutter_test.dart';

import 'package:smooth_bottom_sheet/smooth_bottom_sheet.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('shows title and content', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmoothBottomSheet(
            title: 'Settings',
            subtitle: 'Control your experience',
            showHandle: true,
            child: Text('Bottom sheet content'),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Bottom sheet content'), findsOneWidget);
    expect(find.byKey(const Key('smooth_bottom_sheet_handle')), findsOneWidget);
  });

  testWidgets('can hide handle and close button', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SmoothBottomSheet(
            showHandle: false,
            showCloseButton: false,
            child: Text('Plain content'),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Plain content'), findsOneWidget);
    expect(find.byKey(const Key('smooth_bottom_sheet_handle')), findsNothing);
    expect(
      find.byKey(const Key('smooth_bottom_sheet_close_button')),
      findsNothing,
    );
  });
}
