import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/custom_classes/custom_classes/brew.dart';
import 'package:brew_crew/custom_classes/custom_classes/user.dart';


class database
{
  final CollectionReference brew_collection=Firestore.instance.collection("brew-preferences");
  String? user_id;

  database({this.user_id});


  //Creating User data with some initial values when the user registers for the first time;
  Future  create_brew_data(String sugar,String name,int strength) async
  {

    return await brew_collection.document(user_id).setData({"Sugar":sugar,"Name":name,"Strength":strength});

  }





  //UPDATING USER DATA

  Future update_user_data(String? sugar,String? name,int? strength) async
  {
    return await brew_collection.document(user_id).updateData({"Sugar":sugar??'0',"Name":name??'NEW CREW MEMBER',"Strength":strength??100});
  }






  //This is same as onauthstatuschanged which gets the present authentication status of the user.

  //Similarly QuerySnapshot gets the latest database(snapshot) in firestore.

  List<brew> convert_to_brew_objects(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((document)=>brew(sugar:document.data["Sugar"]?? '0',name:document.data["Name"]?? '',strength:document.data["Strength"]?? 100)).toList();
  }

  Stream<List<brew>> get_brew_data()
  {
    return brew_collection.snapshots().map((snapshot)=>convert_to_brew_objects(snapshot));
  }




  //document snapshot gives the snapshots of the current document of the user rather than the entire document as a whole;

  user_data convert_to_user_data(DocumentSnapshot snapshot)
  {
    return user_data(userid:user_id,sugar:snapshot.data['Sugar']??'0',name:snapshot.data["Name"],strength:snapshot.data['Strength']);
  }


  Stream<user_data> get_user_preferences()
  {
    return brew_collection.document(user_id).snapshots().map((snapshot)=>convert_to_user_data(snapshot));
  }

}


