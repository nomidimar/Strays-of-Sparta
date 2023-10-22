import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/dog_ad.dart';
import '../components/sidenav.dart';
import 'dart:convert';
import '../screens/dog_details_screen.dart';

class AdoptionsList extends StatefulWidget {
  @override
  _AdoptionsListState createState() => _AdoptionsListState();
}

class _AdoptionsListState extends State<AdoptionsList> {
  String fetchedData = '';
  String? selectedSex;
  String? selectedSize;
  bool isFriendly = false;
  String? selectedAge;
  //filter variables

  int currentPage = 1;
  int itemsPerPage = 7; // Change this to your desired number of items per page
  List<DogAd> displayedDogAds = [];
  //Pagination variables

  @override
  void initState() {
    super.initState();
    fetchData();
    updateDisplayedItems(); 
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
    //backend call for entries

  void handleSexChange(String? value) {
    setState(() {
      selectedSex = value;
      print(value);
    });
  }

  void handleSizeChange(String? value) {
    setState(() {
      selectedSize = value;
      print(value);
    });
  }

  void handleFriendlyChange(bool? value) {
    if (value != null) {
      setState(() {
        isFriendly = value;
      });
    }
  }

  void handleAgeChange(String? value) {
    setState(() {
      selectedAge = value;
      print(value);
    });
  }
  //filter controllers

  void handleFilterSubmit() {
    currentPage = 1; // Reset to the first page after applying filters
    updateDisplayedItems();
    Navigator.of(context).pop();
  }
 //submit form data
  
  void updateDisplayedItems() {
  final startIndex = (currentPage - 1) * itemsPerPage;
  final endIndex = startIndex + itemsPerPage;
   print('startIndex: $startIndex, endIndex: $endIndex, dogAds.length: ${dogAds.length}');
  setState(() {
    // Ensure endIndex is within the valid range of the list
    if (endIndex > dogAds.length) {
      displayedDogAds = dogAds.sublist(startIndex);
    } else {
      displayedDogAds = dogAds.sublist(startIndex, endIndex);
    }
  });
}


  List<DogAd> dogAds = [
    DogAd(
      pictureUrl: ['assets/images/images (1).jpg'],
      name: 'Buddy',
      gender: 'Male',
      age: 2,
      size: 'Medium',
    ),
    DogAd(
      pictureUrl: ['assets/images/photo-1615751072497-5f5169febe17.jpg'],
      name: 'Jesse',
      gender: 'Female',
      age: 5,
      size: 'Medium',
    ),
    DogAd(
      pictureUrl: ['assets/images/042822_AG_dog-breeds_feats-1030x580.jpg'],
      name: 'Jack',
      gender: 'Male',
      age: 1,
      size: 'Medium',
    ),
    DogAd(
      pictureUrl: ['assets/images/images (1).jpg'],
      name: 'Buddy',
      gender: 'Male',
      age: 2,
      size: 'Medium',
    ),
    DogAd(
      pictureUrl: ['assets/images/photo-1615751072497-5f5169febe17.jpg'],
      name: 'Jesse',
      gender: 'Female',
      age: 5,
      size: 'Medium',
    ),
    DogAd(
      pictureUrl: ['assets/images/042822_AG_dog-breeds_feats-1030x580.jpg'],
      name: 'Jack',
      gender: 'Male',
      age: 1,
      size: 'Medium',
    ),
    DogAd(
      pictureUrl: ['assets/images/images (1).jpg'],
      name: 'Buddy',
      gender: 'Male',
      age: 2,
      size: 'Medium',
    ),
    DogAd(
      pictureUrl: ['assets/images/photo-1615751072497-5f5169febe17.jpg'],
      name: 'Jesse',
      gender: 'Female',
      age: 5,
      size: 'Medium',
    ),
    DogAd(
      pictureUrl: ['assets/images/042822_AG_dog-breeds_feats-1030x580.jpg'],
      name: 'Jack',
      gender: 'Male',
      age: 1,
      size: 'Medium',
    ),
    DogAd(
      pictureUrl: ['assets/images/042822_AG_dog-breeds_feats-1030x580.jpg'],
      name: 'Jack',
      gender: 'Male',
      age: 1,
      size: 'Medium',
    ),
  ];

  List<String> pictureUrls = [
    'assets/images/dogs.jpg',
    'assets/images/dogs_background.jpg',
    'assets/images/images.jpg'
  ];

  
      @override
Widget build(BuildContext context) {
  return Scaffold(
    drawer: AppDrawer(),
    appBar: AppBar(
      title: Text('Υοθεσίες'),
    ),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(
        itemCount: displayedDogAds.length,
        itemBuilder: (context, index) {
          // Get the dog ad at the current index
          DogAd dogAd = displayedDogAds[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DogDetailsScreen(
                    imageUrls: dogAd.pictureUrl,
                    name: dogAd.name,
                    gender: dogAd.gender,
                    age: dogAd.age,
                    size: dogAd.size
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120, // Adjust the width as needed
                    height: 120, // Adjust the height as needed
                    margin: EdgeInsets.only(
                        right: 16.0,
                        left: 10.0), // Adjust the spacing as needed
                    child: Image.network(
                      dogAd.pictureUrl[0],
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
                          'Φύλο: ${dogAd.gender}, Ηλικία: ${dogAd.age}, Μέγεθος: ${dogAd.size}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (currentPage > 1) {
                  setState(() {
                    currentPage--;
                    updateDisplayedItems();
                  });
                }
              },
            ),
            SizedBox(width: 16.0),
            Text('Page $currentPage'),
            SizedBox(width: 16.0),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                if (currentPage < (dogAds.length / itemsPerPage).ceil()) {
                  setState(() {
                    currentPage++;
                    updateDisplayedItems();
                  });
                }
              },
            )
          ],
        ),
      ],
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return IntrinsicHeight(
              child: AlertDialog(
                title: Text('Φίλτρα'),
               content: Container(
                height: 400,
                width: 250,
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Φύλο:'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Icon(
                              Icons.male,
                              color: Colors.blue, // Change color as needed
                            ),
                            value: 'male',
                            groupValue: selectedSex,
                            onChanged: handleSexChange,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Icon(
                              Icons.female,
                              color: Colors.pink, // Change color as needed
                            ),
                            value: 'female',
                            groupValue: selectedSex,
                            onChanged: handleSexChange,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.0),

                    // Size Radio Buttons
                    Text('Μέγεθος:'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(
                              '<12kg',
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: 'small',
                            groupValue: selectedSize,
                            onChanged: handleSizeChange,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text('<20kg'),
                            value: 'medium',
                            groupValue: selectedSize,
                            onChanged: handleSizeChange,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(
                              '>20kg',
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: 'large',
                            groupValue: selectedSize,
                            onChanged: handleSizeChange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text('Ηλικία:'),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text('Νέο'),
                            value: 'young',
                            groupValue: selectedAge,
                            onChanged: handleAgeChange,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text(
                              'Ενήλικο',
                            ),
                            value: 'adult',
                            groupValue: selectedAge,
                            onChanged: handleAgeChange,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text('Μεγάλο'),
                            value: 'old',
                            groupValue: selectedAge,
                            onChanged: handleAgeChange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Checkbox(
                          value: isFriendly,
                          onChanged: (newValue) {
                            print(newValue);
                            handleFriendlyChange(newValue);
                          },
                        ),
                        Text('Φιλικό με σκύλους'),
                      ],
                    ),
                  ],
                )),
                actions: [
                  TextButton(
                    onPressed: () {
                      handleFilterSubmit();
                      Navigator.of(context).pop();
                    },
                    child: Text('Submit'),
                  ),
                ],
              )
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
