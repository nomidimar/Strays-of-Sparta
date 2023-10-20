import 'package:flutter/material.dart';
import '../components/sidenav.dart';
import 'package:flutter/gestures.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Επικοινωνία'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/images/about_us.jpg',
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
                            'Εάν ενδιαφέρεστε για υοθεσία ή φιλοξενία, παρακαλούμε συμπληρώστε την αντίστοιχη φόρμα στην αγγελία του σκύλου που σας ενδιαφέρει από την '),
                    TextSpan(
                      text: 'λίστα υοθεσιών.\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/adoptions');
                        },
                    ),
                    TextSpan(
                        text:
                            'Για να βοηθήσετε στις μεταφορές μπορείτε να δείτε τα '),
                    TextSpan(
                      text: 'δρομολόγια μας.\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/adoptions');
                        },
                    ),
                    TextSpan(
                        text:
                            'Για να συνεισφέρετε οικονομικά πλοηγηθείτε στις '),
                    TextSpan(
                      text: 'δωρεές μας.\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/donate');
                        },
                    ),
                    TextSpan(
                      text:
                          'Για οτιδήποτε άλλο μη διστάσετε να επικοινωνήσετε μαζί μας στο mail',
                    ),
                    TextSpan(
                      text: ' strays_sparta_greece@hotmail.com',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' ή στο τηλεφωνο ',
                    ),
                    TextSpan(
                      text: '697 197 1603',
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
