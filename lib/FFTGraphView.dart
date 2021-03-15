import 'main.dart';
import 'package:flutter/material.dart';

import 'WavePainter.dart';
import 'package:flutter/widgets.dart';

import 'dart:async';


class FFTGraphView extends StatefulWidget {
  @override
  _FFTGraphViewState createState() => _FFTGraphViewState();
}

class _FFTGraphViewState extends State<FFTGraphView> {
  Timer _timer;
  @override
  initState() {
    super.initState();

    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
      setState((){});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // Create A Scope Display for Sine

    // Generate the Scaffold
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 1,
              child: CustomPaint(painter:
              WavePainter(gMicStream.fftedSamples.toList(), Color(0xffff2a6d), context, projectFromBottom: true),
              )),
        ],
      ),
    );
  }
}
