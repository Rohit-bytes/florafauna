import 'package:florafauna/view/homepage.dart';
import 'package:flutter/material.dart';

void main(){
runApp(const Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent,
      )),
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
    );
  }
}