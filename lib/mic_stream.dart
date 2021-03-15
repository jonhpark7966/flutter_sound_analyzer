import 'package:mic_stream/mic_stream.dart';

import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'fft.dart';

const AUDIO_FORMAT = AudioFormat.ENCODING_PCM_16BIT;

class MicStream{

  Stream<List<int>> stream;
  StreamSubscription<List<int>> listener;
  int sampleRate = 16000;
  int resampleForDraw = 100;
  Queue<double> currentSamples = new Queue<double>();

  int fftWindowSize = 8192;
  Queue<double> sampleForFFT = new Queue<double>();
  List<double> fftedSamples = new List<double>();

  bool _startListening() {
    stream = microphone(
        audioSource: AudioSource.DEFAULT,
        sampleRate: sampleRate,
        channelConfig: ChannelConfig.CHANNEL_IN_MONO,
        audioFormat: AUDIO_FORMAT);

    listener = stream.listen((samples){
      int i = 0;
      samples.forEach((e){
        if(sampleForFFT.length >= fftWindowSize) sampleForFFT.removeFirst();
        sampleForFFT.add(e/32767);

        i++;
        if(i%resampleForDraw == 0){
          if(currentSamples.length > sampleRate/resampleForDraw) currentSamples.removeFirst();
          currentSamples.add(e/32767);
        }
      });
    });
    return true;
  }

  startStreamAndProcess(){
    _startListening();
    Timer.periodic(Duration(milliseconds: 100), (Timer t) {
        fftedSamples = fft.process(sampleForFFT.toList());
    });
  }

  static List linearToDecibel(stream){
    List ret = new List();
    for(var i =0; i < stream.length; i++){
      ret.add(20 * log(stream[i] / 32767)/ln10);
    }
    return ret;
  }

}
