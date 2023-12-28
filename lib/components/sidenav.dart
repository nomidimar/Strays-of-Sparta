import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Color.fromARGB(255, 247, 246, 246),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('../assets/images/images.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    '',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 240, 229, 229),
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.pets),
                  title: Text('Υοθεσίες'),
                  onTap: () {
                    Navigator.pushNamed(context, '/adoptions');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text('Μεταφορές'),
                  onTap: () {
                    Navigator.pushNamed(context, '/transport');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.monetization_on),
                  title: Text('Δωρεές'),
                  onTap: () {
                    Navigator.pushNamed(context, '/donate');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Ποιοί είμαστε'),
                  onTap: () {
                    Navigator.pushNamed(context, '/about_us');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contact_mail_rounded),
                  title: Text('Επικοινωνία'),
                  onTap: () {
                    Navigator.pushNamed(context, '/contact');
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Strays of Sparta',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
