import 'package:flutter/material.dart';

class DogDetailsScreen extends StatelessWidget {
  final List<String> imageUrls;

  DogDetailsScreen({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Photo Carousel
          Container(
            height: 200, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                String imageUrl = imageUrls[index];
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
                    'Dog Name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Gender: Male, Age: 2, Size: Medium',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Description:',
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
        ],
      ),
    );
  }
}
