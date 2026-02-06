import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sybrox_go_app/features/auth/presentation/pages/registration_page.dart';
import 'package:sybrox_go_app/injection_container.dart' as di;
import 'package:get_it/get_it.dart';

void main() {
  setUp(() async {
    await di.init();
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  testWidgets('Referral Logic Verification', (WidgetTester tester) async {
    // Set a large enough screen size to avoid overflow
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    // 1. Pump the Registration Page
    await tester.pumpWidget(const MaterialApp(home: RegistrationPage()));
    await tester.pumpAndSettle();

    // 2. Verify Initial State (Default is Unchecked now)
    expect(find.text('Having a referral code'), findsOneWidget);

    // Find the specific Checkbox for Referral
    final referralRow = find.ancestor(
      of: find.text('Having a referral code'),
      matching: find.byType(Row),
    );
    final checkboxFinder = find.descendant(
      of: referralRow,
      matching: find.byType(Checkbox),
    );

    expect(checkboxFinder, findsOneWidget);
    expect(
      tester.widget<Checkbox>(checkboxFinder).value,
      isFalse,
    ); // Expect Unchecked

    // Verify Field is HIDDEN initially
    expect(find.text('Enter Referral code'), findsNothing);

    // 3. Toggle Checkbox -> Show Field
    await tester.tap(checkboxFinder);
    await tester.pump();

    // Checkbox should be Checked
    expect(tester.widget<Checkbox>(checkboxFinder).value, isTrue);
    // Field should be Visible
    expect(find.text('Enter Referral code'), findsOneWidget);

    // 4. Toggle Checkbox -> Hide Field
    await tester.tap(checkboxFinder);
    await tester.pump();
    expect(find.text('Enter Referral code'), findsNothing);

    // 5. Toggle Checkbox -> Show Field (For Validation Tests)
    await tester.tap(checkboxFinder);
    await tester.pump();
    expect(find.text('Enter Referral code'), findsOneWidget);

    // 5. Validation Logic
    final verifyButtonFinder = find.text('Verify');

    // Case A: Empty Input -> Verify Disabled
    // Note: TextButton onPressed is null when disabled.
    final verifyBtnWidgetInitial = tester.widget<TextButton>(
      find.ancestor(of: verifyButtonFinder, matching: find.byType(TextButton)),
    );
    expect(
      verifyBtnWidgetInitial.onPressed,
      isNull,
      reason: "Verify button should be disabled for empty code",
    );

    // Case B: Invalid Input (Short - Valid length now!) -> "ABC"
    // Requirement change: "Enabled only when ... length is between 1 and 7"
    final referralField = find.byType(TextField).last;
    await tester.enterText(referralField, 'ABC');
    await tester.pump();
    final verifyBtnWidgetShort = tester.widget<TextButton>(
      find.ancestor(of: verifyButtonFinder, matching: find.byType(TextButton)),
    );
    expect(
      verifyBtnWidgetShort.onPressed,
      isNotNull,
      reason: "Verify button should be ENABLED for code length 3 (1-7 range)",
    );

    // Case C: Invalid Input (Lowercase) -> "abcdefg"
    // Requirement: "Automatically convert lowercase input to uppercase"
    await tester.enterText(referralField, 'abcdefg');
    await tester.pump();
    // Logic: onChanged -> BLoC sanitized to ABCDEFG -> State emitted -> TextField rebuilds?
    // NOTE: TextField controller is not explicitly bound to state.referralCode in UI code above,
    // so the TEXT FIELD might still show 'abcdefg' unless we check the State or if we had a controller.
    // However, the verify button logic uses the STATE's referralCode.
    // So if BLoC sanitized it, isVerifyButtonEnabled should use the UpperCase version.
    // 'abcdefg' -> 'ABCDEFG' (Valid) -> Button Enabled.
    final verifyBtnWidgetLower = tester.widget<TextButton>(
      find.ancestor(of: verifyButtonFinder, matching: find.byType(TextButton)),
    );
    expect(
      verifyBtnWidgetLower.onPressed,
      isNotNull,
      reason:
          "Verify button should be ENABLED because input is auto-converted to UpperCase in BLoC state",
    );

    // Case D: Valid Input -> "JC543KA"
    await tester.enterText(referralField, 'JC543KA');
    await tester.pump();
    final verifyBtnWidgetValid = tester.widget<TextButton>(
      find.ancestor(of: verifyButtonFinder, matching: find.byType(TextButton)),
    );
    expect(
      verifyBtnWidgetValid.onPressed,
      isNotNull,
      reason: "Verify button should be enabled for valid code",
    );

    // Case E: Too Long -> "ABCDEFGH" (8 chars)
    // Constraint: Max 7.
    // UI has LengthLimitingTextInputFormatter(7), so user CANNOT type 8 chars.
    // But testing BLoC logic: enterText ignores formatters? No, enterText replaces text.
    // But BLoC logic chops it.
    await tester.enterText(referralField, 'ABCDEFGH');
    await tester.pump();
    // BLoC chops to ABCDEFG. Button Enabled.
    final verifyBtnWidgetLong = tester.widget<TextButton>(
      find.ancestor(of: verifyButtonFinder, matching: find.byType(TextButton)),
    );
    expect(
      verifyBtnWidgetLong.onPressed,
      isNotNull,
      reason: "Verify button should be enabled (BLoC truncates to 7 chars)",
    );

    // 6. Verify Verification Flow
    await tester.tap(verifyButtonFinder);
    await tester.pump(); // Start simulation
    // Should verify after delay (1 sec in BLoC)
    // Pump frames to advance time
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // Verify Popup appears (and button text updates, so we find 2 "Verified" texts)
    expect(find.text('Verified'), findsNWidgets(2));
    // Verify button text changes to "Verified"
    expect(find.text('Verify'), findsNothing);
    // Find 'Verified' text button?
    // In UI code: state.isReferralVerified ? 'Verified' : 'Verify'
    // And there is a popup with text 'Verified' too.
    // Let's check for the text 'Verified' to be present multiple times or specific widgets.
    expect(
      find.text('Verified'),
      findsAtLeastNWidgets(2),
    ); // Button text + Popup text
  });
}
