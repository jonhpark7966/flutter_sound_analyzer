import 'dart:math';
import 'dart:typed_data';

import 'package:smart_signal_processing/smart_signal_processing.dart';
import 'windowing.dart';


class fft{
  static List<double> process(List<double> input, {WindowingMethod windowingMethod = WindowingMethod.Hann}){
    var window = WindowingFactory.create(windowingMethod);
    var real = window.process(input);
    var imag = Float64List(real.length);

    try{
      FFT.transform(real, imag);
    }catch(error){
      print(real.length);
      print("error occurred!");
      //TODO, return empty queue.
      return input;
    }

    for(var i = 0; i < real.length~/2; ++i){
      //TODO, check autopower?
      real[i] = sqrt(real[i]*real[i] + imag[i]*imag[i]) * window.getAmplitudeCorrectionFactor()*1.5 * (real.length);
    }
    return new List<double>.from(real.sublist(0,real.length~/2));
  }
}