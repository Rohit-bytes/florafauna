
import 'package:florafauna/auth/signin.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text('Sign Up',style: TextStyle(color: Colors.white),),
      ),
      
      automaticallyImplyLeading: false,
      
    ),
        backgroundColor: Colors.black,
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                      SizedBox(height: 30,),
                  Container(
                    height: 250,
                    width: 250,
                    child: Image.asset("assets/applogo.png",)),
                 TextField(
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
                      
                      onPressed: (){}, child: Text('Sign up',style: TextStyle(color: Colors.black),)),
                   ),
      Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an Account',style: TextStyle(color: Colors.white),),
                SizedBox(width: 5,),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Signin()));
                  },
                  child: Text('Sign In',style: TextStyle(color:Colors.greenAccent),)),
              ],
            ),
          ),
          SizedBox(height: 20,)
                ],
                
              ),
            )));
  }
}
