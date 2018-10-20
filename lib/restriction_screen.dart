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
        onVerticalDragEnd: (DragEndDetails details) => _verticalSwipe(details),
        child: new Container(
          padding: const EdgeInsets.all(16.0),
          width: screenSize.width,
          height: screenSize.height,
          color: Colors.blueGrey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Text(
                "It's",
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
                      style: font18black,
                    ),
                  ),
                  new RaisedButton(
                    onPressed: () => _tooExpensive(),
                    child: Text(
                      "Too Expensive",
                      style: font18black,
                    ),
                  ),
                ]
              ),
              new Text(
                "I Hate:",
                style: font26white,
              ),
              new Column(
                children: _cuisineButtons(),
              ),
            ],
          )
        ),
      ),
    );
  }

  List<Widget> _cuisineButtons(){
    List<Widget> returnList = new List<Widget>();
    for (var cuisine in cuisineList){
      returnList.add(
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new OutlineButton(
              onPressed: () => _blackList(cuisine),
              child: Text(
                cuisine,
                style: font18white,
              ),
            )
          ],
        ),
      );
    }
    return returnList;
  }

  void _blackList(String cuisine){
    cuisineBlackList.add(cuisine);
    nextSuggestionData(this);
    Navigator.of(context).pop();
  }

  _tooFar(){
    if (searchMode == 2){
      maxDistance = maxDistance > distance ? distance : maxDistance;
      print(maxDistance);
    } else {
      int distanceFromMTR = int.tryParse(restaurantList[pos].mtr.split("-")[0]) ?? 99;
      maxDistanceFromMTR = maxDistanceFromMTR > distanceFromMTR ? distanceFromMTR : maxDistanceFromMTR;
    }
    nextSuggestionData(this);
    Navigator.of(context).pop();
  }

  _tooExpensive(){
    double price = double.parse(restaurantList[pos].price.split("\$")[1]);
    maxPrice = maxPrice > price ? price : maxPrice;
    nextSuggestionData(this);
    Navigator.of(context).pop();
  }
  
  void _verticalSwipe(DragEndDetails details){
    if (details.primaryVelocity == 0) return;
    if (details.primaryVelocity.compareTo(0) == 1){
      Navigator.of(context).pop();
    }
  }

  void initState(){
    super.initState();
    cuisineList.clear();
    cuisineList = new List<String>.from(restaurantList[pos].cuisine);
  }
}