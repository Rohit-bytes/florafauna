import 'package:flutter/material.dart';

class Recommendedartical2 extends StatelessWidget {
final String? image;
final String? about;
  const Recommendedartical2({super.key,required this.image,required this.about});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height:120,
        width: double.infinity,
        decoration: BoxDecoration(color: const Color.fromARGB(78, 255, 255, 255),borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100 ,
                decoration: BoxDecoration(color: const Color.fromARGB(91, 158, 158, 158),borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(image.toString(),fit: BoxFit.cover,))),
SizedBox(width: 10,),

Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 40,
        width: 200,
       
      
        child: Text(about.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,overflow: TextOverflow.clip,))),
   SizedBox(height: 20,),
   Row(children: [
    Icon(Icons.menu,color: Colors.white,),
    SizedBox(width: 2,),
    Text('READ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
   ],),
    ],
  ),
)
            ],
          ),
        ),
      ),
    );
  }
}