import '../custom_classes/custom_classes/decorations.dart';
import 'package:brew_crew/screens/loading.dart';
import '../services/authentication/auth.dart';
import '../custom_classes/custom_classes/user.dart';
import 'package:flutter/material.dart';

class register_user extends StatefulWidget {

  String email=' ';
  String password=' ';

  @override
  _register_userState createState() => _register_userState();
}

class _register_userState extends State<register_user>
{

  decorations decoration=decorations();
  auth user=auth();

  bool Loading=false;
  String error='';

  final  _key=GlobalKey<FormState>();


 @override
  Widget build(BuildContext context)
  {

    return Loading==true?loading():Scaffold(backgroundColor:Colors.brown[200],
                    appBar:AppBar(
                                    title:Text("Sign Up",style:TextStyle(color:Colors.yellowAccent,fontWeight:FontWeight.bold)),
                                    centerTitle:true,
                                     elevation:0.0,
                                      backgroundColor:Colors.black,
                                      ),
                            body:Container(decoration:decoration.boxDecor(),
                              child: Padding(
                                              padding: const EdgeInsets.fromLTRB(65.0,0.0,65.0,42.0),
                                              child: Form(key:_key,
                                                          child: Column(mainAxisAlignment:MainAxisAlignment.center
                  ,                                                                 children: [ TextFormField(decoration:decoration.formDecor().copyWith(hintText:"EMAIL"),validator:(email)=>email!.isEmpty?"Enter email":null,
                                                                                                  onChanged: (email){widget.email=email;},
                                                                                                  style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold))
                                                                                                    ,
                                                                                                  SizedBox(height:10.0)
                                                                                                  ,
                                                                                                  TextFormField(decoration:decoration.formDecor().copyWith(hintText:"Password"),validator:(password)=>password!.length<6?"Password too short":null,
                                                                                                  onChanged:(password){widget.password=password;},obscureText:true,
                                                                                                  style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold)),

                                                                                                  SizedBox(height:10.0),

                                                                                                  ElevatedButton(onPressed:()async {
                                                                                                                  if(_key.currentState?.validate()==true)
                                                                                                                    {
                                                                                                                      setState(() {
                                                                                                                        Loading=true;
                                                                                                                      });

                                                                                                                      userinfo? user_data=await user.register_user(widget.email,widget.password);

                                                                                                                     if(user_data==null)
                                                                                                                     {
                                                                                                                        setState(() {
                                                                                                                                      Loading=false;
                                                                                                                                      error="Invalid Email/Password";
                                                                                                                                    });
                                                                                                                     }

                                                                                                                     else
                                                                                                                       {
                                                                                                                         Navigator.pop(context);
                                                                                                                       }

                                                                                                                    }
                                                                                                                  },
                                                                                                                style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.black)),child:Text("Register",style:TextStyle(color:Colors.greenAccent,fontWeight:FontWeight.bold))
                                                                                                  )
                                                              ,
                                                              SizedBox(height:20.0)
                                                              ,
                                                              Text(error,style:TextStyle(color:Colors.red[800],fontWeight:FontWeight.bold,letterSpacing:2.0))

                                                                            ],
                                                                      ),
                                                          ),
                                            ),
                            )
                  );
    }
}
