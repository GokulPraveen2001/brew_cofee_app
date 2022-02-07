import 'package:flutter/material.dart';
import 'package:brew_crew/custom_classes/custom_classes/brew.dart';

class brew_data extends StatefulWidget {

   List<brew> Brew_Data;


  brew_data({required this.Brew_Data});

  @override
  _brew_dataState createState() => _brew_dataState();
}

class _brew_dataState extends State<brew_data>
{
  @override
  Widget build(BuildContext context)
  {
    List<brew> brewData=widget.Brew_Data;

    for (var i in brewData)
      {
        print(i.name);
        print(i.strength);
        print(i.sugar);
      }

    return ListView.builder(itemCount:brewData.length,
                      itemBuilder:(context,index)
                                                  {
                                                    return ListTile(onTap:(){},
                                                                    title:Text(brewData[index].name,style:TextStyle(color:Colors.black87,fontWeight:FontWeight.bold,letterSpacing:2.0)),
                                                                    subtitle:Text(brewData[index].sugar,style:TextStyle(color:Colors.green[600],fontWeight:FontWeight.bold,letterSpacing:2.0)),
                                                                    leading:CircleAvatar(foregroundColor:Colors.brown[brewData[index].strength],backgroundColor:Colors.brown[brewData[index].strength],radius:25.0)
                                                                  );
                                                  }
    );

  }
}
