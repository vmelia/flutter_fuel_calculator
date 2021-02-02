import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'widgetHelper.dart';

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
    WidgetHelper widgetHelper;

    Future<void> enterTextall(String text) async {
      await widgetHelper.enterText(distanceField, text);
      await widgetHelper.enterText(distancePerUnitField, text);
      await widgetHelper.enterText(priceField, text);
    }

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      widgetHelper = WidgetHelper(driver);
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    setUp(() async {
      await enterTextall('');
      //await widgetHelper.enterText(resultText, '');
    });

    test('Text fields initialize as empty', () async {
      //Assert.
      expect(await driver.getText(distanceField), "");
      expect(await driver.getText(distancePerUnitField), "");
      expect(await driver.getText(priceField), "");
    });

    test('Submit calculates correctly', () async {
      // Arrange.
      await widgetHelper.enterText(distanceField, '123');
      await widgetHelper.enterText(distancePerUnitField, '15');
      await widgetHelper.enterText(priceField, '1.65');

      //Act.
      await driver.tap(submitButton);

      //Assert.
      var text = await driver.getText(resultText);
      expect(text, contains("13.53"));
    });

    test('Reset clears all fields', () async {
      // Arrange.
      await enterTextall('9');

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

    test('Currency selection affects result (Euro)', () async {
      // Assert.
      await checkCurrency('Euro');
    });

    test('Currency selection affects result (Dollars)', () async {
      // Assert.
      await checkCurrency('Dollars');
    });

    test('Currency selection affects result (Pounds)', () async {
      // Assert.
      await checkCurrency('Pounds');
    });

    test('Submit button is initially disabled', () async {
      //Assert.
      var isEnabled = await widgetHelper.isEnabled(submitButton);
      expect(isEnabled, false);
    });

    test('Submit button is disabled if any field is empty (distanceField)',
        () async {
      // Arrange.
      await enterTextall('9');

      // Act
      await widgetHelper.enterText(distanceField, '');

      //Assert.
      var isEnabled = await widgetHelper.isEnabled(submitButton);
      expect(isEnabled, false);
    });

    test(
        'Submit button is disabled if any field is empty (distancePerUnitField)',
        () async {
      // Arrange.
      await enterTextall('9');

      // Act
      await widgetHelper.enterText(distancePerUnitField, '');

      //Assert.
      var isEnabled = await widgetHelper.isEnabled(submitButton);
      expect(isEnabled, false);
    });

    test('Submit button is disabled if any field is empty (priceField)',
        () async {
      // Arrange.
      await enterTextall('9');

      // Act
      await widgetHelper.enterText(priceField, '');

      //Assert.
      var isEnabled = await widgetHelper.isEnabled(submitButton);
      expect(isEnabled, false);
    });

    test('Submit button is enabled when all fields are filled in', () async {
      // Act.
      await enterTextall('9');

      //Assert.
      var isEnabled = await widgetHelper.isEnabled(submitButton);
      expect(isEnabled, true);
    });

    test('Reset button is initially disabled', () async {
      //Assert.
      var isEnabled = await widgetHelper.isEnabled(resetButton);
      expect(isEnabled, false);
    });

    test('Reset button is enabled when any field is filled in (distanceField)',
        () async {
      // Act.
      await widgetHelper.enterText(distanceField, '9');

      //Assert.
      var isEnabled = await widgetHelper.isEnabled(resetButton);
      expect(isEnabled, true);
    });

    test(
        'Reset button is enabled when any field is filled in (distancePerUnitField)',
        () async {
      // Act.
      await widgetHelper.enterText(distancePerUnitField, '9');

      //Assert.
      var isEnabled = await widgetHelper.isEnabled(resetButton);
      expect(isEnabled, true);
    });

    test('Reset button is enabled when any field is filled in (priceField)',
        () async {
      // Act.
      await widgetHelper.enterText(priceField, '9');

      //Assert.
      var isEnabled = await widgetHelper.isEnabled(resetButton);
      expect(isEnabled, true);
    });
  });
}
