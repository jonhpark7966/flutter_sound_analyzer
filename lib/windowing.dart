import 'dart:math';
import 'dart:typed_data';

enum WindowingMethod {
  Hann, tbd
}

class WindowingFactory{
  static Windowing create(WindowingMethod window){
    switch(window){
      case(WindowingMethod.Hann):{
        return new HannWindowing();
      }
      //TODO, add other windowing methods.
      default:{
        assert(false);
        return new HannWindowing();
      }
    }
  }
}

abstract class Windowing{
  Float64List process(List<double> data);
  double getEnergyCorrectionFactor();
  double getAmplitudeCorrectionFactor();
}


class HannWindowing extends Windowing{
  @override
  Float64List process(List<double> data){
    var ret = new Float64List(data.length);
    for (var i = 0; i < data.length; ++i) {
      ret[i] = data[i] * sin(pi * i / data.length) *
          sin(pi * i / data.length);
    }
    return ret;
  }

  @override
  double getEnergyCorrectionFactor(){
    return sqrt(8.0 / 3.0);
  }


  @override
  double getAmplitudeCorrectionFactor(){
    return 2.0;
  }
}
