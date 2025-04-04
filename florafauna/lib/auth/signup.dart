
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:florafauna/auth/signin.dart';
import 'package:florafauna/model/usermodel.dart';
import 'package:florafauna/view/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool usercreated =false;
  var uuid = const Uuid();
final ImagePicker _imagepicker=ImagePicker();
File? ima;
  
  void Imagepicker()async{
    
XFile? image = await _imagepicker.pickImage(source: ImageSource.gallery);
if(image!=null)
{
  File selectedimage=File(image.path);
  print("ImagePicker image :: ${selectedimage.toString()}");
  setState(() {
    ima=File(image.path);
    uploadImageToFirebase();
  });
}


  }

Future<String?> uploadImageToFirebase() async {
  if (ima == null) return null;

  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
      .ref()
      .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

  firebase_storage.UploadTask uploadTask = ref.putFile(
    File(ima!.path),
    firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
  );

  firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
  String downloadUrl = await taskSnapshot.ref.getDownloadURL();

  return downloadUrl;
}

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

Future<void> addusername()async{
try {
  Usermodel user =Usermodel(uid: uuid.v4(),email: emailcontroller.text.trim(),username: namecontroller.text.trim());

  await FirebaseFirestore.instance.collection('User').add(user.tojson());
} catch (e) {
  print(e);
}

}

Future<void> signup(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    setState(() {
      usercreated = !usercreated;
    });

    if (usercreated) {
      addusername();
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Landingpage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign Up not successful')),
      );
    }
  } catch (e) {
  print(e);
  }
}

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
          title: Padding(
          
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text('Sign Up',style: TextStyle(color: Colors.white),),
      ),
      
    
      
    ),
        backgroundColor: Colors.black,
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                          SizedBox(height: 100,),
                                      GestureDetector(
                      onTap: () {
                        Imagepicker();
                      },
                      child: Container(
                          width: 100,
                          height: 100,
                        
                          decoration: BoxDecoration(
                            border: Border.all(width: 2,color: Colors.white),
                            color: Colors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: ima != null
                                  ? FileImage(ima!) as ImageProvider
                                  : const NetworkImage("https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg"),
                              fit: BoxFit.cover, // Ensures the image fills the container properly
                            
                            )
                            ,
                          ),
                        ),
                                      ),
                        SizedBox(height: 20,),
                                       TextField(
                      controller: namecontroller,
                        autocorrect: true,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Enter Your Name",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none)),
                      ),
                      SizedBox(
                        height: 10,
                      ),    
                                       
                      TextField(
                        
                      controller: emailcontroller,
                        autocorrect: true,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Enter Your Email",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        
                      controller: passwordcontroller,
                        autocorrect: true,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Enter Your Password",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                                     
                        
                                    
                      SizedBox(height: 10,),
                       Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [Colors.green,Colors.greenAccent])),
                         child: ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            backgroundColor: WidgetStateProperty.all(Colors.transparent
                            
                            ),minimumSize: WidgetStateProperty.all(Size(double.infinity, 55))),
                          
                          onPressed: (){
                            signup(emailcontroller.text.trim(), passwordcontroller.text.trim());
                          }, child: Text('Sign up',style: TextStyle(color: Colors.black),)),
                       ),]),
                    ),
                  ),
      
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0,top: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an Account?',style: TextStyle(color: Colors.white),),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Signin()));
                    },
                    child: Text('Sign In',style: TextStyle(color:Colors.greenAccent),)),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,)
                ],
                
              ),
            )));
  }
}
