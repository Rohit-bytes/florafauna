import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:florafauna/view/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      
       backgroundColor: Colors.transparent, // Makes AppBar transparent
      elevation: 0, // Removes AppBar shadow
        title: const Text("Hello, Rohit",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(const CircleBorder()),
              
            ),
            tooltip: "Menu",
            icon: const Icon(EvaIcons.menu2,color: Colors.white,),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: const Drawer(),
    
      /// Background Image Container
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          
          image: DecorationImage(
            image:NetworkImage('https://w0.peakpx.com/wallpaper/866/805/HD-wallpaper-elephant-forest-wildlife-dark.jpg'), // Update with your image path
            fit: BoxFit.cover, 
            // Makes the image cover the screen
          ),
        ),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             Padding(
              padding: EdgeInsets.only(top: 250.0,left: 10,right: 10),
              child: Column(
                children: [
                  Text(
                    'Discover nature and explore beyond',
                    
                    style:GoogleFonts.mPlus1(textStyle:  TextStyle(
                      
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white, // Text color for visibility

                    ),)
                  ),
                   SizedBox(height: 20,),
                  Text(
                    'Protecting Today for Tomorrow: Conservation in Action',
                    style:GoogleFonts.tektur(textStyle:  TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 16,
                      color: Colors.white // Text color for visibility
                    ),)
                  ),
                   SizedBox(height: 20,),
                ],
              ),

            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Landingpage()));
                    },
                    child: Container(
                      height: 65,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [const Color.fromARGB(71, 255, 255, 255),
                      const Color.fromARGB(65, 0, 0, 0)])),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text('Get Started',style:GoogleFonts.cabin( textStyle:TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
                          
                          ),
                          SizedBox(width: 10,),
                          Container(
                            decoration: BoxDecoration(color:Colors.green,borderRadius:BorderRadius.circular(10) ),
                            height: 40,width: 40,child: Icon(Icons.arrow_forward_ios,color: Colors.white,shadows: [Shadow(color: Colors.black)],),),
                          
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ), )
          ],
        ),
      ),
    );
  }
}
