// Copyright (c) 2018 Diogo Nunes
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT
import 'package:firebase_performance/firebase_performance.dart';
import 'package:polls/debug/debug_mode.dart';

Trace _myTrace;

void startLogger() {
  _myTrace = FirebasePerformance.instance.newTrace("loggin session");
  _myTrace.start();
  FirebasePerformance.instance.setPerformanceCollectionEnabled(true);
}

void stopLogger() {
  _myTrace.stop();
}

void log({String name, String value = "empty"}) {
  runInDebug(() => _myTrace.putAttribute(name, value));
}
