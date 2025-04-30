import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class Bigarticlesflora extends StatefulWidget {
  final int selectedIndex;
  const Bigarticlesflora({super.key, required this.selectedIndex});

  @override
  State<Bigarticlesflora> createState() => _BigarticlesfloraState();
}

class _BigarticlesfloraState extends State<Bigarticlesflora> {
  List<dynamic> flora = [];
  List scientificName = [];
  final List<String> randomStrings = [
  "These plants are essential for maintaining biodiversity and ecosystem balance. They contribute significantly to the health of natural habitats, providing food and shelter for a wide range of species, from insects to large mammals.",
  "They are critical for sustaining biodiversity and ecosystem health. By acting as the foundation of food webs, these plants support both plant-eating animals and the predators that depend on them.",
  "Their presence is key to the preservation of biodiversity and ecosystem integrity. Without these plants, many species would struggle to survive, leading to a collapse of the ecological structures that rely on them.",
  "These plants are indispensable for ensuring biodiversity and ecosystem vitality. They help regulate atmospheric conditions, promote soil stability, and assist in water purification, making them fundamental to ecosystem sustainability.",
  "The role these plants play extends far beyond their beauty, as they are crucial in sustaining ecological cycles. From pollination to carbon sequestration, they help mitigate the effects of climate change and support overall ecosystem resilience.",
  "As primary producers in many ecosystems, these plants form the backbone of food chains. They generate the energy needed for countless organisms to thrive, contributing to ecosystem productivity and overall health.",
  "These plants foster ecological diversity by providing habitats for a multitude of organisms. From the smallest microorganisms to large animals, they support a complex network of life, ensuring the survival of various species in different ecosystems.",
  "By stabilizing soil and preventing erosion, these plants contribute to land conservation, protecting valuable resources and enhancing ecosystem functionality. Their role in maintaining the earth's natural cycles cannot be overstated.",
];


  String getRandomParagraph() {
    Random random = Random();
    return randomStrings[random.nextInt(randomStrings.length)];
  }
  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(flora[widget.selectedIndex]['references']);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      throw "Could not launch";
    }
  }

  bool isLoading = true;

  fetchData() async {
    final response = await http.get(Uri.parse('https://api.gbif.org/v1/occurrence/search?taxonKey=6&mediaType=StillImage&limit=300'));
    try {
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          flora = responseData["results"];
          scientificName = responseData["results"];
          isLoading = false;
        });
      } else {
        print('No data found');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: isLoading
            ? Text('Article')
            : Text(
                scientificName[widget.selectedIndex]['scientificName'].toString(),
                style: TextStyle(color: Colors.white),
              ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(EvaIcons.arrowCircleLeft, color: Colors.white),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color.fromRGBO(190, 222, 97, 1,)))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image Section
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
                          imageProvider: NetworkImage(flora[widget.selectedIndex]['media'][0]['identifier']),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Description Section
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Kingdom: ",
                                  style: TextStyle(color: Colors.green, fontSize: 25),
                                ),
                                TextSpan(
                                  text: "${scientificName[widget.selectedIndex]['kingdom']}",
                                  style: TextStyle(color: Colors.white, fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(child: Divider(color: Colors.green)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Description',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(child: Divider(color: Colors.green)),
                            ],
                          ),
                          SizedBox(height: 10),
                       SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                         child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Belonging to the fascinating family",
                                style: TextStyle(color: Colors.white, fontSize: 22),
                              ),
                              TextSpan(
                                text: " ${scientificName[widget.selectedIndex]['family']}",
                                style: TextStyle(color: Colors.green, fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ", ${getRandomParagraph()}",
                                style: TextStyle(color: Colors.white, fontSize: 22),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                                               ),
                       ),
                      SizedBox(height: 80,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomSheet: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.only(bottom: 30, left: 10, right: 10),
          child: GestureDetector(
            onTap: () {
              _launchURL();
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
              height: 50,
              width: double.infinity,
              child: Center(child: Text('Learn More', style: TextStyle(color: Colors.black))),
            ),
          ),
        ),
      ),
    );
  }
}
