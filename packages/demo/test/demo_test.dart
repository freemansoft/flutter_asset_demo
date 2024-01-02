import 'dart:convert';

import 'package:demo/asset_stuff.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  setUp(() => TestWidgetsFlutterBinding.ensureInitialized());

  testWidgets(
    'show assets described in $manifestFile',
    (WidgetTester tester) async {
      Map<String, dynamic> allAssets = await doSomethingWithAssetManifestFile();
      JsonEncoder prettyEncoder = const JsonEncoder.withIndent(' ');

      debugPrint('------------');
      var formattedAllAssets = prettyEncoder.convert(allAssets);
      debugPrint('Assets described in $manifestFile file $formattedAllAssets');

      Iterable<String> utilitiesDocAssets = json
          .decode(formattedAllAssets)
          .keys
          .where(
            (String key) =>
                (key.contains('docs') && key.contains('packages/utilities')),
          );
      debugPrint(
          'Docs assets described in $manifestFile of "utilities": $utilitiesDocAssets');

      debugPrint('------------');
      // expect(calculator.addOne(0), 1);
    },
  );

  testWidgets(
    'show assets using AssetManifest',
    (WidgetTester tester) async {
      AssetManifest manifest = await doSomethingWithAssetManifest();

      JsonEncoder prettyEncoder = const JsonEncoder.withIndent(' ');

      debugPrint('------------');

      var assets = manifest.listAssets();
      debugPrint('Assets from AssetManifest ${prettyEncoder.convert(assets)}');
      var utilitiesDocAssets = assets.where((element) =>
          element.contains('docs') && element.contains('packages/utilities'));
      debugPrint(
          'Docs assets described from AssetManifest of "utilities": $utilitiesDocAssets');

      debugPrint('------------');
      // expect(calculator.addOne(0), 1);
    },
  );
}
