import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'app.dart';

void main() {
//  debugRepaintRainbowEnabled = false;
  runApp(MyApp());
}

class ConnectivityOverlay {
  static final ConnectivityOverlay _singleton = ConnectivityOverlay._internal();

  factory ConnectivityOverlay() {
    return _singleton;
  }
  ConnectivityOverlay._internal();

  static OverlayEntry overlayEntry;

  void showOverlay(BuildContext context, Widget child) {
    // реализуйте отображение Overlay.
    overlayEntry?.remove();
    overlayEntry = OverlayEntry(builder: (context) => child);
    Overlay.of(context).insert(overlayEntry);
  }

  void removeOverlay(BuildContext context) {
    // реализуйте удаление Overlay.
    overlayEntry?.remove();
    overlayEntry=null;
  }
}
