import 'package:flutter/material.dart';

class DogDetailsScreen extends StatefulWidget {
  final List<String> imageUrls;
  final String name;
  final String gender;
  final int age;
  final String size;

  DogDetailsScreen({
    required this.imageUrls,
    required this.name,
    required this.gender,
    required this.age,
    required this.size,
  });

  @override
  _DogDetailsScreenState createState() => _DogDetailsScreenState();
}

class _DogDetailsScreenState extends State<DogDetailsScreen> {
  bool isInterested = false;
  bool adoptionOrFoster = false;
  String? selectedDuration;

  void showInterestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          title: Text('Εκδήλωση Ενδιαφέροντος'),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Ονοματεπώνυμο'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Τηλέφωνο'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Διεύθυνση'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Τ.Κ.'),
                  ),
                  Row(
                    children: [
                      Text('Φιλοξενία: '),
                      Switch(
                        value: adoptionOrFoster,
                        onChanged: (value) {
                          setState(() {
                            adoptionOrFoster = value;
                            if (!adoptionOrFoster) {
                              selectedDuration = null;
                            }
                          });
                          print(adoptionOrFoster);
                        },
                      ),
                      Text('Υιοθεσία'),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  // Conditional Duration Dropdown
                  // Only visible if user selects "Foster"
                  if (!adoptionOrFoster)
                    Container(
                      constraints: BoxConstraints(maxWidth: 200.0),
                      child: DropdownButtonFormField(
                        value: selectedDuration,
                        items: [
                          DropdownMenuItem(
                            value: '2 weeks',
                            child: Text('2 εβδομάδες'),
                          ),
                          DropdownMenuItem(
                            value: '1 month',
                            child: Text('1 μήνας'),
                          ),
                          DropdownMenuItem(
                            value: '2 months+',
                            child: Text('2 μήνες και άνω'),
                          ),
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            selectedDuration = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Διάρκεια',
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Υποβολή'),
              onPressed: () {
                // Handle form submission
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ακύρωση'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        }
        );
      },
    );
  }

  //open pop up dialog when the user is interested in pet
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Λεπτομέριες'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Photo Carousel
          Container(
            height: 200, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.imageUrls
                  .length, // Accessing imageUrls through widget property
              itemBuilder: (context, index) {
                String imageUrl = widget.imageUrls[
                    index]; // Accessing imageUrls through widget property
                return Container(
                  width: 200, // Adjust the width as needed
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          // Dog Details
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Φύλο: ${widget.gender}, Ηλικία: ${widget.age}, Μέγεθος: ${widget.size}',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Περιγραφή:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lobortis rhoncus dolor, vitae viverra purus congue eu. Nulla facilisi.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          //Dog data
          ElevatedButton(
            onPressed: () {
              showInterestDialog(context);
            },
            child: Text('Ενδιαφέρομαι'),
          ),
          //interest button
        ],
      ),
    );
  }
}
