import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/dog_ad.dart';
import '../components/sidenav.dart';
import 'dart:convert';
import '../screens/dog_details_screen.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

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

  bool dataFetched = false;

  int currentPage = 1;
  int itemsPerPage = 5; // Change this to your desired number of items per page
  List<DogAd> displayedDogAds = [];
  //Pagination variables

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    print('fetched data');
    try {
      // Build the base URL
      String url = 'http://localhost:3000/dogs';

      // Check if there are existing query parameters
      bool hasQueryParameters = false;

      // Add filters to the URL if they are selected
      if (selectedSize != null) {
        url += '?size=$selectedSize';
        hasQueryParameters = true;
      }

      if (selectedSex != null) {
        url += hasQueryParameters ? '&' : '?';
        url += 'sex=$selectedSex';
        hasQueryParameters = true;
      }

      if (selectedAge != null) {
        url += hasQueryParameters ? '&' : '?';
        url += 'age=$selectedAge';
        hasQueryParameters = true;
      }

      if (isFriendly) {
        url += hasQueryParameters ? '&' : '?';
        url += 'isFriendly=true';
        hasQueryParameters = true;
      }

      final response = await http.get(Uri.parse(url));
      print(url);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        List<DogAd> fetchedDogAds =
            responseData.map((data) => DogAd.fromJson(data)).toList();
        // if (fetchedDogAds.isNotEmpty) {
        setState(() {
          dogAds = fetchedDogAds;
          dataFetched = true;
          updateDisplayedItems(); // Ensure updateDisplayedItems() is called here
        });
        // } else {
        //   print('Fetched data is empty');
        // }
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e, stackTrace) {
      print('Error: $e');
      print('StackTrace: $stackTrace');
    }
  }

  void handleFilterSubmit() {
    print("called fetch data");
    // if (!dataFetched) {
    fetchData();
    //}
    updateDisplayedItems();
    currentPage = 1; // Reset to the first page after applying filters
    //Navigator.of(context).pop();
  }

  void updateDisplayedItems() {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    print(
        'startIndex: $startIndex, endIndex: $endIndex, dogAds.length: ${dogAds.length}');
    setState(() {
      // Ensure endIndex is within the valid range of the list
      if (endIndex > dogAds.length) {
        displayedDogAds = dogAds.sublist(startIndex);
      } else {
        displayedDogAds = dogAds.sublist(startIndex, endIndex);
      }
    });
  }

  List<DogAd> dogAds = [];

  Widget _buildImageFromBlob(String blob) {
    try {
      // Remove data URI prefix if present
      if (blob.startsWith('data:image')) {
        blob = blob.split(',')[1];
        print('Blob rendered');
      }

      // Decode Base64 string to Uint8List
      Uint8List bytes = base64.decode(blob);

      return Image.memory(
        bytes,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    } catch (e, stackTrace) {
      print('Error decoding image: $e');
      print('StackTrace: $stackTrace');
      // Handle the error (e.g., show a placeholder image)
      return _buildErrorImage('Error decoding image.');
    }
  }

  Widget _buildErrorImage(String errorMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, size: 50, color: Colors.red),
        SizedBox(height: 10),
        Text(errorMessage, style: TextStyle(color: Colors.red)),
      ],
    );
  }

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
              DogAd dogAd = displayedDogAds[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DogDetailsScreen(
                        photoDataArray: dogAd.photos ?? [],
                        name: dogAd.name ?? "Unknown Name",
                        sex: dogAd.sex ?? "Unknown Gender",
                        age: dogAd.age ?? "Unknown Age",
                        size: dogAd.size ?? "Unknown Size",
                        id: (dogAd.id ?? 0) as int,
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
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(right: 16.0, left: 10.0),
                        child: _buildImageFromBlob(dogAd.photos[0]),
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
                              'Φύλο: ${dogAd.sex}, Ηλικία: ${dogAd.age}, Μέγεθος: ${dogAd.size}',
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
          )),
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
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    title: Text('Φίλτρα'),
                    content: Container(
                        height: 400,
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Φύλο:'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    key: Key('sexFilter'),
                                    title: Icon(
                                      Icons.male,
                                      color:
                                          Colors.blue, // Change color as needed
                                    ),
                                    value: 'Αρσενικό',
                                    groupValue: selectedSex,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedSex = value;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    key: Key('sexFilter'),
                                    title: Icon(
                                      Icons.female,
                                      color:
                                          Colors.pink, // Change color as needed
                                    ),
                                    value: 'Θηλυκό',
                                    groupValue: selectedSex,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedSex = value;
                                      });
                                    },
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
                                    value: 'Μικρό',
                                    groupValue: selectedSize,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedSize = value;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: Text('<20kg'),
                                    value: 'Μεσαίο',
                                    groupValue: selectedSize,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedSize = value;
                                      });
                                    },
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
                                    value: 'Μεγάλο',
                                    groupValue: selectedSize,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedSize = value;
                                      });
                                    },
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
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedAge = value;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    title: Text(
                                      'Ενήλικο',
                                    ),
                                    value: 'adult',
                                    groupValue: selectedAge,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedAge = value;
                                      });
                                    },
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
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedAge = value;
                                      });
                                    },
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
                                    if (newValue != null) {
                                      setState(() {
                                        isFriendly = newValue;
                                      });
                                    }
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
                  );
                },
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
