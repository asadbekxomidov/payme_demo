import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vazifa_10/data/model/card_model.dart';

class CardRepository {
  final CollectionReference cardsCollection = FirebaseFirestore.instance.collection('cards');

  Future<void> addCard(CardModel card) async {
    try {
      await cardsCollection.add(card.toMap());
    } catch (e) {
      print("Error adding card: $e");
      throw e;
    }
  }

  Future<void> updateCard(CardModel card) async {
    try {
      await cardsCollection.doc(card.id).update(card.toMap());
    } catch (e) {
      print("Error updating card: $e");
      throw e;
    }
  }

  Future<void> deleteCard(String id) async {
    try {
      await cardsCollection.doc(id).delete();
    } catch (e) {
      print("Error deleting card: $e");
      throw e;
    }
  }

  Future<List<CardModel>> fetchCards(String userId) async {
    try {
      final querySnapshot = await cardsCollection.where('userId', isEqualTo: userId).get();
      return querySnapshot.docs.map((doc) => CardModel.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } catch (e) {
      print("Error fetching cards: $e");
      throw e;
    }
  }
}
