import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String photoUrl;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? address;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.address,
    this.phoneNumber,
    required this.photoUrl,
  });

  /// Converts the `UserModel` instance into a map for Firestore.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photoUrl': photoUrl,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  /// Creates a `UserModel` instance from Firestore document snapshot.
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserModel(
      id: doc.id,
      photoUrl: data['photoUrl'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      address: data['address'] ?? '',
    );
  }
}
