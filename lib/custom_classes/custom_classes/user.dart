class userinfo
{
  //final:Indicates that the variable is immutable and hence cannot be changed
   final String? userid;
    final bool? isanonymous;

  userinfo({this.userid,this.isanonymous});//by default its implicit value is null;
}

class user_data
{
  String? userid;
  String? sugar;
  String? name;
  int? strength;

  user_data({this.userid,this.sugar,this.name,this.strength});

}