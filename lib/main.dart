import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_sms/flutter_sms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BG Prevoz',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Beogradski prevoz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _zone = "A";
  String _length = "90";
  String _price = "50 din";

  void _setZone(String? selectedZone) {
    if (selectedZone is String) {
      setState(() {
        _zone = selectedZone;
        _calculatePrice();
      });
    }
  }

  void _setLength(String? selectedLength) {
    if (selectedLength is String) {
      setState(() {
        _length = selectedLength;
        _calculatePrice();
      });
    }
  }

  void _calculatePrice() {
    switch (_length) {
      case "90": {
        if (_zone == "C") {
          _price = "100 din";
        } else {
          _price = "50 din";
        }
        break;
      }
      case "1": {
        if (_zone == "C") {
          _price = "150 din";
        } else {
          _price = "120 din";
        }
        break;
      }
      case "7": {
        if (_zone == "C") {
          _price = "1.000 din";
        } else {
          _price = "800 din";
        }
        break;
      }
      case "30": {
        if (_zone == "C") {
          _price = "3.300 din";
        } else {
          _price = "2.200 din";
        }
      }
    }
  }

  Future<void> _buyCard() async {
    log("Kupuje se karta za " + _zone + _length);
    List<String> _recipients = ["9011"];
    String _message = _zone + _length;
    String _result = await sendSMS(
      message: _message,
      recipients: _recipients,
    ).catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Row(
              children: <Widget>[
                Spacer(),
                Expanded(child: Text("Zona:")),
                DropdownButton<String>(
                  value: _zone,
                  icon: const Icon(Icons.arrow_downward),
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  items: const [
                    DropdownMenuItem(child: Text("A"), value: "A"),
                    DropdownMenuItem(child: Text("B"), value: "B"),
                    DropdownMenuItem(child: Text("C = A+B"), value: "C"),
                  ],
                  onChanged: _setZone,
                ),
                Spacer(),
              ],
            ),
            Row(
              children: <Widget>[
                Spacer(),
                Expanded(child: Text("Trajanje:")),
                DropdownButton<String>(
                  value: _length,
                  icon: const Icon(Icons.arrow_downward),
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  items: const [
                    DropdownMenuItem(child: Text("90 minuta"), value: "90"),
                    DropdownMenuItem(child: Text("Dnevna karta"), value: "1"),
                    DropdownMenuItem(child: Text("Nedeljna karta"), value: "7"),
                    DropdownMenuItem(child: Text("Mesecna karta"), value: "30"),
                  ],
                  onChanged: _setLength,
                ),
                Spacer(),
              ],
            ),
            Spacer(),
            Row(
              children: <Widget>[
                Spacer(),
                Expanded(child: Text("Cena:")),
                Text(_price),
                Spacer(),
              ],
            ),
            Spacer(),
            FilledButton.tonalIcon(
              onPressed: _buyCard,
              icon: const Icon(Icons.send),
              label: const Text("Kupi kartu"),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
