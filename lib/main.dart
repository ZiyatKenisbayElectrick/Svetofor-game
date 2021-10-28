import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('Светофор'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Svetofor(),
    ),
  ));
}
class Svetofor extends StatefulWidget {
  @override
  _SvetoforState createState() => _SvetoforState();
}

class _SvetoforState extends State<Svetofor> {
  actionLight light = actionLight.go;
  void onPedestrianLightPressed() {
    svetoforStopIfSafe();
  }

  void svetoforStopIfSafe() {
    setState(() {
      light = actionLight.stopIfSafe;
    });
    Timer(Duration(seconds: 3), svetoforStop);
  }

  void svetoforStop() {
    setState(() {
      light = actionLight.stop;
    });
    Timer(Duration(seconds: 3), svetoforChangeGo);
  }

  void svetoforChangeGo() {
    setState(() {
      light = actionLight.changeGo;
    });
    Timer(Duration(seconds: 3), svetoforGo);
  }

  void svetoforGo() {
    setState(() {
      light = actionLight.go;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(children: [
          Container(
            child: TrafficLight(light),
          ),
          Container(
              margin: EdgeInsets.only(right: 80),
              child: PedestrianLight(
                light == actionLight.stop,
                onPedestrianLightPressed,
              )),
        ])
      ],
    );
  }
}

class PedestrianLight extends StatelessWidget {
  PedestrianLight(this.isSafeToCross, this.onPressed);
  final bool isSafeToCross;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 80, top: 30),
          child: TextButton(
            onPressed: onPressed,
            child: Text('Переключить'),
          ),
        ),
      ],
    );
  }
}

class TrafficLight extends StatelessWidget {
  TrafficLight(this.light);
  final actionLight light;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Container(
                height: 100, width: 100,
                decoration: BoxDecoration(
                  color: light == actionLight.stop ||
                          light == actionLight.changeGo ? Colors.red : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                height: 100, width: 100,
                decoration: BoxDecoration(
                  color: light == actionLight.changeGo ||
                          light == actionLight.stopIfSafe ? Colors.yellow : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                height: 100, width: 100,
                decoration: BoxDecoration(
                  color: light == actionLight.go ? Colors.green : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum actionLight {
  stop, changeGo, go, stopIfSafe,
}
