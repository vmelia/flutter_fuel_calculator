import 'package:flutter_driver/flutter_driver.dart';

class WidgetHelper {
  FlutterDriver driver;
  WidgetHelper(FlutterDriver driver) {
    this.driver = driver;
  }

  Future<bool> isEnabled(SerializableFinder widget) async {
    Map widgetDiagnostics = await driver.getWidgetDiagnostics(widget);
    return widgetDiagnostics["properties"]
        .firstWhere((property) => property["name"] == 'enabled')["value"];
  }

  Future enterText(SerializableFinder widget, String text) async {
    await driver.tap(widget);
    await driver.enterText(text);
  }
}
