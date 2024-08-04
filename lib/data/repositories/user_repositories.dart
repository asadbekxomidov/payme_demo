import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vazifa_10/data/model/card_model.dart';
import 'package:vazifa_10/data/model/user_model.dart';

class UserRepository {
  final usersCollection = FirebaseFirestore.instance.collection("users");
  final usersImageStorage = FirebaseStorage.instance;

  Stream<List<UserModel>> getUsers() {
    return usersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return UserModel.fromMap(data, doc.id);
      }).toList();
    });
  }

  Stream<DocumentSnapshot> getUserById(String id) {
    return usersCollection.doc(id).snapshots();
  }

  Future<void> editUser(UserModel user) async {
    try {
      await usersCollection.doc(user.id).update(user.toMap());
    } catch (e) {
      throw Exception('Foydalanuvchini tahrirlashda xatolik: $e');
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      await usersCollection.doc(user.id).set(user.toMap());
    } catch (e) {
      print("Error adding user: $e");
      throw e;
    }
  }

  Future<void> transferMoney(
      String fromCardId, String toCardId, double amount) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final fromCardRef = firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cards')
          .doc(fromCardId);
      final toCardRef = firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('cards')
          .doc(toCardId);

      await firestore.runTransaction((transaction) async {
        final fromCardSnapshot = await transaction.get(fromCardRef);
        final toCardSnapshot = await transaction.get(toCardRef);

        if (!fromCardSnapshot.exists || !toCardSnapshot.exists) {
          throw Exception('Card not found');
        }

        final fromCard =
            CardModel.fromMap(fromCardSnapshot.data()!, fromCardSnapshot.id);
        final toCard =
            CardModel.fromMap(toCardSnapshot.data()!, toCardSnapshot.id);

        if (fromCard.balance < amount) {
          throw Exception('Insufficient funds');
        }

        transaction.update(fromCardRef, {'balance': fromCard.balance - amount});
        transaction.update(toCardRef, {'balance': toCard.balance + amount});
      });
    } catch (e) {
      throw Exception("Pul o'tkazmasida xatolik: $e");
    }
  }
}
