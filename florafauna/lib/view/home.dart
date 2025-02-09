import 'dart:convert';
import 'dart:math';

import 'package:florafauna/viewmodel/recommendedartical.dart';
import 'package:florafauna/viewmodel/recommendedartical2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
List<dynamic> fauna=[]; 
List scientificName=[];
   fetchdata() async{
final response = await http.get(Uri.parse('https://api.gbif.org/v1/occurrence/search?country=GB&country=IE&country=IM'));
try {
  if(response.statusCode==200)


{
 final responsedata=json.decode(response.body);
setState(() {
  fauna = responsedata["results"];
  scientificName = responsedata["results"];
 
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
  List<String> image = [
    ('https://img.freepik.com/free-photo/closeup-chital-mudumalai-national-park-india_181624-39465.jpg?ga=GA1.1.78227529.1730639370&semt=ais_hybrid'),
    ("https://www.pixelstalk.net/wp-content/uploads/images6/Animal-Wallpaper-HD-Free-download.jpg"),
    ("https://wallpaper.forfun.com/fetch/7d/7d69a914d3d2668f0b2e575319576428.jpeg"),
    ("https://images.pexels.com/photos/45853/grey-crowned-crane-bird-crane-animal-45853.jpeg?cs=srgb&dl=pexels-pixabay-45853.jpg&fm=jpg"),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image;
    fetchdata();
  }

  int currentindex = 0;
  bool isselected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(78, 255, 255, 255),
                      image: DecorationImage(
                          image: NetworkImage(image[currentindex]),
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(78, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentindex = 0;
                          isselected = true;
                        });
                      },
                      child: Container(
                         decoration: BoxDecoration(
                              border: currentindex == 0
                                  ? Border(
                                      bottom: BorderSide(
                                          width: 4,
                                          color: Color.fromRGBO(190, 222, 97, 1)))
                                  : Border(bottom: BorderSide.none)),
                          height: 40,
                          width: 60,
                          child: Center(
                              child: Text(
                            'Science',
                            style: TextStyle(color: Colors.white),
                          ))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isselected = true;
                          currentindex = 1;
                        });
                      },
                      child: Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                              border: currentindex == 1
                                  ? Border(
                                      bottom: BorderSide(
                                          width: 4,
                                          color: Color.fromRGBO(190, 222, 97, 1)))
                                  : Border(bottom: BorderSide.none)),
                          child: Center(
                              child: Text(
                            'Environment',
                            style: TextStyle(color: Colors.white),
                          ))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isselected = true;
                          currentindex = 2;
                        });
                      },
          
                      child: Container(
                         decoration: BoxDecoration(
                              border: currentindex == 2
                                  ? Border(
                                      bottom: BorderSide(
                                          width: 4,
                                          color: Color.fromRGBO(190, 222, 97, 1)))
                                  : Border(bottom: BorderSide.none)),
                          height: 40,
                          width: 60,
                          child: Center(
                              child: Text(
                            'Animals',
                            style: TextStyle(color: Colors.white),
                          ))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isselected = true;
                          currentindex = 3;
                        });
                      },
                      child: Container(
                          height: 40,
                          width: 60,
                           decoration: BoxDecoration(
                              border: currentindex == 3
                                  ? Border(
                                      bottom: BorderSide(
                                          width: 4,
                                          color: Color.fromRGBO(190, 222, 97, 1)))
                                  : Border(bottom: BorderSide.none)),
                          child: Center(
                              child: Text(
                            'Travels',
                            style: TextStyle(color: Colors.white),
                          ))),
                    ),
                  ],
                ),
              ),
          SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Recommended Article',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              Text('Show All',style: TextStyle(color: Color.fromRGBO(190, 222, 97,1),fontWeight: FontWeight.w500),)],),
              
              SizedBox(height: 20,),
              SizedBox(
                height: 270,
                width: double.infinity,
                
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                  return Container(
                 
                    child: Recommendedartical(
                      about: scientificName[index]["scientificName"].isNotEmpty? scientificName[index]["scientificName"]:"Not Found",
            image: fauna[index]['media'][0]['identifier'].isNotEmpty 
              ? fauna[index]['media'][0]['identifier']  // Extract first media image
              : "https://static.thenounproject.com/png/1380510-200.png",  // Placeholder image
          ),
          );
                },),
              ),
              SizedBox(height: 20,),
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Recommended Article',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              Text('Show All',style: TextStyle(color: Color.fromRGBO(190, 222, 97,1),fontWeight: FontWeight.w500),)],),
              
              SizedBox(height: 20,),
        SizedBox(
          height: 550,
          width: double.infinity,
                
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                  return Container(
                 
                    child: Recommendedartical2(
                      about: scientificName[index]["scientificName"].isNotEmpty? scientificName[index]["scientificName"]:"Not Found",
            image: fauna[index]['media'][0]['identifier'].isNotEmpty 
              ? fauna[index]['media'][0]['identifier']  // Extract first media image
              : "https://static.thenounproject.com/png/1380510-200.png",  // Placeholder image
          ),
          );
                },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
