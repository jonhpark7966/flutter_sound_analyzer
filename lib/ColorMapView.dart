import 'dart:typed_data';
import 'dart:ui';
import 'dart:async';
import 'package:fluttersoundanalyzer/mic_stream.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:bitmap/bitmap.dart';
import 'ColorPalette.dart';

class ColorMapView extends StatefulWidget {
  @override
  _ColorMapViewState createState() => _ColorMapViewState();
}

class _ColorMapViewState extends State<ColorMapView> {
  Timer _timer;
  Bitmap bitmap;
  Uint8List bytes;
  int width = (gMicStream.fftWindowSize~/16);
  int height = 700;//TODO, height -> time.
  int startIndex = 0;
  ColorPalette palette;
  @override initState() {
    super.initState();

    palette = ColorPalette(PaletteType.jet);
    bytes = new Uint8List(4*width*height);
    bytes.fillRange(0, 4*width*height, 0);
    bitmap = Bitmap.fromHeadless(width, height, bytes);


   _timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
     setState((){
       var tmp = MicStream.linearToDecibel(gMicStream.fftedSamples);

       // push bytes to future
       for(var j = height-1; j > 0; --j){
         for(var i = 0; i < 4*width; ++i){
           bytes[i+4*width*(j)] = bytes[i+4*width*(j-1)];
         }
       }

       for(var i = 0; i < width; ++i){
         Color color = palette.getColor(tmp[i], -50, 30);
         bytes[4*i] = color.red;
         bytes[4*i+1] = color.green;
         bytes[4*i+2] = color.blue;
         bytes[4*i+3] = 255;
       }
       bitmap = Bitmap.fromHeadless(width, height, bytes);
     });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // Generate the Scaffold
    return Scaffold(
      body:
      ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: height.toDouble(),
            child: Center(child: Image.memory(bitmap.buildHeaded(), fit:BoxFit.fill, gaplessPlayback: true,)),
          ),
       ],
      )
    );
  }
}
