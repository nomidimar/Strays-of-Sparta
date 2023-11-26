import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class DogDetailsScreen extends StatefulWidget {
  final List<String> photoDataArray;
  final String name;
  final String sex;
  final String age;
  final String size;
  final int id;

  DogDetailsScreen(
      {required this.photoDataArray,
      required this.name,
      required this.sex,
      required this.age,
      required this.size,
      required this.id});

  @override
  _DogDetailsScreenState createState() => _DogDetailsScreenState();
}

class _DogDetailsScreenState extends State<DogDetailsScreen> {
  bool isInterested = false;
  bool adoptionOrFoster = false;
  String? selectedDuration;

  String removeDataUrlPrefix(String base64Image) {
    print(base64Image);
    const String prefix1 = "data:image/jpeg;base64,";
    const String prefix2 = "data:image/png;base64,";

    if (base64Image.startsWith(prefix1)) {
      return base64Image.substring(prefix1.length);
    } else if (base64Image.startsWith(prefix2)) {
      return base64Image.substring(prefix2.length);
    }

    // If no prefix is found, return the original string
    return base64Image;
  }

  void submitForm(
    String nameSurname,
    String phone,
    String email,
    String address,
    String postCode,
  ) async {
    Map<String, dynamic> formData = {
      'name_surname': nameSurname,
      'email': email,
      'phone': phone,
      'address': address,
      'post_code': postCode,
      'dog_id': widget.id,
      'name': widget.name,
      'foster': adoptionOrFoster,
      'duration': selectedDuration
    };

    // // Combine form data and transportation data
    // Map<String, dynamic> postData = {
    //   'formData': formData,
    // };

    // Send POST request
    final response = await http.post(
      Uri.parse('http://localhost:3000/petInterest'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(formData),
    );

    if (response.statusCode == 201) {
      // Successful response, handle accordingly
      print('Successfully submitted data to the backend.');
    } else {
      // Handle errors
      print(
          'Failed to submit data to the backend. Status code: ${response.statusCode}');
    }

    // Close the dialog
    Navigator.of(context).pop();
  }

  void showInterestDialog(BuildContext context) {
    TextEditingController nameSurnameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController postCodeController = TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text('Εκδήλωση Ενδιαφέροντος'),
            content: Container(
                width: double.maxFinite,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameSurnameController,
                          decoration:
                              InputDecoration(labelText: 'Ονοματεπώνυμο'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Το ονοματεπώνυμό είναι απαραίτητο.';
                            } else if (!RegExp(r'^.{1,50}$').hasMatch(value)) {
                              return 'Το ονοματεπώνυμό δεν μπορεί να έχει τόσους χαρακτήρες.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(labelText: 'Τηλέφωνο'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Το τηλέφωνο είναι απαραίτητο.';
                            } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                              return 'Το τελέφωνο δεν είναι έγκυρο.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Το email είναι απαραίτητο.';
                            } else if (!RegExp(
                                    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                                .hasMatch(value)) {
                              return 'Το email δεν είναι έγκυρο.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: addressController,
                          decoration: InputDecoration(labelText: 'Διεύθυνση'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Εισάγετε μια διεύθυνση.';
                            } else if (!RegExp(r'^.{1,50}$').hasMatch(value)) {
                              return 'Η διεύθυνση δεν μπορεί να έχει τόσους χαρακτήρες.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: postCodeController,
                          decoration: InputDecoration(labelText: 'Τ.Κ.'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Ο Τ.Κ. είναι απαραίτητος.';
                            } else if (!RegExp(r'^\d{5}$').hasMatch(value)) {
                              return 'Ο Τ.Κ. δεν είναι έγκυρος.';
                            }
                            return null;
                          },
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
                                  value: '2 εβδομάδες',
                                  child: Text('2 εβδομάδες'),
                                ),
                                DropdownMenuItem(
                                  value: '1 μήνας',
                                  child: Text('1 μήνας'),
                                ),
                                DropdownMenuItem(
                                  value: '2 μήνες και άνω',
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Διαλέξτε διάρκεια';
                                }
                                return null;
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                )),
            actions: <Widget>[
              TextButton(
                child: Text('Υποβολή'),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    String nameSurname = nameSurnameController.text;
                    String phone = phoneController.text;
                    String email = emailController.text;
                    String address = addressController.text;
                    String postCode = postCodeController.text;
                    submitForm(nameSurname, phone, email, address, postCode);
                  }
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
        });
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
            height: 400,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.photoDataArray.length,
              itemBuilder: (context, index) {
                String base64Image = widget.photoDataArray[index];
                base64Image = removeDataUrlPrefix(base64Image);
                Uint8List bytes = base64Decode(base64Image);

                return Container(
                  width: 300,
                  child: Image.memory(
                    bytes,
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
                    'Φύλο: ${widget.sex}, Ηλικία: ${widget.age}, Μέγεθος: ${widget.size}',
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
          Container(
            width: 100,
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                showInterestDialog(context);
              },
              child: Text('Ενδιαφέρομαι!'),
            ),
          )
        ],
      ),
    );
  }
}
