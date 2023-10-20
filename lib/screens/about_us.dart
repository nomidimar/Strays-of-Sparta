import 'package:flutter/material.dart';
import '../components/sidenav.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Ποιοί είμαστε'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/images/about_us_candidate_pic_2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'Είμαστε μια ομάδα ανθρώπων που προσπαθούμε καθημερινά να βελτιώσουμε τη διαβίωση των αδέσποτων ζώων!\n\n'
                          'Είμαστε εθελοντές με το μόνο μας κίνητρο είναι η',
                    ),
                    TextSpan(
                      text: ' αγάπη μας ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'για ζώα που βρίσκονται σε ανάγκη!\n',
                    ),
                    TextSpan(
                      text: 'Η κατάσταση στα κυνοκομεία της Σπάρτης είναι ',
                    ),
                    TextSpan(
                      text: 'τραγική',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ', έχουμε ξεκινήσει τη βελτίωση τους!\n\n'
                          'Ο μόνος σίγουρος τρόπος για να σωθούν ολοκληρωτικά αυτά τα ζώα είναι να ',
                    ),
                    TextSpan(
                      text: 'υιοθετηθούν',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '.\nΠιστέψτε μας, ',
                    ),
                    TextSpan(
                      text: 'το αξίζουν τόσο πολύ.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' Έχουν ζήσει στην κόλαση.\n\n'
                          'Αν είστε βέβαιοι ότι θέλετε να σώσετε ένα πλάσμα υιοθετώντας τα παρακάτω θα βρείτε όλα τα σκυλιά των κυνοκομείων που κατάφεραν να επιζήσουν.\n'
                          'Σας παρακαλούμε, μην τα ξεχνάτε.\n',
                    ),
                    TextSpan(
                      text: 'Μόνο εμάς έχουν.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
