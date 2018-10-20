import 'package:flutter/material.dart';
import 'package:eat_what_ho_v3/data.dart';
import 'package:eat_what_ho_v3/suggestion_screen.dart';
import 'package:location/location.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:eat_what_ho_v3/district_screen.dart';

import 'package:latlong/latlong.dart';

class ModeScreen extends StatefulWidget{
  @override
  ModeScreenState createState() => new ModeScreenState();
}

class ModeScreenState extends State<ModeScreen>{
  @override
  Widget build(BuildContext context){
    setState((){
      screenSize = MediaQuery.of(context).size;
    });

    return new Scaffold(
      appBar: AppBar(
        title: Text("Eat What Ho"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: screenSize.width,
        height: screenSize.height,
        color: Colors.purple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
          new Text(
            "Choose Search Mode",
            style: font26white,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new RaisedButton(
                onPressed: _chooseDistricts,
                child: Text(
                  "Choose Districts",
                  style: font14black,
                ),
              ),
              new RaisedButton(
                onPressed: _localSearch,
                child: Text(
                  "Local Search",
                  style: font14black,
                ),
              )
          ],)
        ],)
      )
    );
  }

  @override
  void initState(){
    super.initState();
    _checkPermission();
  }

  void _checkPermission() async {
    bool res = await SimplePermissions.checkPermission(Permission.AccessFineLocation);
    if (res == false) _requestLocationPermission();
    // else _initLocationListener();
  }

  void _requestLocationPermission() async {
    final result = await SimplePermissions.requestPermission(Permission.AccessFineLocation);
    if (result.toString().compareTo(PermissionStatus.authorized.toString()) == 0) _initLocationListener();
    else _requestLocationPermission();
  }    

  void _initLocationListener(){
    setState(() {
      locationSubscription = Location().onLocationChanged().listen((Map<String,double> result) async{
        setState(() {
          if (currentLocation.isEmpty) {
            _resetSuggestion();
            currentLocation = result;
          } else {
            num d = Distance().as(LengthUnit.Meter, new LatLng(currentLocation["latitude"], currentLocation["longitude"]), new LatLng(result["latitude"], result["longitude"]));
            if (d > 200){
              currentLocation = result;
              _resetSuggestion();
            }
          }
          
          locationSubscription.cancel();
          if (searchMode == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SuggestionScreen()));
          }
        });
      });
    });
  } 

  @override
  void dispose(){
    super.dispose();
    locationSubscription.cancel();
  }
  
  void _resetSuggestion(){
    resetRestrictions();
    pos = -1;
    restaurantList.clear();
    history.clear();
    savedList.clear();
    endSearch = false;
  }

  _chooseDistricts(){
    if (searchMode == 2) _resetSuggestion();
    searchMode = 1;
    Navigator.push(context, MaterialPageRoute(builder: (context) => DistrictScreen()));    
  }

  _localSearch(){
    if (searchMode == 1) _resetSuggestion();
    searchMode = 2;
    _initLocationListener();
  } 
}