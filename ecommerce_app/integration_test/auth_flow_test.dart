import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/src/robot.dart';

void main() {
  final sizeVariant = ValueVariant<Size>({
    const Size(300, 600),
    const Size(600, 800),
    const Size(1000, 1000),
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Sign in and sign out flow', (tester) async {
    final r = Robot(tester);
    await r.setSurfaceSize(sizeVariant.currentValue!);
    await r.pumpMyApp();
    r.products.expectFindAllProductCards();
    await r.openPopupMenu();
    await r.auth.openEmailPasswordSignInScreen();
    await r.auth.signInWithEmailAndPassword();
    r.products.expectFindAllProductCards();
    await r.openPopupMenu();
    await r.auth.openAccountScreen();
    await r.auth.tapLogoutButton();
    await r.auth.tapDialogLogoutButton();
    r.products.expectFindAllProductCards();
  }, variant: sizeVariant);
}
