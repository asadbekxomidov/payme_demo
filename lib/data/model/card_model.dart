import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  String id;
  String fullname;
  String number;
  DateTime expiryDate;
  double balance;
  String bankName;
  String cardName;
  String type;
  String userId;

  CardModel({
    required this.id,
    required this.fullname,
    required this.number,
    required this.expiryDate,
    required this.balance,
    required this.bankName,
    required this.cardName,
    required this.type,
    required this.userId,
  });

  factory CardModel.fromMap(Map<String, dynamic> data, String documentId) {
    return CardModel(
      id: documentId,
      fullname: data['fullname'],
      number: data['number'],
      expiryDate: (data['expiryDate'] as Timestamp).toDate(),
      balance: data['balance'].toDouble(),
      bankName: data['bankName'],
      cardName: data['cardName'],
      type: data['type'],
      userId: data['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'number': number,
      'expiryDate': Timestamp.fromDate(expiryDate),
      'balance': balance,
      'bankName': bankName,
      'cardName': cardName,
      'type': type,
      'userId': userId,
    };
  }

  CardModel copyWith({
    String? id,
    String? fullname,
    String? number,
    DateTime? expiryDate,
    double? balance,
    String? bankName,
    String? cardName,
    String? type,
    String? userId,
  }) {
    return CardModel(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      number: number ?? this.number,
      expiryDate: expiryDate ?? this.expiryDate,
      balance: balance ?? this.balance,
      bankName: bankName ?? this.bankName,
      cardName: cardName ?? this.cardName,
      type: type ?? this.type,
      userId: userId ?? this.userId,
    );
  }
}
