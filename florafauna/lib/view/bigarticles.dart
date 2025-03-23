import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class Bigarticles extends StatefulWidget {
  final int selectedIndex;
  const Bigarticles({super.key,required this.selectedIndex});

  @override
  State<Bigarticles> createState() => _BigarticlesState();
}

class _BigarticlesState extends State<Bigarticles> {
  
List<dynamic> fauna=[]; 
List scientificName=[];

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(fauna[widget.selectedIndex]['references']);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      throw "Could not launch";
    }
  }
bool isloading=true;
   fetchdata() async{
final response = await http.get(Uri.parse('https://api.gbif.org/v1/occurrence/search?taxonKey=1&mediaType=StillImage&limit=300'));
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
      appBar: AppBar(
        title:isloading?Text('Article'): Text(scientificName[widget.selectedIndex]['scientificName'].toString(),style: TextStyle(color: Colors.white,),),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(EvaIcons.arrowCircleLeft, color: Colors.white),
        ),
       
      ),

      body:isloading?Center(child: CircularProgressIndicator(color: Color.fromRGBO(190, 222, 97, 1,))) : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
           
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: PhotoView(
                    
                     
                           minScale: PhotoViewComputedScale.covered * 0.8,
                            initialScale: PhotoViewComputedScale.covered,
                    imageProvider: NetworkImage(fauna[widget.selectedIndex]['media'][0]['identifier'])),
                )))
          
         , SizedBox(height: 20,),
  

   Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
         Text.rich(
  TextSpan(
    children: [
      TextSpan(
        text: "Creator : ",
        style: TextStyle(color:Colors.green, fontSize: 25),
      ),
      TextSpan(
        text: "${fauna[widget.selectedIndex]['media'][0]['creator']}",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    ],
  ),
),
    Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Rights Holder : ",
            style: TextStyle(color:Colors.green, fontSize: 25),
          ),
          TextSpan(
            text: "${fauna[widget.selectedIndex]['media'][0]['rightsHolder']}",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ],
      ),
    ),
    Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Kingdom : ",
            style: TextStyle(color:Colors.green, fontSize: 25),
          ),
          TextSpan(
            text: "${scientificName[widget.selectedIndex]['kingdom']}",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ],
      ),
    ),
    Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Family : ",
            style: TextStyle(color:Colors.green, fontSize: 25),
          ),
          TextSpan(
            text: "${scientificName[widget.selectedIndex]['family']}",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ],
      ),
    ),
    Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Continent : ",
            style: TextStyle(color:Colors.green, fontSize: 25),
          ),
          TextSpan(
            text: "${scientificName[widget.selectedIndex]['continent']}",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ],
      ),
    ),
    Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Occurrence Status : ",
            style: TextStyle(color:Colors.green, fontSize: 25),
          ),
          TextSpan(
            text: "${scientificName[widget.selectedIndex]['occurrenceStatus']}",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ],
      ),
    ),
  ],
),

     SizedBox(height: 20,),
       GestureDetector(

        onTap: (){
         _launchURL();
        },
         child: Container(
          decoration: BoxDecoration(color:Colors.green,borderRadius: BorderRadius.circular(20)),
          height: 50,
          width: double.infinity,
          child: Center(child: Text('Learn More',style: TextStyle(color: Colors.black),)),
         ),
       ),
       
          ],
        ),
      ),
    );
  }
}