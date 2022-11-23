import 'dart:async';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Barcode Scanner'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: barcodeScanning,
                    child: const Text("Capture Image",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                const Text("Scanned Barcode Number",
                  style: const TextStyle(fontSize: 20),
                ),
                Text(barcode,
                  style: const TextStyle(fontSize: 25, color:Colors.green),
                ),
              ],
            ),
          )),
      debugShowCheckedModeBanner: false,
    );
  }

  //scan barcode asynchronously
  Future barcodeScanning() async {
    try {
      var barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode.toString());
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          barcode = 'No camera permission!';
        });
      } else {
        setState(() => barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => barcode =
      'Nothing captured.');
    } catch (e) {
      setState(() => barcode = 'Unknown error: $e');
    }
  }
}