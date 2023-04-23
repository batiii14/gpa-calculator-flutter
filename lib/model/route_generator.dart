import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:gpa_calculator/model/average_info.dart';
import 'package:gpa_calculator/model/ders_bilgileri.dart';
import 'package:gpa_calculator/model/ders_notlarini_al.dart';

class RouteGenerator {
  static Route<dynamic>? _routeOlustur(
      Widget gidilecekWidget, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
          settings: settings, builder: (context) => gidilecekWidget);
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialPageRoute(
          settings: settings, builder: (context) => gidilecekWidget);
    } else {
      return CupertinoPageRoute(
          settings: settings, builder: (context) => gidilecekWidget);
    }
  }

  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case '/GiveMeTheLectureInfo':
        return _routeOlustur(const GiveMeTheLectureInfo(), settings);
      case '/GiveMeTheLectureMarks':
        final elemanSayisi = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) =>
              GiveMeTheLectureMarks(elemanSayisi: elemanSayisi),
        );

      case '/AverageInfo':
        return _routeOlustur(const AverageInfo(), settings);

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: const Center(
              child: Text(
                'Sayfa Bulunamadı',
                style: TextStyle(fontSize: 24),
              ),
            ),
            appBar: AppBar(
              title: const Text('404 Error'),
            ),
          ),
        );
    }
  }
}
