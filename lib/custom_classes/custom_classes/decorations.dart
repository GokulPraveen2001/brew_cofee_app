import 'package:flutter/material.dart';

class decorations
{
  //Box Decoration:


  BoxDecoration boxDecor()
  {
    return const BoxDecoration(image:DecorationImage(image:AssetImage("assets/cofee.jpg"),fit:BoxFit.fill));
  }

  BoxDecoration home_page_decor()
  {
    return BoxDecoration(image:DecorationImage(image:AssetImage('assets/coffee_bg.png')));
  }
  //Form Field Decoration:

  InputDecoration formDecor()
  {
    return const InputDecoration(
                            hintStyle:TextStyle(color:Colors.white,fontWeight:FontWeight.bold),
                            filled:true,
                            fillColor:Colors.black87,
                            enabledBorder:OutlineInputBorder(borderSide:BorderSide(color:Colors.black87,width:2.0)),
                            focusedBorder:OutlineInputBorder(borderSide:BorderSide(color:Colors.white,width:2.0))
                          );
  }


}
