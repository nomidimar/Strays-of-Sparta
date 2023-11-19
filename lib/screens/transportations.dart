import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransportationData {
  final int id;
  final String startingCity;
  final String destination;
  final String animalName;
  final String species;
  final String weight;

  TransportationData({
    required this.id,
    required this.startingCity,
    required this.destination,
    required this.animalName,
    required this.species,
    required this.weight,
  });

  // Factory method to create a TransportationData from JSON
  factory TransportationData.fromJson(Map<String, dynamic> json) {
    return TransportationData(
      id: json['id'],
      startingCity: json['from_city'],
      destination: json['to_city'],
      animalName: json['pet_name'],
      species: json['pet_species'],
      weight: json['pet_weight'].toString(),
    );
  }
}

class TransportationListing extends StatefulWidget {
  final TransportationData data;
  final bool isSelected;
  final VoidCallback onSelected;

  TransportationListing({
    required this.data,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  _TransportationListingState createState() => _TransportationListingState();
}

class _TransportationListingState extends State<TransportationListing> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.isSelected ? Colors.blue : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Card(
          color: widget.isSelected ? Colors.blue[100] : null,
          child: InkWell(
            onTap: () {
              widget.onSelected();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Από',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8.0),
                      Text(widget.data.startingCity),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        child: Icon(Icons.arrow_forward, color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Προς',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8.0),
                      Text(widget.data.destination),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(widget.data.animalName),
                      SizedBox(height: 8.0),
                      Text(widget.data.species),
                      SizedBox(height: 8.0),
                      Text(widget.data.weight),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class TransportationScreen extends StatefulWidget {
  @override
  _TransportationScreenState createState() => _TransportationScreenState();
}

class _TransportationScreenState extends State<TransportationScreen> {
  List<TransportationData> transportationDataList = [];
  TransportationData? selectedTransportation;

  bool isSelectionPending = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameSurnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _tkController = TextEditingController();

  int currentPage = 1;
  int itemsPerPage = 4;
  int totalPages = 0;
  List<TransportationData> displayedTransportationData = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      setState(() {
        transportationDataList = data;
        updateDisplayedItems();
      });
    });

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (isSelectionPending && mounted) {
        setState(() {
          isSelectionPending = false;
        });
      }
    });
  }

  Future<List<TransportationData>> fetchData() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/transportations'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(response.body);
      return data.map((item) => TransportationData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load transportation data');
    }
  }

  void handleSelection(TransportationData data) {
    setState(() {
      selectedTransportation = data;
    });
  }

  void updateDisplayedItems() {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    totalPages = (transportationDataList.length / itemsPerPage).ceil();
    setState(() {
      if (endIndex > transportationDataList.length) {
        displayedTransportationData =
            transportationDataList.sublist(startIndex);
      } else {
        displayedTransportationData =
            transportationDataList.sublist(startIndex, endIndex);
      }
    });
  }

  void handlePrevPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        updateDisplayedItems();
      });
    }
  }

  void handleNextPage() {
    if (currentPage < totalPages) {
      setState(() {
        currentPage++;
        updateDisplayedItems();
      });
    }
  }

  void handleSubmit() {
    print('Displaying the button');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Φόρμα'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameSurnameController,
                    decoration: InputDecoration(
                      labelText: 'Ονοματεπώνυμο',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Το ονοματεπώνυμό είναι απαραίτητο.';
                      } else if (!RegExp(r'^.{1,50}$').hasMatch(value)) {
                        return 'Το ονοματεπώνυμό δεν μπορεί να έχει τόσους χαρακτήρες.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12.0),
                    ),
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
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Τηλέφωνο',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Το τηλέφωνο είναι απαραίτητο.';
                      } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Το τελέφωνο δεν είναι έγκυρο.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Διέθυνση',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Εισάγετε μια διεύθυνση.';
                      } else if (!RegExp(r'^.{1,50}$').hasMatch(value)) {
                        return 'Η διεύθυνση δεν μπορεί να έχει τόσους χαρακτήρες.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _tkController,
                    decoration: InputDecoration(
                      labelText: 'Τ.Κ.',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ο Τ.Κ. είναι απαραίτητος.';
                      } else if (!RegExp(r'^\d{5}$').hasMatch(value)) {
                        return 'Ο Τ.Κ. δεν είναι έγκυρος.';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Καταχώρηση'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Print the form data and selected transportation data
                  print('Form Data:');
                  print('Name: ${_nameSurnameController.text}');
                  print('Phone: ${_phoneController.text}');
                  print('Email: ${_emailController.text}');
                  print('Address: ${_addressController.text}');
                  print('TK: ${_tkController.text}');
                  print('Transportation ID: ${selectedTransportation?.id}');
                  print('Animal Name: ${selectedTransportation?.animalName}');
                  Navigator.of(context).pop();
                  submitData();
                } else {}
              },
            ),
          ],
        );
      },
    ).then((value) {
      _formKey.currentState?.reset();
      _nameSurnameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _addressController.clear();
      _tkController.clear();
    });
  }

  void submitData() async {
    if (_formKey.currentState!.validate() && selectedTransportation != null) {
      // Form data
      Map<String, dynamic> formData = {
        'name_surname': _nameSurnameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'tk': _tkController.text,
        'itinerary_id': selectedTransportation!.id,
      };

      // Transportation data
      Map<String, dynamic> transportationData = {
        'id': selectedTransportation!.id,
        'startingCity': selectedTransportation!.startingCity,
        'destination': selectedTransportation!.destination,
        'animalName': selectedTransportation!.animalName,
        'species': selectedTransportation!.species,
        'weight': selectedTransportation!.weight,
        // Add other transportation data fields as needed
      };

      // Combine form data and transportation data
      Map<String, dynamic> postData = {
        'formData': formData,
        'transportationData': transportationData,
      };

      // Send POST request
      final response = await http.post(
        Uri.parse('http://localhost:3000/transportInterest'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Δρομολόγια'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: displayedTransportationData.length,
              itemBuilder: (context, index) {
                final data = displayedTransportationData[index];
                return Container(
                    margin: EdgeInsets.all(8.0),
                    child: TransportationListing(
                      data: data,
                      isSelected: selectedTransportation == data,
                      onSelected: () => handleSelection(data),
                    ));
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: handlePrevPage,
              ),
              SizedBox(width: 16.0),
              Text('Page $currentPage of $totalPages'),
              SizedBox(width: 16.0),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: handleNextPage,
              ),
            ],
          ),
          if (selectedTransportation != null)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: handleSubmit,
                child: Text('Επιλογή διαδρομής'),
              ),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TransportationScreen(),
  ));
}
