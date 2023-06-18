import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.pets),
                  title: Text('Υοθεσίες'),
                  onTap: () {
                    Navigator.pushNamed(context, '/next');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text('Μεταφορές'),
                  onTap: () {
                    // Handle navigation to the transportation screen
                  },
                ),
                ListTile(
                  leading: Icon(Icons.monetization_on),
                  title: Text('Δωρεές'),
                  onTap: () {
                    // Handle navigation to the donations screen
                  },
                ),
                ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('Ποιοί είμαστε'),
                  onTap: () {
                    // Handle navigation to the donations screen
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contact_mail_rounded),
                  title: Text('Επικοινωνία'),
                  onTap: () {
                    // Handle navigation to the donations screen
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
    );
  }
}
