class Usermodel {
   String? username;
   String? email;
   final String uid;
   String? phone;

  Usermodel({this.email,this.username,required this.uid, this.phone});

  factory Usermodel.fromjson(Map<String,dynamic> json){
    return Usermodel(email: json['email'] as String?, phone: json["phone"],username: json['username'] as String?,uid: json['uid']);
  }
Map<String,dynamic> tojson(){

  return{
    'email':email,
    'username':username,
    'uid':uid,
    'phone':phone,


  };
}

}