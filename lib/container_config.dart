import 'package:flutter/material.dart';

class ContainerConfig with ChangeNotifier {
  double _width = 200;
  double _height = 200;
  double _borderRadius = 20;

  double get width => _width;
  double get height => _height;
  double get borderRadius => _borderRadius;

  void updateWidth(double newWidth) {
    _width = newWidth;
    notifyListeners();
  }

  void updateHeight(double newHeight) {
    _height = newHeight;
    notifyListeners();
  }

  void updateBorderRadius(double newBorderRadius) {
    _borderRadius = newBorderRadius;
    notifyListeners();
  }
}
