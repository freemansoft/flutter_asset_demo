import 'dart:convert';

import 'package:flutter/services.dart';

const String manifestFile = 'AssetManifest.json';

Future<Map<String, dynamic>> doSomethingWithAssetManifestFile() async {
  final String manifestJson = await rootBundle.loadString(manifestFile);

  var allAssets = json.decode(manifestJson);

  return allAssets;
}

Future<AssetManifest> doSomethingWithAssetManifest() async {
  AssetManifest manifest = await AssetManifest.loadFromAssetBundle(rootBundle);

  return manifest;
}
