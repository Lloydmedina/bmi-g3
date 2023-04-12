import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:health_app/fitness_app/training/round-buttin.dart';

class SitupTimer extends StatefulWidget {
  const SitupTimer({Key? key}) : super(key: key);

  @override
  _SitupTimerState createState() => _SitupTimerState();
}

class _SitupTimerState extends State {
  int seconds = 0, minutes = 0;
  int resSeconds = 0;
  String digitSec = "00", digitMin = "00";
  String restSec = "00";
  Timer? timer;
  bool started = false;
  List laps = [];
  bool isvisible = false;
  bool isFinish = false;

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;

      digitSec = "00";
      digitMin = "00";

      started = false;
      isFinish = false;
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSec = seconds + 1;
      int localMin = minutes;
      if (localSec > 59) {
        localMin++;
        localSec = 0;
      }
      if (localMin == 3 && localSec <= 0) {
        String a = "1st Set Done";
        String v = "Rest Now";
        setState(() {
          resSeconds = 0;
          laps.add(a);
          laps.add(v);
          stop();
          rest();
        });
      } else if (localMin == 6 && localSec <= 0) {
        String a = "2st Set Done";
        String v = "Rest Now";
        setState(() {
          resSeconds = 0;
          laps.add(a);
          laps.add(v);
          stop();
          rest();
        });
      } else if (localMin == 9 && localSec <= 29) {
        String a = "2st Set Done";
        String v = "Rest Now";
        setState(() {
          resSeconds = 0;
          laps.add(a);
          laps.add(v);
          stop();
          rest();
        });
      } else if (localMin == 10 && localSec <= 0) {
        String a = "Activity Done!";
        setState(() {
          isFinish = true;
          resSeconds = 0;
          laps.add(a);
          stop();
        });
      }
      setState(() {
        resSeconds = 0;
        seconds = localSec;
        minutes = localMin;
        digitSec = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMin = (minutes >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  void rest() {
    started = true;
    isvisible = true;
    resSeconds = 0;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int resLSec = resSeconds + 1;
      if (resLSec > 29) {
        setState(() {
          seconds = 0;

          String b = "Rest Done";
          laps.add(b);
        });

        stop();
        isvisible = false;
        start();
      }
      setState(() {
        resSeconds = resLSec;
        restSec = (resSeconds >= 10) ? "$resSeconds" : "0$resSeconds";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color.fromARGB(255, 163, 2, 163),
            Color.fromARGB(255, 248, 248, 250)
          ])),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Situp Excercise'),
            backgroundColor: Color.fromARGB(255, 255, 65, 214),
          ),
          backgroundColor: Color.fromARGB(0, 238, 235, 235),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Center(
                  child: Text(
                    "$digitMin:$digitSec",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Visibility(
                    visible: isvisible,
                    child: Center(
                      child: Text(
                        "$restSec",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 80,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
                Container(
                  height: 380.0,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 170, 184, 229),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: ListView.builder(
                      itemCount: laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.check_box_outlined),
                              Text(
                                "${laps[index]}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              )
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: !isFinish,
                      child: Expanded(
                          child: RawMaterialButton(
                        onPressed: () {
                          (!started) ? start() : stop();
                        },
                        fillColor: Colors.blue,
                        shape: StadiumBorder(
                          side: BorderSide(color: Colors.blue),
                        ),
                        child: Text(
                          (!started) ? "Start" : "Pause",
                          style: TextStyle(color: Colors.black),
                        ),
                      )),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                        child: RawMaterialButton(
                      onPressed: () {
                        reset();
                      },
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.black),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ))),
    ));
  }
}
