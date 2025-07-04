import 'package:florafauna/auth/forgotpassword.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:florafauna/auth/Signup.dart';
import 'package:florafauna/view/landingpage.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool isLoading = false;
  bool singin = false;
  
  Future<void> signinfunction(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    setState(() {
      singin = !singin;
    });
  }

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Landingpage()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.close, color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Container(
                        height: 250,
                        width: 250,
                        child: Image.asset("assets/applogo.png"),
                      ),
                      TextField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter Your Email",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        validator:  (value) => value!.isEmpty ? "Please enter your password" : null,
                        
                        controller: passwordcontroller,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Enter Your Password",
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()));
                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [Colors.green, Colors.greenAccent]),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(Colors.transparent),
                            minimumSize: WidgetStateProperty.all(Size(double.infinity, 55)),
                          ),
                          onPressed: () async{
                               if(emailcontroller.text.isEmpty || passwordcontroller.text.isEmpty) {
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all fields")));}
                         else{
                            setState(() {
                              isLoading = true;
                            });
                            await signinfunction(emailcontroller.text.trim(), passwordcontroller.text.trim());
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => Landingpage()));
                         setState(() {
                           isLoading = false;
                         });

                         }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isLoading
                                  ? Container(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,))
                                  : SizedBox.shrink(),
                                  SizedBox(width: 10),
                              Text(
                                'Sign In',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        
        
            Padding(
              padding: const EdgeInsets.only(bottom: 20,top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create new Account',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {

                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Signup()));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
