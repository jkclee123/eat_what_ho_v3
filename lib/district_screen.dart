import 'package:flutter/material.dart';
import 'package:eat_what_ho_v3/data.dart';
import 'package:eat_what_ho_v3/suggestion_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DistrictScreen extends StatefulWidget{
  @override
  DistrictScreenState createState() => new DistrictScreenState();
}

class DistrictScreenState extends State<DistrictScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Districts"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: _clearDistricts,
          )
        ]
      ),
      body: Column(
        children: <Widget>[
          new TextField(
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search district',
              contentPadding: const EdgeInsets.all(16.0)
            ),
            controller: textController,
            onChanged: (String input){
              setState(() { 
                if (input == ""){ 
                  searchList = new List<String>.from(districtList);
                } else {
                  searchList.clear();
                  print(districtList.length);
                  for (var i = 0; i < districtList.length; i++){
                    if (districtList[i].toLowerCase().contains(input.toLowerCase())) searchList.add(districtList[i]);
                  }    
                }
              });
              print(searchList.toString());
            },
          ),
          new Flexible(
            child: GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) => _horizontalSwipe(details),
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, i){
                  int index = i ~/ 2; 
                  if (searchList.length > index) {
                    if (i.isOdd) return Divider();
                    return _buildRow(searchList[index]);
                  }
                }
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.search),
        onPressed: () {
          if (districtMap.containsValue(true)) {
            beforeDistrictMap.forEach((key, value){
              if (districtMap[key] != value){
                resetRestrictions();
                pos = -1;
                restaurantList.clear();
                history.clear();
                savedList.clear();
                endSearch = false;
              }
            });
            searchMode = 1;
            textController.text = "";
            searchList = new List<String>.from(districtList);
            Navigator.push(context, MaterialPageRoute(builder: (context) => SuggestionScreen()));
          } else {
            Fluttertoast.showToast(
              msg: "Pick a district :0)",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              bgcolor: "#797979",
              textcolor: '#ffffff'
            );
          }
        }
      )
    );
  }

  Widget _buildRow(String key){
    return CheckboxListTile(
      title: Text(
        key,
        style: font18black,
      ),
      value: districtMap[key],
      onChanged: (bool value){
        setState(() {
          districtMap[key] = value;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState(); 
    searchList = new List<String>.from(districtList);
  }

  @override
  void dispose(){
    super.dispose();
    textController.text = "";
    searchList = new List<String>.from(districtList);
  }

  void _clearDistricts(){
    setState(() {
      districtMap.updateAll((String key, bool value){
        return false;
      }); 
    });
  }

  void _horizontalSwipe(DragEndDetails details){ 
    if (details.primaryVelocity == 0) return;
    //swipe right
    if (details.primaryVelocity.compareTo(0) == 1){
      Navigator.of(context).pop();
    }
  }
}