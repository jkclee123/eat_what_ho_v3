import 'package:flutter/material.dart';
import 'package:eat_what_ho_v3/data.dart';

class RestrictionScreen extends StatefulWidget{
  @override
  RestrictionScreenState createState() => new RestrictionScreenState();
}

class RestrictionScreenState extends State<RestrictionScreen>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text("Restriction"),
      ),
      body: new GestureDetector(
        child: new Container(
          width: screenSize.width,
          height: screenSize.height,
          color: Colors.purple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Text(
                "What do you think?",
                style: font26white,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new RaisedButton(
                    onPressed: () => _tooFar(),
                    child: Text(
                      "Too Far",
                      style: font16black,
                    ),
                  ),
                  new RaisedButton(
                    onPressed: () => null,
                    child: Text(
                      "Choose Districts",
                      style: font16black,
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new RaisedButton(
                    onPressed: () => null,
                    child: Text(
                      "Choose Districts",
                      style: font16black,
                    ),
                  ),
                  new RaisedButton(
                    onPressed: () => null,
                    child: Text(
                      "Choose Districts",
                      style: font16black,
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }

  _tooFar(){
    if (searchMode == 2){
      maxDistance = maxDistance > distance ? distance : maxDistance;
      print(maxDistance);
    } else {
      int distanceFromMTR = int.tryParse(restaurantList[pos].mtr.split("-")[0]) ?? 99;
      maxDistanceFromMTR = maxDistanceFromMTR > distanceFromMTR ? distanceFromMTR : maxDistanceFromMTR;
    }
    Navigator.of(context).pop();
  }
}