import 'package:app_install_events/app_install_events.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<IUEvent> _events = [];

  late AppIUEvents _appIUEvents;

  @override
  void initState() {
    _appIUEvents = AppIUEvents();

    _appIUEvents.appEvents.listen((event) {
      if (event.type == IUEventType.installed) {
        print('App installed: ${event.packageName}');
      } else {
        print('App uninstalled: ${event.packageName}');
      }

      setState(() {
        _events.add(event);
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _appIUEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Install/Uninstall Events'),
        ),
        body: ListView.builder(
          itemCount: _events.length,
          itemBuilder: (context, index) {
            final event = _events[index];
            return ListTile(
              title: Text(event.packageName),
              subtitle: Text(event.type.toString()),
            );
          },
        ),
      ),
    );
  }
}
