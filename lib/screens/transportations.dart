import 'package:flutter/material.dart';

class TransportationData {
  final String startingCity;
  final String destination;
  final String animalName;
  final String species;
  final String weight;
  final int id;

  TransportationData({
    required this.startingCity,
    required this.destination,
    required this.animalName,
    required this.species,
    required this.weight,
    required this.id,
  });
}

List<TransportationData> transportationDataList = [
  TransportationData(
    id: 1,
    startingCity: 'City A',
    destination: 'City B',
    animalName: 'Fido',
    species: 'Dog',
    weight: '25 kg',
  ),
  TransportationData(
    id: 2,
    startingCity: 'City C',
    destination: 'City D',
    animalName: 'Spot',
    species: 'Dog',
    weight: '20 kg',
  ),
];

class TransportationListing extends StatefulWidget {
  final TransportationData data;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

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
    return GestureDetector(
      onTap: () {
        widget.onSelected(!widget.isSelected);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: widget.isSelected ? Colors.blue : Colors.transparent,
              width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
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
                  Text('Προς', style: TextStyle(fontWeight: FontWeight.bold)),
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
    );
  }
}

class TransportationScreen extends StatefulWidget {
  @override
  _TransportationScreenState createState() => _TransportationScreenState();
}

class _TransportationScreenState extends State<TransportationScreen> {
  TransportationData? selectedTransportation;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _tkController = TextEditingController();

  void handleSelection(bool isSelected, TransportationData data) {
    if (isSelected) {
      setState(() {
        selectedTransportation = data;
      });
    }
  }

  void handleSubmit() {
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
                    controller: _nameController,
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
                  print('Name: ${_nameController.text}');
                  print('Phone: ${_phoneController.text}');
                  print('Email: ${_emailController.text}');
                  print('Address: ${_addressController.text}');
                  print('TK: ${_tkController.text}');
                  print('Transportation ID: ${selectedTransportation?.id}');
                  print('Animal Name: ${selectedTransportation?.animalName}');
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    ).then((value) {
      _formKey.currentState?.reset();
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _addressController.clear();
      _tkController.clear();
    });
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
            child: ListView(
              children: transportationDataList.map((data) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  child: TransportationListing(
                    data: data,
                    isSelected: selectedTransportation == data,
                    onSelected: (isSelected) =>
                        handleSelection(isSelected, data),
                  ),
                );
              }).toList(),
            ),
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
