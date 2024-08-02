import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vazifa_10/data/model/card_model.dart';

class UserModel {
  String id;
  String fullName;
  String email;
  String passportId;
  List<CardModel> cards;
  String firstname;
  String lastname;
  String imageUrl;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.passportId,
    required this.cards,
    required this.firstname,
    required this.lastname,
    required this.imageUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      fullName: data['fullName'],
      email: data['email'],
      passportId: data['passportId'],
      cards: (data['cards'] as List)
          .map((item) => CardModel.fromMap(item, item['id']))
          .toList(),
      firstname: data['firstname'],
      lastname: data['lastname'],
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'passportId': passportId,
      'cards': cards.map((card) => card.toMap()).toList(),
      'firstname': firstname,
      'lastname': lastname,
      'imageUrl': imageUrl,
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? passportId,
    List<CardModel>? cards,
    String? firstname,
    String? lastname,
    String? imageUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      passportId: passportId ?? this.passportId,
      cards: cards ?? this.cards,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      firstname: data['firstname'] ?? 'null',
      lastname: data['lastname'] ?? 'null',
      email: data['email'] ?? 'null',
      imageUrl: data['imageUrl'] ?? 'null',
      cards: data[''] ?? [],
      fullName: data['fullName'] ?? 'null',
      passportId: data['passportId'] ?? 'null',
    );
  }
}
