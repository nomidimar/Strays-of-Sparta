import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/dog_ad.dart';
import '../components/sidenav.dart';

class AdoptionsList extends StatefulWidget {
  @override
  _AdoptionsListState createState() => _AdoptionsListState();
}

class _AdoptionsListState extends State<AdoptionsList> {
  String fetchedData = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/dogs'));
      if (response.statusCode == 200) {
        setState(() {
          fetchedData = response.body;
          print(fetchedData);
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<DogAd> dogAds = [
    DogAd(
      pictureUrl: 'assets/images/dogs.jpg',
      name: 'Buddy',
      gender: 'Male',
      age: 2,
      size: 'Medium',
    ),
    DogAd(
      pictureUrl: 'assets/images/dogs.jpg',
      name: 'Buddy',
      gender: 'Male',
      age: 2,
      size: 'Medium',
    ),
    DogAd(
      pictureUrl: 'assets/images/dogs.jpg',
      name: 'Buddy',
      gender: 'Male',
      age: 2,
      size: 'Medium',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Υοθεσίες'),
      ),
      body: ListView.builder(
        itemCount: dogAds.length,
        itemBuilder: (context, index) {
          // Get the dog ad at the current index
          DogAd dogAd = dogAds[index];

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120, // Adjust the width as needed
                  height: 120, // Adjust the height as needed
                  margin: EdgeInsets.only(
                      right: 16.0), // Adjust the spacing as needed
                  child: Image.network(
                    dogAd.pictureUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dogAd.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Gender: ${dogAd.gender}, Age: ${dogAd.age}, Size: ${dogAd.size}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Φίλτρα'),
                content: Text('Put your filter options here'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.filter_list),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
