import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
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
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const CircleAvatar(
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            height: 70,
            child: BottomNavigationBar(
            
              backgroundColor: Colors.white,
              currentIndex: currentIndex,
              selectedItemColor: Colors.green,
             
              selectedLabelStyle: TextStyle(fontSize: 1),
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.shifting,
              iconSize: 30,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: '',),
                BottomNavigationBarItem(
                    icon: Icon(Ionicons.pulse_sharp), label: ''),
                BottomNavigationBarItem(
                    icon: Icon(EvaIcons.person), label: ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
