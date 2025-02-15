import 'package:flutter/material.dart';

class Recommendedarticalshowall extends StatelessWidget {
final String? image;
final String? about;

  const Recommendedarticalshowall({super.key,required this.image,required this.about});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height:200,
        width: 170,
        decoration: BoxDecoration(color: const Color.fromARGB(78, 255, 255, 255),borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: const Color.fromARGB(147, 158, 158, 158),
                  height: 200,
                  width: double.infinity,
                  child: Image.network(image.toString(),fit: BoxFit.cover,))),
           SizedBox(height: 10,),
            Text(about.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,overflow: TextOverflow.clip,),),
            SizedBox(height: 20,),

            Container(height: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.green),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              SizedBox(width: 5,),
              Center(child: Text("READ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))],),
            ),          ],
          ),
        ),
      ),
    );
  }
}