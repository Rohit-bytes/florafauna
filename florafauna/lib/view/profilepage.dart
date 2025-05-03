import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:florafauna/model/usermodel.dart';
import 'package:florafauna/providers/profile.dart';
import 'package:florafauna/view/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  String globalname = "";
  bool loggingout = false;

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('User')
          .where("uid", isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data() as Map<String, dynamic>;
        globalname = data['username'] ?? 'No name';

        final profileProvider = Provider.of<Profileprovider>(context, listen: false);
        profileProvider.name.text = globalname;
      

  setState(() {});
      }
    } catch (e) {
      print('Error fetching current user: $e');
    }
  }

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
                  child: CircleAvatar(
                    radius: 95,
                    backgroundColor: Colors.greenAccent,
                    child: globalname.isNotEmpty
                        ? Text(
                            globalname[0].toUpperCase(),
                            style: TextStyle(fontSize: 50, color: Colors.black),
                          )
                        : Icon(Icons.person, color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                ProfileInfoTextField(label: "Name", controller: value.name),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: () {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser == null) {
                          // Handle the case where no user is signed in
                          print("No user is currently signed in.");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("No user is signed in. Please log in first.")),
                          );
                          return;
                        }
                    
                        Usermodel usermodel = Usermodel(
                          uid: currentUser.uid,
                          username: value.name.text,
                        );
                    
                        FirebaseFirestore.instance
                            .collection("User")
                            .doc(usermodel.uid)
                            .set(usermodel.tojson(), SetOptions(merge: true))
                            .then((_) {
                          print("User data updated successfully.");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Profile updated successfully.")),
                          );
                        }).catchError((error) {
                          print("Error updating user data: $error");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Failed to update profile. Please try again.")),
                          );
                        });
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 20),

                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                  onPressed: () async {
  setState(() {
    loggingout = true;
  });

  try {
    await FirebaseAuth.instance.signOut();
    setState(() {
      loggingout = false;
      value.name.clear();
    });

    if (FirebaseAuth.instance.currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You have been signed out successfully."),
        ),
     );
    
       await  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Landingpage()));
     
    }
  } catch (e) {
    setState(() {
      loggingout = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("An error occurred while signing out. Please try again."),
      ),
    );
  }
},

                   child: Row(
                      children: [
                        loggingout? Container(
                          height: 10,
                          width: 10 ,
                          child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)): Icon(Icons.logout,color: Colors.white,),
                        SizedBox(width: 5),
                        Text("Logout",style: TextStyle(color: Colors.white),),
                      ],
                    )),
                 SizedBox(width: 20),
                  ],
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
