import 'package:flutter/services.dart' as services;
import 'package:flutter/material.dart';

void cambiarStatusLight() {
  services.SystemChrome.setSystemUIOverlayStyle(
    services.SystemUiOverlayStyle.light,
  );
  services.SystemChrome.setSystemUIOverlayStyle(services.SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: services.Brightness.dark,
  ));
}

void cambiarStatusDark() {
  services.SystemChrome.setSystemUIOverlayStyle(
    services.SystemUiOverlayStyle.dark,
  );
  services.SystemChrome.setSystemUIOverlayStyle(services.SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: services.Brightness.light,
  ));
}
