import 'package:flutter/material.dart';
import 'package:eat_what_ho_v3/data.dart';
import 'package:url_launcher/url_launcher.dart';

class SavedScreen extends StatefulWidget{
  @override
  SavedScreenState createState() => new SavedScreenState();
}

class SavedScreenState extends State<SavedScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.signal_wifi_4_bar),
            onPressed: _webPage,
          )
        ]
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) => _horizontalSwipe(details),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i){
            int index = i ~/ 2; 
            if (savedList.length > index) {
              if (i.isOdd) return Divider();
              return _buildRow(savedList[index]);
            }
          }
        )
      ),
    );
  }

  Widget _buildRow(int index){
    return Dismissible(
      key: Key(index.toString()),
      onDismissed: (direction) => _removeSaved(index),
      child: ListTile(
        title: Text(
          restaurantList[index].name,
          style: font18black,
        ),
      ),
    );
  }

  void _removeSaved(int index){
    if (savedList.contains(index)){
      setState(() {
        savedList.remove(index);      
      });
    }
  }

  void _horizontalSwipe(DragEndDetails details){ 
    if (details.primaryVelocity == 0) return;
    //swipe right
    if (details.primaryVelocity.compareTo(0) == 1){
      Navigator.of(context).pop();
    }
  }

  _webPage() async{
    for (var saved in savedList){
      if (await canLaunch(restaurantList[saved].url)) await launch(restaurantList[saved].url); 
    }
  }

}