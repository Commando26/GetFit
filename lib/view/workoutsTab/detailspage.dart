import 'package:firstapp/models/subcategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../other/config.dart';
class DetailsPage extends StatefulWidget{
SubCategory subCategory;

DetailsPage({required this.subCategory});

  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title:  Text('Workout Details'),
          automaticallyImplyLeading: false,
          actions: <Widget>[Container()],
          //backgroundColor: Colors.transparent,
          //elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
            child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.all(20),
                      height: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage('assets/howto/' + widget.subCategory.imgName + '.gif'),
                              fit: BoxFit.cover
                          )
                      )
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Text('Benefits Here', // replace with path or call
                        style: TextStyle(fontSize: 18
                        ),
                       ),
                  ),
                  ElevatedButton(
                      child: Text('Add to Plan',
                          style: TextStyle(
                              fontSize: 20
                          )
                      ),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black,
                        primary: currentTheme.textColor,
                      ),
                      onPressed: () {
                        // adds exercise to workoutList for now
                        // unsure on 'widget.subCategory.name' for right now
                        //workoutList.add(widget.subCategory.name);
                      }),
                ]
          )
        )
      );
  }



}