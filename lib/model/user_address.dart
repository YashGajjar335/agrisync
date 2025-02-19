import 'package:cloud_firestore/cloud_firestore.dart';

class UserAddress {
  String id;
  String userId;
  String fullName;
  String phoneNumber;
  String flatNumber;
  String streetRoad;
  String street;
  String city;
  String state;
  String country;
  String postalCode;

  UserAddress({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.phoneNumber,
    required this.flatNumber,
    required this.streetRoad,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  });

  // Convert a UserAddress object to a Map (for Firebase/DB storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'flatNumber': flatNumber,
      'streetRoad': streetRoad,
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
    };
  }

  // Create a UserAddress object from a Map (for fetching from DB)
  static UserAddress fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> map = snap.data as Map<String, dynamic>;
    return UserAddress(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      flatNumber: map['flatNumber'] ?? '',
      streetRoad: map['streetRoad'] ?? '',
      street: map['street'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
      postalCode: map['postalCode'] ?? '',
    );
  }
}
