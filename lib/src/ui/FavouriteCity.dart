import 'package:flutter/material.dart';

class FavouriteCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateFavouriteCity();
  }
}

class _StateFavouriteCity extends State<FavouriteCity> {
  String cityName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('State Full App Example'),
      ),
      body: Container(
        color: Colors.deepPurple,
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
                style: TextStyle(
                    color: Colors.white
                ),
                decoration: InputDecoration(

                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
                cursorColor: Colors.white,
                onChanged: (String userInput) {
                  setState(() {
                    cityName = userInput;
                  });
                }),
            Padding(
              child: Text('Your best city is $cityName'),
              padding: EdgeInsets.all(12.0),
            )
          ],
        ),
      ),
    );
  }
}