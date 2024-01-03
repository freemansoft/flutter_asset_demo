import 'package:demo/asset_stuff.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AssetManifest manifest = await doSomethingWithAssetManifest();

  var assets = manifest.listAssets();

  runApp(MyApp(assets: assets));
}

class MyApp extends StatelessWidget {
  final Iterable<String>? assets;

  const MyApp({super.key, this.assets});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SelectionArea(
        child: Column(children: [const Text('Assets'), Text('$assets')]),
      ),
    );
  }
}
