import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;

  int totalSeconds = twentyFiveMinutes;
  int totalPromodoros = 0;
  bool isRunning = false;
  late Timer timer;

  void onTick(Timer timer) {
    setState(() {
      (totalSeconds > 0) ? totalSeconds = totalSeconds - 1 : countReset();
    });
  }

  void countReset() {
    totalSeconds = twentyFiveMinutes;
    totalPromodoros = totalPromodoros + 1;
    timer.cancel();
    isRunning = false;
  }

  void onResetPressed() {
    setState(() {
      timer.cancel();
      totalSeconds = twentyFiveMinutes;
      isRunning = false;
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 98,
                    color: Theme.of(context).cardColor,
                    onPressed: () { isRunning
                        ? onPausePressed()
                        : onStartPressed();
                    },
                    icon: Icon( isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline
                    ),
                  ),
                  IconButton(
                    iconSize: 98,
                    color: Theme.of(context).cardColor,
                    onPressed: () {
                      if (isRunning) onResetPressed();
                    },
                    icon: Icon(
                      Icons.refresh_outlined
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Pomodors',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headlineLarge?.color
                          ),
                        ),
                        Text('$totalPromodoros',
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).textTheme.headlineLarge?.color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
