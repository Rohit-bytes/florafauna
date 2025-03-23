import 'package:flutter/material.dart';

class Recommendedartical extends StatelessWidget {
final String? image;
final String? about;
  const Recommendedartical({super.key,required this.image,required this.about});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                child: Opacity(

                  opacity: 1.0,
                  child: Container(
                    color: const Color.fromARGB(147, 158, 158, 158),
                    height: 120,
                    width: double.infinity,
                    child: Image.network(image.toString(),fit: BoxFit.cover,)),
                )),
           SizedBox(height: 10,),
            Text(about.toString(),maxLines: 2,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,),),
            SizedBox(height: 20,),
      
            Row(children: [Icon(Icons.menu,color: Colors.white,),
            SizedBox(width: 5,),
            Text("READ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)],),          ],
          ),
        ),
      ),
    );
  }
}