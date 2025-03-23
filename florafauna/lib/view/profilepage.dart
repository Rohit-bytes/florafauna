import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:florafauna/model/usermodel.dart';
import 'package:florafauna/providers/profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Profileprovider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      value.pickImage(ImageSource.gallery);
                    },
                    child: CircleAvatar(
                      radius: 95,
                      backgroundColor: Colors.white,
                      child: value.imageFile == null
                          ? Icon(Icons.image, color: Colors.black)
                          : ClipOval(
                              child: Image.file(
                                value.imageFile!,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ProfileInfoTextField(label: "Name", controller: value.name),
                ProfileInfoTextField(label: "Email", controller: value.email),
                ProfileInfoTextField(label: "Phone", controller: value.number),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle().copyWith(backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  onPressed: () {
                    Usermodel usermodel = Usermodel(uid: FirebaseAuth.instance.currentUser!.uid,
                    email: value.email.text,
                    phone: value.number.text,
                    username: value.name.text,
                    
                    );
                    FirebaseFirestore.instance.collection("User").doc(usermodel.uid).set(usermodel.tojson(),SetOptions(merge: true));
                  }, 
                  child: Text("Update Changes",style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfileInfoTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const ProfileInfoTextField({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[900],
        ),
      ),
    );
  }
}
