import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Donationpage extends StatefulWidget {
  const Donationpage({super.key});

  @override
  State<Donationpage> createState() => _DonationpageState();
}

class _DonationpageState extends State<Donationpage> {
@override
void initState() {
  super.initState();
  Future.delayed(Duration(seconds: 2),() {
    setState(() {
      isloading=!isloading;
    });
  },);
}
  bool isloading =true;
  final Map<String, String> images1 = {
    "WTI": "https://www.wti.org.in/wp-content/uploads/2021/08/WTI_Logo_3.png",
    "WWF": "https://join.wwfindia.org/donate/images/logo.png",
    "wlsos": "https://wildlifesos.org/wp-content/uploads/2020/11/wsos-Bear-Logo-border-85x130-1.png",
  };

  final List<String> donationLinks1 = [
    "https://donation.wti.org.in/?_gl=1%2avl805s%2a_ga%2aMTkxMDk5OTM5Ni4xNzM5NjA3MTA1%2a_ga_9BPRSS24H5%2aMTczOTYwNzEwNS4xLjAuMTczOTYwNzEwNS42MC4wLjA.",
    "https://join.wwfindia.org/?source=WWF-JOIN-WEB&utm_source=main_website&utm_medium=nav_link&utm_campaign=donate",
    "https://india-donations.wildlifesos.org/",
  ];
  final Map<String, String> images2 = {
    "WTI": "https://cfstatic.give.do/logo.png",
    "WWF": "https://www.globalgiving.org/img/logos/gg_horizontal_color_300.png",
"dona":"https://saveplants.org/wp-content/uploads/2020/09/Logo-full.png"
  };
   final List<String> donationLinks2 = [
    "https://give.do/donate/LC177c7e721cb64?",
    "https://www.globalgiving.org/dy/v2/checkout/billing/",
    "https://saveplants.org/donate/",
  ];
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isloading? Center(child: CircularProgressIndicator(color: Colors.green,)): SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 350,
                child: ListView.builder(
                  itemCount: images1.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    String key = images1.keys.elementAt(index);
                    String logoUrl = images1[key]!;
                    String donateUrl = donationLinks1[index];
        
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width:270, // Ensure a consistent width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(147, 158, 158, 158),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height:220,
                                width: 220,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                   
                                    child: Image.network(
                                      logoUrl,
                                      fit: BoxFit.fitWidth,
                                    
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  fixedSize: const Size(220, 60), // Fixed width & height
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () => _launchURL(donateUrl),
                                child: const Text(
                                  'Donate',
                                  style: TextStyle(color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 350,
                child: ListView.builder(
                  itemCount: images2.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    String key = images2.keys.elementAt(index);
                    String logoUrl = images2[key]!;
                    String donateUrl = donationLinks2[index];
        
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 270, 
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(147, 158, 158, 158),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height:220,
                                width: 220,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                   
                                    child: Image.network(
                                      logoUrl,
                                      fit: BoxFit.fitWidth,
                                    
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  fixedSize: const Size(220, 60), // Fixed width & height
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () => _launchURL(donateUrl),
                                child: const Text(
                                  'Donate',
                                  style: TextStyle(color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
             
         
          ],
        ),
      )
    );
  }
}