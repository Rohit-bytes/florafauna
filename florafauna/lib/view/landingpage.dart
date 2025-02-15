import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:florafauna/auth/signin.dart';
import 'package:florafauna/view/donationpage.dart';
import 'package:florafauna/view/home.dart';
import 'package:florafauna/view/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  double _opacity = 1.0;
  int currentIndex = 0;

  final List<Widget> pages = [
    const Home(),
    const Donationpage(),
    const Profilepage(),
  ];

  final List<String> titles = ["Home", "Donations", "Profile"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(EvaIcons.arrowCircleLeft, color: Colors.white),
        ),
        title:
            Text(titles[currentIndex], style: TextStyle(color: Colors.white)),
        actions: [
          Icon(
            Icons.circle,
            color: Colors.white,
            size: 8,
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const Signin()));
            },
            onTapDown: (_) {
              setState(() {
                _opacity = 0.7; // Reduce opacity on tap
              });
            },
            onTapUp: (_) {
              setState(() {
                _opacity = 1.0; // Restore opacity when tap is released
              });
            },
            onTapCancel: () {
              setState(() {
                _opacity = 1.0; // Restore opacity if tap is canceled
              });
            },
            child: Opacity(
              opacity: _opacity,
              child: Container(
                height: 35,
                width: 90,
                decoration: BoxDecoration(
                    color:Colors.green,
                    borderRadius: BorderRadius.circular(50)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Log In',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(
                  'https://img.freepik.com/premium-photo/smiling-businessman-formal-wear-using-tablet-while-standing-rooftop_232070-1360.jpg',
                ),
              ),
            ),
          ),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor:Colors.green,
          selectedLabelStyle: TextStyle(fontSize: 1),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.black,
          iconSize: 30,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: '',
              backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
                backgroundColor: Colors.black,
                icon: Icon(Ionicons.pulse_sharp), label: ''),
            BottomNavigationBarItem(
                backgroundColor: Colors.black,
              icon: Icon(EvaIcons.person), label: ''),
          ],
        ),
      ),
    );
  }
}
