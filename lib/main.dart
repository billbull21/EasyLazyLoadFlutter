import 'package:flutter/material.dart';
import 'package:lazy_load_flutter/GetxWay/list_screen_getx.dart';
import 'package:lazy_load_flutter/setStateWay/list_screen.dart';

import 'providerWay/list_screen_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Easy Lazy Load Flutter'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ListScreen(),
                  ),
                );
              },
              child: const Text("SET STATE STYLE"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ListScreenProvider(),
                  ),
                );
              },
              child: const Text("PROVIDER STYLE"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ListScreenGetx(),
                  ),
                );
              },
              child: const Text("GETX STYLE"),
            ),
          ],
        ),
      ),
    );
  }
}
