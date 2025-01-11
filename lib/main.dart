import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: false);

  FlutterBluePlus.logs.listen((String log) {
    debugPrint("Bluetooth Log: $log");
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String status = "Unknown"; // Status default

  @override
  void initState() {
    super.initState();

    // Mendengarkan status adapter Bluetooth
    FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      debugPrint("Bluetooth State: $state");

      // Perbarui status berdasarkan perubahan state Bluetooth
      setState(() {
        if (state == BluetoothAdapterState.on) {
          status = "Bluetooth is connected";
        } else {
          status = "Bluetooth is not connected";
        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bluetooth Log Example"),
      ),
      body: Center(
        child: Text(
          status, // Menampilkan status Bluetooth di layar
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
