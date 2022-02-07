import '../custom_classes/custom_classes/decorations.dart';
import 'package:brew_crew/screens/loading.dart';
import '../services/authentication/auth.dart';
import 'package:flutter/material.dart';


class authenticate extends StatefulWidget
{
  @override
  State<authenticate> createState() => _authenticateState();
}

class _authenticateState extends State<authenticate> {


  decorations decoration=decorations();

  String Email=' ';
  String Password=' ';

  bool Loading=false;
  String error='';

  static final _key=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return Loading==true?loading():Scaffold(backgroundColor:Colors.brown[200],
                    appBar:AppBar(
                                  title:Text("Sign In",style:TextStyle(color:Colors.yellowAccent,fontWeight:FontWeight.bold)),
                                  centerTitle:true,
                                  elevation:0.0,
                                  backgroundColor:Colors.black,
                                  actions:[TextButton.icon(onPressed:()async{Navigator.pushNamed(context,"/register");},icon:Icon(Icons.person), label:Text("Register",style:TextStyle(color:Colors.red)))]
                                 ),


                    body:Container(
                      decoration:decoration.boxDecor(),
                      child: Padding(
                                      padding: const EdgeInsets.fromLTRB(65.0,0.0,65.0,42.0),
                                      child: Form(key:_key,
                                        child: Column(mainAxisAlignment:MainAxisAlignment.center,

                                         children: [Text("Brew Crew App",style:TextStyle(color:Colors.black,fontWeight:FontWeight.bold,fontSize:40.0))
                                           ,
                                           SizedBox(height:30.0)
                                           ,
                                           TextFormField(decoration:decoration.formDecor().copyWith(hintText: "EMAIL"),validator:(email)=>email!.isEmpty?"Invalid Email":null,onChanged: (username){Email=username;},style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold))
                                          ,
                                           SizedBox(height:10.0)
                                          ,
                                           TextFormField(decoration:decoration.formDecor().copyWith(hintText:"PASSWORD"),validator:(password)=>password!.length<6?"Password too short":null,onChanged:(password){Password=password;},obscureText:true,style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold)),

                                           SizedBox(height:10.0),

                                           ElevatedButton(onPressed:() async
                                                                                {
                                                                                  if(_key.currentState!.validate()==true)
                                                                                  {
                                                                                    setState(() {
                                                                                      Loading=true;
                                                                                    });
                                                                                    auth _authentication=auth();
                                                                                    dynamic response_userdata=await _authentication.signinwithemailandpassword(Email,Password);

                                                                                    if(response_userdata == null)
                                                                                    {
                                                                                      setState(() {
                                                                                        Loading=false;
                                                                                        error="Invalid Credentials";
                                                                                      });

                                                                                    }
                                                                                   }
                                                                                },
                                                                    style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.black))
                                                                    ,child:Text("Sign in",style:TextStyle(color:Colors.greenAccent,fontWeight:FontWeight.bold)
                                                                   )
                                                                  )
                                                             ,Text(error,style:TextStyle(color:Colors.red[800],fontWeight:FontWeight.bold,letterSpacing:2.0))
                                                    ],
                                                  ),
                                      ),
                                     ),
                    )
                    );
  }
}
