import 'package:brew_crew/custom_classes/custom_classes/decorations.dart';
import 'package:brew_crew/custom_classes/custom_classes/user.dart';
import 'package:brew_crew/services/database/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class update_brew_preference extends StatefulWidget
{

  String? userid;

  update_brew_preference({this.userid});

  @override
  _update_brew_preferenceState createState() => _update_brew_preferenceState();

}

class _update_brew_preferenceState extends State<update_brew_preference>
{
  static final _form_key = GlobalKey<FormState>();

  //HOLDS THE UPDATED DATA IN THE UPDATE BREW PREFERENCES PAGE;
  String? person_name;
  String? sugars;
  int? strength;

  final num_sugars=['0','1','2','3','4','5'];

  @override
  Widget build(BuildContext context) {
                                      return Column(
                                                    children:[
                                                              SizedBox(height:5.0),
                                                              Text("Update Brew Preferences",style:TextStyle(color:Colors.green,fontWeight:FontWeight.bold,fontSize:20.0)),
                                                              SizedBox(height:20.0),
                                                              Padding(
                                                                padding: const EdgeInsets.all(10.0),
                                                                child: StreamBuilder<user_data>(
                                                                  stream:database(user_id:widget.userid).get_user_preferences(),
                                                                  builder: (context, snapshot)
                                                                  {
                                                                    if(snapshot.connectionState==ConnectionState.active)
                                                                    {
                                                                      //update the brew preferences screen  data with the latest user data ;
                                                                      if(snapshot.hasData)
                                                                        {       print("YES DATA");
                                                                                user_data? userdata=snapshot.data??user_data(sugar:null,name:null,strength:null);
                                                                                return Form(
                                                                                    key:_form_key,
                                                                                    child:Column(mainAxisAlignment:MainAxisAlignment.end,
                                                                                        children: [
                                                                                          TextFormField(initialValue:userdata.name??'',validator:(name)=>name!.isEmpty?"Enter a valid name":null,onChanged:(name){setState(() {person_name=name;});},decoration:decorations().formDecor().copyWith(hintText:"Enter you name"),style:TextStyle(color:Colors.white),)
                                                                                          ,
                                                                                          SizedBox(height:10.0)
                                                                                          ,
                                                                                          DropdownButton(value:sugars??userdata.sugar // value to be displayed in dropdown text field
                                                                                                          ,
                                                                                                          items:num_sugars.map(
                                                                                                                                (sugars) =>
                                                                                                                                DropdownMenuItem(
                                                                                                                                                    value:sugars,
                                                                                                                                                    child:Text("${sugars} sugars" )
                                                                                                                                                )
                                                                                                                              ).toList()
                                                                                                          ,
                                                                                                          onChanged:(value)
                                                                                                          {
                                                                                                            setState (
                                                                                                                          ()  {
                                                                                                                                sugars=value as String?;
                                                                                                                              }
                                                                                                                      );
                                                                                                          }
                                                                                                      )
                                                                                          ,
                                                                                          SizedBox(height:10.0)
                                                                                          ,
                                                                                          Slider(value:(strength??userdata.strength)!.toDouble(),
                                                                                              min:100.0,
                                                                                              max:900.0,
                                                                                              divisions:8,
                                                                                              activeColor:Colors.brown[(strength??userdata.strength)!],
                                                                                              inactiveColor:Colors.brown[(strength??userdata.strength)!],
                                                                                              onChanged:(val){setState(() {strength=val.round();});})
                                                                                          ,
                                                                                          SizedBox(height:10.0)
                                                                                          ,//while clicking on update,incase the user has not updated the data ,all the (sugars,person_name,strength) will be null which we cant pass for updating data,so in that
                                                                                          //case we pass the original data itself.
                                                                                          TextButton(onPressed:(){database(user_id:widget.userid).update_user_data(sugars??userdata.sugar,person_name??userdata.name,strength??userdata.strength); Navigator.pop(context); }, child:Text("UPDATE",style:TextStyle(color:Colors.black87,fontWeight:FontWeight.bold)),style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.redAccent)),)
                                                                                        ]
                                                                                    )
                                                                                );
                                                                              }

                                                                        else
                                                                        {print("NO DATA");
                                                                          return Center(child: SpinKitCircle(color:Colors.red,size:30.0));
                                                                        }

                                                                    }

                                                                    else
                                                                      {return Center(child: SpinKitCircle(color:Colors.red,size:30.0));}
                                                                  }
                                                                ),
                                                              )
                                                              ]
                                                    );
                                     }


}

