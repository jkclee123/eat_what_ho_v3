import 'package:flutter/material.dart';
import 'package:eat_what_ho_v3/data.dart';
import 'package:eat_what_ho_v3/suggestion_screen.dart';
import 'package:location/location.dart';
import 'package:simple_permissions/simple_permissions.dart';

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _initLocationListener,
          )
        ]
      ),
      body: Container(
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
              currentLocation != null ?
                new RaisedButton(
                  onPressed: _localSearch,
                  child: Text(
                    "Local Search",
                    style: font14black,
                  ),
                )
                :
                new OutlineButton(
                  onPressed: _initLocationListener,
                  child: Text(
                    "Press to Locate",
                    style: font14white,
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
    else _initLocationListener();
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
          currentLocation = result;
          if (currentLocation != null) {
            locationSubscription.cancel();
            resetSuggestion();
          }
        });
        print(currentLocation.toString());
      });
    });
  } 

  @override
  void dispose(){
    super.dispose();
    locationSubscription.cancel();
  }

  _chooseDistricts(){
    searchMode = false;
  }

  _localSearch(){
    searchMode = true;
    Navigator.push(context, MaterialPageRoute(builder: (context) => SuggestionScreen()));
  } 
}