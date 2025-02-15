import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:florafauna/view/bigarticles.dart';
import 'package:florafauna/viewmodel/recommendedartical.dart';
import 'package:florafauna/viewmodel/recommendedarticalshowall.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Showall extends StatefulWidget {
  const Showall({super.key});

  @override
  State<Showall> createState() => _ShowallState();
}

class _ShowallState extends State<Showall> {

List<dynamic> fauna=[]; 
List scientificName=[];
bool isloading=true;
   fetchdata() async{
final response = await http.get(Uri.parse('https://api.gbif.org/v1/occurrence/search?country=GB&country=IE&country=IM'));
try {
  if(response.statusCode==200)


{
 final responsedata=json.decode(response.body);
setState(() {
  fauna = responsedata["results"];
  scientificName = responsedata["results"];
 isloading=!isloading;
});
  
print(response.body);


}
else{
    print('no data found');
}
} catch (e) {
  print(e);
}

  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
    fetchdata();
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar:  AppBar(
        title: Text('Articles',style: TextStyle(color: Colors.white,),),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(EvaIcons.arrowCircleLeft, color: Colors.white),
        ),
      
      
      ),
      body:isloading?Center(child: CircularProgressIndicator(color:Colors.green),): SizedBox(
                height: double.infinity,
                width: double.infinity,
                
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: fauna.length,
                  
                  itemBuilder: (context, index) {
                  return Container(
                 height: 400,
                
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Bigarticles(selectedIndex: index)));
                      },
                      child: Recommendedarticalshowall(
                        about: scientificName[index]["scientificName"].isNotEmpty? scientificName[index]["scientificName"]:"Not Found",
                                  image: fauna[index]['media'][0]['identifier'].isNotEmpty 
                                    ? fauna[index]['media'][0]['identifier']  // Extract first media image
                                    : "https://static.thenounproject.com/png/1380510-200.png",  // Placeholder image
                                ),
                    ),
          );
                },),
              )
    );
  }
}