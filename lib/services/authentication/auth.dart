import 'package:brew_crew/services/database/database.dart';

import '../../custom_classes/custom_classes/user.dart';
import 'package:firebase_auth/firebase_auth.dart';


class auth
{
  //Instance is similar to malloc in C.Each time it is called a new copy of the object is created rather than using the same object for each call which in turn overwrites the data.

    final FirebaseAuth _user =FirebaseAuth.instance; //_auth contains all the details of the user who is trying to sign in,sign  out or register;

  //anonymous sign in:
  Future signinanonymous() async
  {
    try
    {
      AuthResult result=await  _user.signInAnonymously();
      //The result is basically a token which contains all the user credentials if he has an account earlier else it will return null result.
      FirebaseUser user=result.user;

      userinfo user_info=userinfo(userid:user.uid,isanonymous:user.isAnonymous);
      return user_info;//can never be null as anonymous sign in always works;

    }

    catch(e)
    {
      print("Error:$e");
      return null;
    }

  }
///////////////////////////////////////////////
 // Sign in with email and password

  Future signinwithemailandpassword(String email,String password) async
  {
    try
    {
      AuthResult signin_response=await _user.signInWithEmailAndPassword(email:email, password:password);
      FirebaseUser user=signin_response.user;
      return user!=null?userinfo(userid:user.uid):null;
    }

    catch(e)
    {
      print("Sign in Error:${e.toString}");
      return null;
    }

  }
  /////////////////////////////////////////////
  //Register with email and password:

  //Note:While registering ,if the registration becomes successfull,then automatically the user is signed in and auth status is changed;
  Future register_user(String email,String password) async
  {
    try {
          AuthResult response = await _user.createUserWithEmailAndPassword(email: email, password: password);
          FirebaseUser user=response.user;
          await database(user_id:user.uid).create_brew_data("0","NEW CREW MEMBER",100);

          return userinfo(userid:user.uid);//this happens if the email or password is not in the prescribed format
        }


    catch(e)
    {
      print("Error registering user:${e.toString}");//this occurs when there is a connection error in sending and receiving requests
      return null;
    }
  }


  ////////////////////////////////////////////////////////////
  //Sign out

    Future signout() async
    {
      try
      {await _user.signOut();}

      catch(e)
      {
        print("Error Occurred:e");
      }
    }
///////////////////////////////////////////////////////////////

 Stream<userinfo?> get user_status
  {
    return _user.onAuthStateChanged.map(
                                        (FirebaseUser? user_status)=>user_status!=null?userinfo(userid:user_status.uid,isanonymous:user_status.isAnonymous):null);

  }

 ///////////////////////////////////////////////////////////////


}