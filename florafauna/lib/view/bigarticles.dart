import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class Bigarticles extends StatefulWidget {
  final int selectedIndex;
  const Bigarticles({super.key, required this.selectedIndex});

  @override
  State<Bigarticles> createState() => _BigarticlesState();
}

class _BigarticlesState extends State<Bigarticles> {
  List<dynamic> fauna = [];
  List scientificName = [];
    final List<String> paragraphs = [
    "This species showcases remarkable adaptations and unique characteristics that set it apart within the animal kingdom. Throughout various ecosystems, members of this family play critical roles, contributing to ecological balance and biodiversity. Researchers have extensively studied them to uncover insights into their behavior, habitat preferences, and evolutionary significance, emphasizing their importance to both science and nature.",
    "The diversity of this family is fascinating, with each species having its own unique traits and behaviors. They are found in various habitats across the world, from lush forests to arid deserts. Their ability to adapt to changing environments has made them one of the most successful groups in nature. Understanding their behavior and evolutionary history provides important insights into the natural world.",
    "Members of this family are known for their exceptional ability to thrive in diverse environments. From the high mountains to the deep oceans, they have adapted in extraordinary ways to survive and reproduce. Their contribution to maintaining ecosystem health cannot be overstated, as they often play pivotal roles in pollination, seed dispersal, and pest control.",
    "This family is not only fascinating because of its evolutionary adaptations, but also because of its deep connection with human culture. Many species within this family have been subjects of folklore and mythology, representing a bridge between science and tradition. Their role in ecosystems is just as profound as their cultural significance, making them an integral part of both natural and human history."
  ];

  // Randomly select a paragraph from the list
  String getRandomParagraph() {
    Random random = Random();
    return paragraphs[random.nextInt(paragraphs.length)];
  }

Future<void> _launchURL() async {
  // final String? url = fauna[widget.selectedIndex]['references'];
  // final String? url = "https://www.gbif.org/dataset/${fauna[widget.selectedIndex]['datasetKey']}";
  final String? url = "https://www.gbif.org/occurrence/${fauna[widget.selectedIndex]['key']}";
  print(url);
  print(widget.selectedIndex);

  if (url == null || url.isEmpty) {
    _showErrorSnackbar('URL is empty or missing');
    return;
  }

  final Uri uri = Uri.parse(url);

  try {
    if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
      _showErrorSnackbar('Could not launch the link');
    }
  } catch (e) {
    _showErrorSnackbar('Error launching the link');
  }
}

void _showErrorSnackbar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

  bool isloading = true;

  fetchdata() async {
    final response = await http.get(Uri.parse('https://api.gbif.org/v1/occurrence/search?taxonKey=1&mediaType=StillImage&limit=300'));
    try {
      if (response.statusCode == 200) {
        final responsedata = json.decode(response.body);
        setState(() {
          fauna = responsedata["results"];
          scientificName = responsedata["results"];
          isloading = !isloading;
        });

        print(response.body);
      } else {
        print('no data found');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: isloading
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
      body: isloading
          ? Center(child: CircularProgressIndicator(color: Color.fromRGBO(190, 222, 97, 1,)))
          : Padding(
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
                            imageProvider: NetworkImage(fauna[widget.selectedIndex]['media'][0]['identifier']),
                            loadingBuilder: (context, event) => Center(
                              child: CircularProgressIndicator(color: Colors.green),
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 20),
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
                                  text: "Kingdom : ",
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
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              width: double.infinity,
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Belonging to the fascinating family ",
                                      style: TextStyle(color: Colors.white, fontSize: 22),
                                    ),
                                    TextSpan(
                                      text: "${scientificName[widget.selectedIndex]['family']}",
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
      bottomSheet: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.only(bottom: 30, left: 10, right: 10),
          child: GestureDetector(
            onTap: () async {
              await _launchURL();
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
