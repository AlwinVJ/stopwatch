import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String time = '00:00:00';
  bool isvisible = true;
  bool isnotvisible = false;
  bool startispressed = true;
  bool stopispressed = true;
  bool restartispressed = true;
  var owatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  void startTimer(){
    Timer(dur, keeprunning);
  }

  void keeprunning(){
     if(owatch.isRunning){
      startTimer();
     }
     setState(() {
       time = '${owatch.elapsed.inHours.toString().padLeft(2,'0')}:${(owatch.elapsed.inMinutes%60).toString().padLeft(2,'0')}:${(owatch.elapsed.inSeconds%60).toString().padLeft(2,'0')}';
     });
     }
    void startwatch(){
      setState(() {
        startispressed = false;
        stopispressed = false;
        restartispressed = false;
      });
      owatch.start();
      startTimer();
    }
  void stopwatch(){
     setState(() {
        stopispressed = true;
        restartispressed = false;
      });
      owatch.stop();
  }
  void resetwatch(){
    setState(() {
        stopispressed = false;
        restartispressed = true;
        startispressed = true;
        time = '00:00:00';
      });
      owatch.reset();
      
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            //child:Image.asset('images\back.jpg', height: double.infinity, fit: BoxFit.cover),
            color: Colors.black87,
          ),
          Column(
            children: [
              const SizedBox(
                height: 75,
              ),
              Container(
                margin: const EdgeInsets.only(left: 50, right: 50, top: 50),
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red.shade400, width: 4)),
                child: Text(
                  time,
                  style: const TextStyle(color: Colors.red, fontSize: 50),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: startispressed? startwatch : null,
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(color: Colors.red.shade400),
                      child: const Text(
                        'Start',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: stopispressed? null: stopwatch,
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(color: Colors.red.shade400),
                      child: const Text(
                        'Stop',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: restartispressed? null : resetwatch,
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(color: Colors.red.shade400),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
