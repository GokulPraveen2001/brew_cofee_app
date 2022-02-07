import 'package:flutter/material.dart';
import 'wrapper/wrapper.dart';

import 'package:brew_crew/screens/sign_in.dart';
import 'package:brew_crew/screens/home.dart';
import 'package:brew_crew/screens/register_user.dart';

void main()
{


  runApp(
          MaterialApp(
              routes:{
                        "/":(context)=>wrapper(),
                        "/home":(context)=>home(),
                        "/signin":(context)=>authenticate(),
                        "/register":(context)=>register_user()
                    }
                    ),
        );
}

