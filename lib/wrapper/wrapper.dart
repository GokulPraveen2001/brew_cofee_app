import 'package:brew_crew/screens/loading.dart';
import 'package:brew_crew/screens/sign_in.dart';
import 'package:brew_crew/screens/home.dart';
import '../custom_classes/custom_classes/user.dart';
import 'package:flutter/material.dart';
import '../services/authentication/auth.dart';



class wrapper extends StatefulWidget
{
  @override
  State<wrapper> createState() => _wrapperState();
}


class _wrapperState extends State<wrapper>
{
  Future<void> getstatus() async
  {
    await auth().user_status;
    setState(() {

    });
  }

  @override
  void initState()
  {
   getstatus();
    super.initState();
  }
  @override
    Widget build(BuildContext context)
    {
       return StreamBuilder<userinfo?>(stream:auth().user_status,
                                      builder:(context,snapshot)
                                                                {
                                                                  if(snapshot.connectionState==ConnectionState.active)//indicates that the tracking has started and data transfer is enabled
                                                                  {
                                                                    userinfo? user=snapshot.data;

                                                                    if(user==null)
                                                                      {
                                                                        return authenticate();
                                                                      }

                                                                    else
                                                                      {
                                                                        return home(userid:snapshot.data!.userid);//passing userid to the home screen for accessing data in multiple parts of the screen;
                                                                      }
                                                                  }

                                                                  //buffer time:Until tracking starts
                                                                    {
                                                                      return loading();
                                                                    }

                                                                }
                                                                );


   }
}
