import 'package:flutter/material.dart';
import 'package:flutter_app_rate_interest/src/ui/FavouriteCity.dart';
import 'package:flutter_app_rate_interest/src/ui/SimpleInterestCal.dart';

void main() => runApp(myApp());

MaterialApp myApp() {
  return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.deepPurple,
          accentColor: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      title: "State full Example",
      home: SimpleInterestCal());
}
