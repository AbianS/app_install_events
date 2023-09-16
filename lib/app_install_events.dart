import 'dart:async';

import 'package:flutter/services.dart';

/// Enumeration for installation and uninstallation event types
enum IUEventType {
  installed,
  uninstalled,
}

/// Class representing an installation or uninstallation event of an application
class IUEvent {
  final IUEventType type;
  final String packageName;

  IUEvent({
    required this.type,
    required this.packageName,
  });

  @override
  String toString() {
    return 'AppIUEvent {type: $type, packageName: $packageName}';
  }
}

/// Class that provides functionality to listen to application installation and uninstallation events
class AppIUEvents {
  final EventChannel _eventChannel =
      const EventChannel('com.abian.app_install_events/app_monitor');

  final StreamController<IUEvent> _appEventController =
      StreamController<IUEvent>.broadcast();

  /// Get a stream of installation and uninstallation events
  Stream<IUEvent> get appEvents => _appEventController.stream;

  StreamSubscription<IUEvent>? _eventSubscription;

  /// Constructor that automatically starts listening to events.
  AppIUEvents() {
    startListening();
  }

  /// Start listening to installation and uninstallation events
  void startListening() {
    _eventSubscription = _eventChannel.receiveBroadcastStream().map((event) {
      final parts = event.split(':');
      final type = parts[0] == 'AppInstalled'
          ? IUEventType.installed
          : IUEventType.uninstalled;
      final packageName = parts[1];

      return IUEvent(
        type: type,
        packageName: packageName,
      );
    }).listen((appEvent) {
      _appEventController.add(appEvent);
    });
  }

  /// Stop listening to events
  void dispose() {
    _eventSubscription?.cancel();
    _eventSubscription = null;
  }
}
