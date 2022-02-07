import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loading extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return Container( color:Colors.greenAccent
                      ,
                      child:Center(
                                    child:Column(
                                                 mainAxisAlignment:MainAxisAlignment.center,
                                                  children:[
                                                              SpinKitWave(color:Colors.white,size:50.0)
                                                           ]
                                                )

                                  ),
                    );
  }
}
