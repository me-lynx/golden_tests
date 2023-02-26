import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_tests/main.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

// flutter test --update-goldens
void main() {
  group('Counter', () {
    testWidgets('O valor incial é 0', (tester) async {
      await theAppIsRunning(tester);
      await iSeeText(tester, '0');
    });
    testWidgets('Clicar no botão vai aumentar o contador', (tester) async {
      await theAppIsRunning(tester);
      await iTapIcon(tester, Icons.add);
      await iSeeText(tester, '1');
    });
    testGoldens('A cor do tema é azul', (tester) async {
      await theAppIsRendered(tester);
      await screenshotVerified(tester, 'counter');
    });
  });
}

Future<void> screenShot(WidgetTester tester, String scenario) async {
  await screenMatchesGolden(tester, scenario);
}

Future<void> iTapIcon(WidgetTester tester, IconData icon) async {
  await tester.tap(find.byIcon(icon));
  await tester.pump();
}

Future<void> screenshotVerified(
  WidgetTester tester,
  String scenario,
) async {
  await screenMatchesGolden(tester, scenario);
}

Future<void> iSeeText(WidgetTester tester, String text) async {
  expect(find.text(text), findsOneWidget);
}

Future<void> theAppIsRendered(WidgetTester tester) async {
  await loadAppFonts();

  final builder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: [
      Device.phone,
      Device.iphone11,
      Device.tabletPortrait,
      Device.tabletLandscape,
    ])
    ..addScenario(
      name: 'Testes',
      widget: const MyApp(),
    );
  await tester.pumpDeviceBuilder(builder);
}

Future<void> theAppIsRunning(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
}
