class Usermodel {
   String? username;
   final String? uid;

  Usermodel({this.username, this.uid,});

  factory Usermodel.fromjson(Map<String,dynamic> json){
    return Usermodel(username: json['username'] as String?,uid: json['uid']);
  }
Map<String,dynamic> tojson(){

  return{
    'username':username,
    'uid':uid,


  };
}

}