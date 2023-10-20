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

  String formDataName = ''; // Declare variables for form data
  String formDataPhone = '';
  String formDataEmail = '';
  String formDataAddress = '';
  String formDataTK = '';

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
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Όνοματεπώνυμο',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(12.0),
                    ),
                    onChanged: (value) {
                      formDataName = value;
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Τηλέφωνο',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  onChanged: (value) {
                    formDataPhone = value;
                  },
                ),
                SizedBox(height: 16.0),
                // Added some spacing
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  onChanged: (value) {
                    formDataEmail = value;
                  },
                ),
                SizedBox(height: 16.0),
                // Added some spacing
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Διευθυνση',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  onChanged: (value) {
                    formDataAddress = value;
                  },
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Τ.Κ.',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  onChanged: (value) {
                    formDataTK = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Καταχώρηση'),
              onPressed: () {
                // Print the form data and selected transportation data
                print('Form Data:');
                print('Name: $formDataName');
                print('Phone: $formDataPhone');
                print('Email: $formDataEmail');
                print('Address: $formDataAddress');
                print('TK: $formDataTK');
                print('Transportation ID: ${selectedTransportation?.id}');
                print('Animal Name: ${selectedTransportation?.animalName}');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                return TransportationListing(
                  data: data,
                  isSelected: selectedTransportation == data,
                  onSelected: (isSelected) => handleSelection(isSelected, data),
                );
              }).toList(),
            ),
          ),
          if (selectedTransportation != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
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
