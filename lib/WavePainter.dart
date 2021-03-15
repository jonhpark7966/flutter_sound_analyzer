import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class WavePainter extends CustomPainter {
  List<double> samples;
  List<Offset> points;
  Color color;
  BuildContext context;
  Size size;
  bool projectFromBottom;

  // Set max val possible in stream, depending on the config
  final double absMax = 1.0;

  WavePainter(this.samples, this.color, this.context, {this.projectFromBottom=false});

  @override
  void paint(Canvas canvas, Size size) {
    this.size = context.size;
    size = this.size;

    Paint paint = new Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    points = toPoints(samples);

    Path path = new Path();
    path.addPolygon(points, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldPainting) => true;

  // Maps a list of ints and their indices to a list of points on a cartesian grid
  List<Offset> toPoints(List<double> samples) {
    List<Offset> points = [];
    for (int i = 0; i < samples.length.toInt(); i++) {
      points.add(
          new Offset(size.width*i/samples.length, project(samples[i], absMax, size.height)));
    }
    return points;
  }

  double project(double val, double max, double height) {
    double waveHeight = (max == 0) ? val : (val / max) * 0.5 * height;
    if(projectFromBottom){
      return height - waveHeight;
    }else{
      return waveHeight + 0.5 * height;
    }
  }
}