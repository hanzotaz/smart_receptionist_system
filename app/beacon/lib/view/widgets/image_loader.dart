import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:beacons_plugin/beacons_plugin.dart';

class ImageLoader extends StatefulWidget {
  const ImageLoader({super.key});

  @override
  State<ImageLoader> createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  final StreamController beaconEventsController = StreamController.broadcast();

  String current = 'A';
  String end = 'A';
  List<Offset> points = [];

  bool notified = false;
  bool painted = false;

  Offset aPos = const Offset(40, 180);
  Offset bPos = const Offset(190, 180);
  Offset cPos = const Offset(190, 250);
  Offset dPos = const Offset(190, 160);
  Offset ePos = const Offset(190, 90);
  Offset fPos = const Offset(190, 30);

  @override
  void initState() {
    super.initState();
    initScanner();
    getPath();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initScanner() async {
    BeaconsPlugin.addRegion("6872f642dfd00b137424a6173acd5e18",
        "b9407f30-f5f8-466e-aff9-25556b57fe6d");
    BeaconsPlugin.addRegion("1599f9a4e04485eae967c17c6b940510",
        "b9407f30-f5f8-466e-aff9-25556b57fe7d");
    BeaconsPlugin.addRegion("bbc29d4941db290a7982aa3e232ee521",
        "b9407f30-f5f8-466e-aff9-25556b57fe8d");
    BeaconsPlugin.addRegion("89bd4908100269524eb20908b5d75f29",
        "b9407f30-f5f8-466e-aff9-25556b57fe69d");
    BeaconsPlugin.addRegion("62c91f680ef857a769982e6a4091033b",
        "22bf1ed8-81b4-40ce-ab3f-e30325040059");
    BeaconsPlugin.addRegion("19dd2b01a889f1b059fe1829d573db03",
        "7a4167df-3b92-461b-bdaf-386fd6363727");

    if (Platform.isAndroid && !notified) {
      await BeaconsPlugin.setDisclosureDialogMessage(
        title: "Location Permission Required",
        message: "This app collects location data to work with beacons.",
      );
      notified = true;
    }

    if (Platform.isAndroid) {
      BeaconsPlugin.channel.setMethodCallHandler((call) async {
        if (call.method == 'scannerReady') {
          await BeaconsPlugin.startMonitoring();
        }
      });
    }

    BeaconsPlugin.listenToBeacons(beaconEventsController);

    beaconEventsController.stream.listen(
      (data) {
        if (data.isNotEmpty) {
          if (mounted) {
            setState(() {
              var results = json.decode(data);
              if (double.parse(results['distance']) < 2.00) {
                if (results['uuid'] == "b9407f30-f5f8-466e-aff9-25556b57fe6d") {
                  current = 'A';
                  if (points[1] == aPos) {
                    points.removeAt(0);
                  }
                } else if (results['uuid'] ==
                    "b9407f30-f5f8-466e-aff9-25556b57fe7d") {
                  current = 'B';
                  if (points[1] == bPos) {
                    points.removeAt(0);
                  }
                } else if (results['uuid'] ==
                    "b9407f30-f5f8-466e-aff9-25556b57fe8d") {
                  current = 'C';
                  if (points[1] == cPos) {
                    points.removeAt(0);
                  }
                } else if (results['uuid'] ==
                    "b9407f30-f5f8-466e-aff9-25556b57fe9d") {
                  current = 'D';
                  if (points[1] == dPos) {
                    points.removeAt(0);
                  }
                } else if (results['uuid'] ==
                    "22bf1ed8-81b4-40ce-ab3f-e30325040059") {
                  current = 'E';
                  if (points[1] == ePos) {
                    points.removeAt(0);
                  }
                } else if (results['uuid'] ==
                    "7a4167df-3b92-461b-bdaf-386fd6363727") {
                  current = 'F';
                  if (points[1] == fPos) {
                    points.removeAt(0);
                  }
                }
              }
            });
          }
        }
      },
    );
  }

  getPath() async {
    initScanner();
    String url = "http://10.30.20.101:8080/path?start=$current&end=$end";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        for (var i = 0; i < data.length; i++) {
          if (data[i] == 'A') {
            points.add(aPos);
          } else if (data[i] == 'B') {
            points.add(bPos);
          } else if (data[i] == 'C') {
            points.add(cPos);
          } else if (data[i] == 'D') {
            points.add(dPos);
          } else if (data[i] == 'E') {
            points.add(ePos);
          } else if (data[i] == 'F') {
            points.add(fPos);
          }
        }
        painted = true;
      }
    } catch (e) {
      points = [];
    }
  }

  Future<ui.Image> _loadImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: 300,
      targetWidth: 300,
    );
    var frame = await codec.getNextFrame();
    if (!painted) {
      getPath();
    }
    return frame.image;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
        future: _loadImage("images/floor_00.png"),
        builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Text('Image loading...');
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CustomPaint(
                        painter: ImagePainter(snapshot.data!, points),
                        child: const SizedBox(
                          width: 300,
                          height: 300,
                        ),
                      ),
                    ),
                    DropdownButton(
                      value: end,
                      items: const [
                        DropdownMenuItem(
                          value: "A",
                          child: Text("Front Desk"),
                        ),
                        DropdownMenuItem(
                          value: "D",
                          child: Text("Room 1"),
                        ),
                        DropdownMenuItem(
                          value: "E",
                          child: Text("Room 2"),
                        ),
                        DropdownMenuItem(
                          value: "F",
                          child: Text("Room 3"),
                        ),
                        DropdownMenuItem(
                          value: "C",
                          child: Text("Elevator"),
                        ),
                      ],
                      onChanged: (String? value) {
                        if (mounted) {
                          setState(() {
                            end = value!;
                            points = [];
                            getPath();
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }
          }
        });
  }
}

class ImagePainter extends CustomPainter {
  final ui.Image image;
  final List<Offset> points;

  const ImagePainter(this.image, this.points);

  @override
  void paint(Canvas canvas, Size size) {
    // draw floor plan onto canvas
    canvas.drawImage(image, Offset.zero, Paint());

    // draw path
    const pointMode = ui.PointMode.polygon;

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5;

    final paintStart = Paint()
      ..color = Colors.lightBlueAccent
      ..strokeWidth = 5;

    final paintEnd = Paint()
      ..color = Colors.red
      ..strokeWidth = 5;

    canvas.drawPoints(pointMode, points, paint);
    if (points.elementAt(0) != points.last) {
      canvas.drawCircle(points.elementAt(0), 8.0, paintStart);
      canvas.drawCircle(points.last, 8.0, paintEnd);
    }
  }

  @override
  bool shouldRepaint(ImagePainter oldDelegate) {
    return false;
  }
}
