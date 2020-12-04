import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Fuel Screen', () {
    final distanceField = find.byValueKey('distanceField');
    final distancePerUnitField = find.byValueKey('distancePerUnitField');
    final priceField = find.byValueKey('priceField');

    final submitButton = find.byValueKey('submitButton');
    final resetButton = find.byValueKey('resetButton');

    final resultText = find.byValueKey('resultText');
    final currencyDropdown = find.byValueKey('currencyDropdown');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Text fields initialize as empty', () async {
      //Assert.
      expect(await driver.getText(distanceField), "");
      expect(await driver.getText(distancePerUnitField), "");
      expect(await driver.getText(priceField), "");
    });

    test('Submit calculates correctly', () async {
      // Arrange.
      await driver.tap(distanceField);
      await driver.enterText('123');
      await driver.tap(distancePerUnitField);
      await driver.enterText('15');
      await driver.tap(priceField);
      await driver.enterText('1.65');

      //Act.
      await driver.tap(submitButton);

      //Assert.
      var text = await driver.getText(resultText);
      expect(text, contains("13.53"));
    });

    test('Reset clears all fields', () async {
      // Arrange.
      await driver.tap(distanceField);
      await driver.enterText('1');
      await driver.tap(distancePerUnitField);
      await driver.enterText('1');
      await driver.tap(priceField);
      await driver.enterText('1.0');

      //Act.
      await driver.tap(resetButton);

      //Assert.
      expect(await driver.getText(distanceField), "");
      expect(await driver.getText(distancePerUnitField), "");
      expect(await driver.getText(priceField), "");
    });

    test('Currency drop down defaults to dollars', () async {
      //Assert.
      expect(await driver.getText(find.text('Dollars')), isNotNull);
    });

    Future<void> checkCurrency(String currency) async {
      //Act.
      await driver.tap(currencyDropdown);
      await driver.tap(find.text(currency));
      await driver.tap(submitButton);

      //Assert.
      var text = await driver.getText(resultText);
      expect(text, contains(currency));
    }

    test('Currency drop down selection affects result', () async {
      // Arrange.
      await driver.tap(distanceField);
      await driver.enterText('123');
      await driver.tap(distancePerUnitField);
      await driver.enterText('15');
      await driver.tap(priceField);
      await driver.enterText('1.65');

      // Assert.
      await checkCurrency('Euro');
      await checkCurrency('Dollars');
      await checkCurrency('Pounds');
    });
  });
}
