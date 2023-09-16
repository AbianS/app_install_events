# App Install Events

[![pub package](https://img.shields.io/pub/v/android_intent_plus.svg)](https://pub.dev/packages/app_install_events)
[![pub points](https://img.shields.io/pub/points/android_intent_plus?color=2E8B57&label=pub%20points)](https://pub.dev/packages/app_install_events/score)

A Flutter package that enables detection of application installation and uninstallation events on Android devices. It simplifies monitoring changes in the list of installed applications.

This package is perfect if you're developing an Android launcher with Flutter, as it allows you to detect when applications are installed or uninstalled, enabling you to reflect these changes in your launcher.

## Getting Started

To use this app install events, you need to add the dependencies in `pubspec.yaml` file.

```yaml
dependencies:
    app_install_events: ^0.0.1
```

## Usage

To use this package, import `package:app_install_events/app_install_events.dart`.

```dart
import 'package:app_install_events/app_install_events.dart';

late AppIUEvents _appIUEvents;

@override
void initState(){
    super.initState();
    // Initialize the AppIUEvents class
    _appIUEvents = AppIUEvents();
    
    // Listen to app install and uninstall events
    _appIUEvents.appEvents.listen((event){
        // Check if the event is an install event
        if(event.type == AppIUEventType.INSTALL){
            print("App installed: ${event.packageName}");
        }

        // Check if the event is an uninstall event
        if(event.type == AppIUEventType.UNINSTALL){
            print("App uninstalled: ${event.packageName}");
        }

    });
}

@override
void dispose(){
    _appIUEvents.dispose(); // Dispose the stream
    super.dispose();
}
```
