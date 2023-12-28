import 'package:flutter/material.dart';

class DogAd {
  int id;
  List<String> photos;
  String name;
  String sex;
  bool vaccinated;
  bool spayed;
  bool? needsContract;
  bool friendlyWithPeople;
  bool friendlyWithPets;
  String healthState;
  String age;
  String size;
  String description;

  DogAd({
    required this.id,
    required this.photos,
    required this.name,
    required this.sex,
    required this.vaccinated,
    required this.spayed,
    this.needsContract,
    required this.friendlyWithPeople,
    required this.friendlyWithPets,
    required this.healthState,
    required this.age,
    required this.size,
    required this.description,
  });

  factory DogAd.fromJson(Map<String, dynamic> json) {
    return DogAd(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      sex: json['sex'] ?? '',
      size: json['size'] ?? '',
      description: json['description'] ?? '',
      vaccinated: json['vaccinated'] ?? false,
      spayed: json['spayed'] ?? false,
      friendlyWithPeople: json['friendly_with_people'] ?? false,
      friendlyWithPets: json['friendly_with_pets'] ?? false,
      healthState: json['health_state'] ?? '',
      needsContract: json['needs_contract'] ?? false,
      photos: List<String>.from(json['photos'] ?? []),
    );
  }
}
