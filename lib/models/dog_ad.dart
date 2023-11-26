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
  });

  // Constructor to convert JSON data to a DogAd instance
  factory DogAd.fromJson(Map<String, dynamic> json) {
    return DogAd(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      sex: json['sex'] ?? '', // Use an empty string as a default value
      size: json['size'] ?? '', // Use an empty string as a default value
      vaccinated: json['vaccinated'] ?? false, // Use false as a default value
      spayed: json['spayed'] ?? false, // Use false as a default value
      friendlyWithPeople:
          json['friendly_with_people'] ?? false, // Use false as a default value
      friendlyWithPets:
          json['friendly_with_pets'] ?? false, // Use false as a default value
      healthState:
          json['health_state'] ?? '', // Use an empty string as a default value
      needsContract:
          json['needs_contract'] ?? false, // Use false as a default value
      photos: List<String>.from(json['photos'] ?? []),
    );
  }
}
