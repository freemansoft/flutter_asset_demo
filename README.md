# This demonstrates reading the manifest file to find assets in included packages

* test_tools an assets package that should be included only in dev scope
* utilities an assets package
* theme_common an assets package

## Caveate

Assets that are added via pubspec.yaml are copied into a location that is used to populate the assets. 
That location may not be cleared when referencing the package via relative location from the demo pubspect.yaml.
This means that assets removed from the included pubspec.yaml may still appear in the AssetManifest until some type of clean operation occurs.
