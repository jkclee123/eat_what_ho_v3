import 'package:flutter/material.dart';
import 'package:eat_what_ho_v3/data.dart';
import 'package:eat_what_ho_v3/restaurant.dart';
import 'package:eat_what_ho_v3/saved_screen.dart';
import 'restriction_screen.dart';
import 'package:eat_what_ho_v3/transition.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong/latlong.dart';
import 'dart:convert';

class SuggestionScreen extends StatefulWidget{
  @override
  SuggestionScreenState createState() => new SuggestionScreenState();
}

class SuggestionScreenState extends State<SuggestionScreen>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text("Suggestions"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _toSaveList,
          )
        ]
      ),
      body: restaurantList.isNotEmpty ? (endSearch ? _noSuggestion() : _suggestion()) : _loading(),
    );
  }

  Widget _noSuggestion(){
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      color: Colors.purple,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Text(
            "No More Restaurant :(",
            style: font26white,
          ),
          new RaisedButton(
            onPressed: _resetSuggestion,
            child: Text(
              "Restart Search",
              style: font16black,
            ),
          ),
        ],
      ),
    );
  }

  void _resetSuggestion(){
    resetRestrictions();
    setState(() {
      pos = -1;
      restaurantList.clear();
      history.clear();
      savedList.clear();
      endSearch = false;    
    });
  }

  Widget _loading(){
    _getRestaurantsFromJson();

    return Container(
      width: screenSize.width,
      height: screenSize.height,
      color: Colors.purple,
      child: Center(
        child: CircularProgressIndicator()
      )
    );
  }

  Widget _suggestion(){
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) => _horizontalSwipe(details),
      onDoubleTap: () => _saveRestaurant(),
      onVerticalDragEnd: (DragEndDetails details) => _verticalSwipe(details),
      child: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: Colors.purple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children:[
            new Text(
              restaurantList[pos].name,
              style: font36white,
            ),
            new Container(
              width: screenSize.height / 3.2,
              height: screenSize.height / 3.2,
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(restaurantList[pos].pic),
                ),
              ),
            ),
          ]
        )
      )
    );
  }

  void _horizontalSwipe(DragEndDetails details){ 
    if (details.primaryVelocity == 0) return;
    //swipe right
    if (details.primaryVelocity.compareTo(0) == 1){
      if (history.last == pos){
        _nextSuggestion();
      } else {
        setState(() {
          pos = history[history.indexOf(pos) + 1];
        });
      }
    }
    //swipe left
    else if (details.primaryVelocity.compareTo(0) == -1 && history.indexOf(pos) != 0){
      setState(() {
        pos = history[history.indexOf(pos) - 1];
      });
    }
  }

  void _verticalSwipe(DragEndDetails details){
    if (details.primaryVelocity == 0) return;
    if (details.primaryVelocity.compareTo(0) == -1){
      Navigator.of(context).push(
        SlideUpRoute(widget: RestrictionScreen()),
      );
    }
  }

  void _saveRestaurant(){
    if (!savedList.contains(pos)){
      savedList.add(pos);
      Fluttertoast.showToast(
        msg: "Saved <3",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        bgcolor: "#797979",
        textcolor: '#ffffff'
      );
    }
  }

  void _toSaveList(){
    Navigator.of(context).push(
      SlideRightRoute(widget: SavedScreen()),
    );
  }

  @override
  void dispose(){
    super.dispose();
    endSearch = false;
    beforeDistrictMap = new Map<String, bool>.from(districtMap);
  }

  void _nextSuggestion(){
    int i = ++pos;
    for (; i < restaurantList.length - 1; i++){
      if (searchMode == 2){
        //Local Search
        distance = Distance().as(LengthUnit.Meter, new LatLng(currentLocation["latitude"], currentLocation["longitude"]), restaurantList[i].latLng.latlng);
        if (distance > maxDistance) continue;
        break;
      } else{
        //District Search
        if (!districtMap[restaurantList[i].district]) continue;
        break;

      }
    }
    if (i >= restaurantList.length){
      setState(() {
        endSearch = true;        
      });
    } else {
      setState(() {
        pos = i;
        history.add(pos);
      }); 
    } 
  }

  void _getRestaurantsFromJson() async{
    String data = await rootBundle.loadString("assets/openrice_data.json");
    final result = json.decode(data);
    List<Restaurant> list = new List<Restaurant>();
    for (var obj in result){
      Restaurant restaurant = new Restaurant.fromJson(obj);
      list.add(restaurant);
    }
    list.shuffle();
    setState(() {
      restaurantList = list;
    });
    _nextSuggestion();
  }  
}