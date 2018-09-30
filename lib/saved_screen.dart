import 'package:flutter/material.dart';
import 'package:eat_what_ho_v3/data.dart';
// import 'package:eat_what_ho_v3/restaurant.dart';
// import 'package:eat_what_ho_v3/transition.dart';

class SavedScreen extends StatefulWidget{
  @override
  SavedScreenState createState() => new SavedScreenState();
}

class SavedScreenState extends State<SavedScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Saved")),
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
        // trailing: GestureDetector(
        //   onTap: () => _removeSaved(index),
        //   child: Icon(Icons.cancel),
        // ),
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
}