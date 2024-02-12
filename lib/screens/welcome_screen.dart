import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'next_screen.dart';
import '../components/sidenav.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

  double screenWidth = MediaQuery.of(context)?.size?.width ?? 400;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      drawer: AppDrawer(), // Add the side navigation drawer
      body: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/50b3116b93b9b02d8e9baef2e38f4e4b.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'ΠΟΛΙΤΙΣΤΙΚΟΣ ΦΙΛΟΖΩΙΚΟΣ ΣΥΛΛΟΓΟΣ ΣΠΑΡΤΗΣ\n\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.06,
                          ),
                        ),
                        TextSpan(
                          text: 'Λακωνία\n\n',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 22,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Μη κερδοσκοπικός οργανισμός με σκοπό την διαφύλαξη των δικαιωμάτων των ζώων, την ΕΥΖΩΙΑ τους, την περίθαλψη τους και την προώθηση υιοθεσιων αδέσποτων ζώων.',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16), // Add spacing
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 40.0), // Add bottom padding
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to the first link
                            launchURL(
                                'https://www.facebook.com/strays.sparta.greece/');
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                Color(0xFF1877F2), // Dark blue for Facebook
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Facebook',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to the second link
                            launchURL(
                                'https://www.instagram.com/strays_sparta_greece/');
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFE4405F), // Pink for Instagram
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Instagram',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to launch the URL
  void launchURL(String url) async {
    await launch(url);
  }
}
