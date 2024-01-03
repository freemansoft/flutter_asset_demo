# This demonstrates reading the manifest file to find assets in included packages

* test_tools an assets package that should be included only in dev scope
* utilities an assets package
* theme_common an assets package

## Caveat

Assets that are added via pubspec.yaml are copied into a location that is used to populate the assets.
That location may not be cleared when referencing the package via relative location from the demo pubspect.yaml.
This means that assets removed from the included pubspec.yaml may still appear in the AssetManifest until some type of clean operation occurs.

## Project structure

This project contains references from the demo to the three other packages. One of those packages is only used in tests.  `theme_common`, `utilities` and `test_tools` have their own assets that become available to any program or package that takes them as a dependency.  `test_tools` are only available to the demo tests because they are only part of `dev_dependencies`.  The assets in `theme_common` and `utilities` area available to both tests and the program because they are brought in via `dependencies` in the `pubspec.yaml`.

```mermaid
flowchart LR

subgraph demo-example[demo example app]
    lib-example[lfib]
    subgraph assets-example[assets]
    end
    subgraph pubspec-demo[pubspec]
        depend-example[dependencies]
        depend-test-example[dev<br/>dependencies]
    end
end

subgraph demo
    lib-demo[lfib]
    subgraph assets-demo[assets]
    end
    subgraph pubspec-test[pubspec]
        depend-demo[dependencies]
        depend-test-demo[dev<br/>dependencies]
    end

end

depend-example --depends on--> demo
depend-demo --depends on--> theme_common
depend-demo --depends on--> utilities
depend-test-demo -- depends on--> test_tools

subgraph test_tools
    lib-test[lib]
    subgraph assets-test[assets]
        direction TB
        assets-tools-docs[docs]
        assets-tools-models[models]
    end
    subgraph pubspec-tools[pubspec]
        direction TB
        depend-tools[dependencies]
        depend-tools-test[dev<br/>dependencies]
    end
end

subgraph theme_common
    lib-theme[lib]
    subgraph assets-theme[assets]
        direction TB
        assets-theme-docs[docs]
        assets-theme-diagrams[diagrams]
    end
    subgraph pubspec-theme[pubspec]
        direction TB
        depend-theme[dependencies]
        depend-test-theme[dev<br/>dependencies]
    end
end

subgraph utilities
    lib-utilities[lib]
    subgraph assets-utilities[assets]
        direction TB
        assets-utilities-docs[docs]
        assets-utilities-models[models]
    end
    subgraph pubspec-utilities[pubspec]
        direction TB
        depend-utilities[dependencies]
        depend-test-utilities[dev<br/>dependencies]
    end
end
```

## Assets seen from test

The tests see the test_tools assets.

```json
[
    "packages/test_tools/assets/docs/sample301.md",
    "packages/test_tools/assets/models/meta301.json",
    "packages/test_tools/assets/models/template301.json",

    "packages/theme_common/assets/diagrams/draw201.vsdx",
    "packages/theme_common/assets/docs/doc201.md",
    "packages/theme_common/assets/docs/doc202.md",

    "packages/utilities/assets/docs/doc101.md",
    "packages/utilities/assets/docs/doc102.md",
    "packages/utilities/assets/models/model101.json",

    "packages/utilities/lib/resources/icon101.png",
    "packages/utilities/lib/resources/libassets.json"
]
```

Files in lib will be backaged up with the app. You must add them to the asset list if you want them to be picked up by AssetManager or show up in the AssetManifest.

## Assets seen from an app

The demo application does not see the tools_assets but it does see other assets brought in by other packages used in the application.

```json
[
    "packages/cupertino_icons/assets/CupertinoIcons.ttf",

    "packages/theme_common/assets/diagrams/draw201.vsdx",
    "packages/theme_common/assets/docs/doc201.md",
    "packages/theme_common/assets/docs/doc202.md",

    "packages/utilities/assets/docs/doc101.md",
    "packages/utilities/assets/docs/doc102.md",
    "packages/utilities/assets/models/model101.json",

    "packages/utilities/lib/resources/icon101.png",
    "packages/utilities/lib/resources/libassets.json"
]
```

Files in lib will be backaged up with the app. You must add them to the asset list if you want them to be picked up by AssetManager or show up in the AssetManifest.
