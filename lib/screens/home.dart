import 'package:flutter/material.dart';
import 'package:brew_crew/custom_classes/custom_classes/decorations.dart';
import 'package:brew_crew/screens/update_brew_preferences.dart';
import 'package:brew_crew/services/database/database.dart';
import '../services/authentication/auth.dart';
import 'brew_data.dart';
import 'package:brew_crew/screens/loading.dart';
import 'package:brew_crew/custom_classes/custom_classes/brew.dart';

class home extends StatefulWidget
{
  String? userid;

  home({this.userid});

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home>
{
  void OnSettingspressed(String? userid)
  {
    showModalBottomSheet(context:context,builder:(context)=>update_brew_preference(userid:userid));
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(appBar:AppBar(title:Text(
                                              "Home",
                                                style:TextStyle(color:Colors.greenAccent)
                                            ),
                                  backgroundColor:Colors.black,
                                  elevation:0.0,
                                  centerTitle:true,
                                  actions: [TextButton.icon(onPressed:(){OnSettingspressed(widget.userid);},icon:Icon(Icons.settings),label:Text("Settings",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,letterSpacing:2.0)))
                                  ,
                                  TextButton.icon(onPressed:()async {await auth().signout();}, icon:Icon(Icons.person), label:Text("Sign Out",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold)))],
                                  )
                      ,
                      body:Container( decoration:decorations().home_page_decor(),
                                      child: StreamBuilder<List<brew>>  (
                                                                        stream:database().get_brew_data(),
                                                                        builder: (context, snapshot) {
                                                                                                       if(snapshot.connectionState==ConnectionState.active)
                                                                                                         {
                                                                                                           if(snapshot.hasData)
                                                                                                           {return brew_data(Brew_Data:snapshot.data??[]);}

                                                                                                           else
                                                                                                             {return loading();}
                                                                                                         }

                                                                                                       else
                                                                                                         {return loading();}
                                                                                                     }
                                                                      ),
                                    )

                    );
  }
}

