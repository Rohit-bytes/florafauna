import 'dart:convert';
import 'package:florafauna/view/bigarticles.dart';
import 'package:florafauna/view/bigarticles2.dart';
import 'package:florafauna/view/showall.dart';
import 'package:florafauna/view/showallflora.dart';
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

//explore more

List<dynamic> flora=[]; 
List scientificNameflora=[];
bool isloading=true;

   fetchfloradata() async{
final response = await http.get(Uri.parse('https://api.gbif.org/v1/occurrence/search?taxonKey=6&mediaType=StillImage&limit=300'));
try {
  if(response.statusCode==200)


{
 final responsedata=json.decode(response.body);
setState(() {
  flora = responsedata["results"];
  scientificNameflora = responsedata["results"];
  isloading=false;
 
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
 
//recommended article
List<dynamic> fauna=[]; 
List scientificName=[];

   fetchdata() async{
final response = await http.get(Uri.parse('https://api.gbif.org/v1/occurrence/search?taxonKey=1&mediaType=StillImage&limit=300'));
try {
  if(response.statusCode==200)


{
 final responsedata=json.decode(response.body);
setState(() {
  fauna = responsedata["results"];
  scientificName = responsedata["results"];
  isloading=false;
 
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
('https://images.pexels.com/photos/142497/pexels-photo-142497.jpeg?cs=srgb&dl=pexels-mali-142497.jpg&fm=jpg'),
    ("https://images.pexels.com/photos/45853/grey-crowned-crane-bird-crane-animal-45853.jpeg?cs=srgb&dl=pexels-pixabay-45853.jpg&fm=jpg"),
    ("https://wallpaper.forfun.com/fetch/7d/7d69a914d3d2668f0b2e575319576428.jpeg"),
  ];

  List<String> quotes =['The least I can do is speak out for those who cannot speak for themselves',
  'What we are doing to the forests of the world is but a mirror reflection of what we are doing to ourselves and one another',
  'The greatness of a nation and its moral progress can be judged by the way its animals are treated.',
  'Take only pictures, leave only footprints, kill nothing but time.'
  
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image;
    fetchdata();
    fetchfloradata();
    
  }

  int currentindex = 0;
  bool isselected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isloading?Center(child: CircularProgressIndicator(color:Colors.green),): Padding(
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
                          image: NetworkImage(image[currentindex],),
                          fit: BoxFit.cover,opacity: 0.60)),
               child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.rotate(
                         angle: 90 * (3.141592653589793 / 180),
                        child: Icon(Icons.rectangle_outlined,size: 35,color:Colors.green)),
                      Expanded(child: Text(quotes[currentindex],style: TextStyle(color: Colors.white,shadows: [Shadow(color: Colors.black,blurRadius: 40)],overflow: TextOverflow.clip),)),
                    ],
                  ),
                )),
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
                                          color:Colors.green))
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
                                          color:Colors.green))
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
                                          color:Colors.green))
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
                                          color:Colors.green))
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
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Showall()));
                },
                child: Text('Show All',style: TextStyle(color:Colors.green,fontWeight: FontWeight.w500),))],),
              
              SizedBox(height: 20,),
              SizedBox(
                height: 270,
                width: double.infinity,
                
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: fauna.length,
                  itemBuilder: (context, index) {
                  return Container(
                 
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Bigarticles(selectedIndex: index)));
                      },
                      child: Recommendedartical(
                        about: scientificName[index]["scientificName"].isNotEmpty? scientificName[index]["scientificName"]:"Not Found",
                                  image: fauna[index]['media'][0]['identifier'].isNotEmpty 
                                    ? fauna[index]['media'][0]['identifier']  // Extract first media image
                                    : "https://static.thenounproject.com/png/1380510-200.png",  // Placeholder image
                                ),
                    ),
          );
                },),
              ),
              SizedBox(height: 20,),
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Flora Species',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Showallflora()));
                },
                child: Text('Show All',style: TextStyle(color:Colors.green,fontWeight: FontWeight.w500),))],),
              
              SizedBox(height: 20,),
        SizedBox(
          height: 550,
          width: double.infinity,
                
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: flora.length,
                  itemBuilder: (context, index) {
                     final item = flora[index];
      final scientificName = item["scientificName"] ?? "Not Found";
      final media = item['media'] ?? [];
      final image = media.isNotEmpty && media[0]['identifier'] != null
          ? media[0]['identifier']
          : "https://static.thenounproject.com/png/1380510-200.png"; // Placeholder image

                  return Container(
                 
                    child: GestureDetector(

                       onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Bigarticlesflora(selectedIndex: index)));
                      },
                      child: Recommendedartical2(
                        image: image,
                        about: scientificName,
                        ),
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