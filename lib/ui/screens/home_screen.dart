import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa_10/blocs/card/card_bloc.dart';
import 'package:vazifa_10/data/model/card_model.dart';
import 'package:vazifa_10/data/repositories/card_repository.dart';
import 'package:vazifa_10/ui/widgets/custom_drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return BlocProvider(
      create: (context) =>
          CardBloc(cardRepository: CardRepository())..add(LoadCards(userId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(
              fontSize: 20.h,
            ),
          ),
          centerTitle: true,
        ),
        drawer: CustomDrawerWidget(),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CardBloc, CardState>(
                builder: (context, state) {
                  if (state is CardLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CardLoaded) {
                    return ListView.builder(
                      itemCount: state.cards.length,
                      itemBuilder: (context, index) {
                        final card = state.cards[index];
                        return ListTile(
                          title: Text(card.fullname),
                          subtitle: Text(card.number),
                        );
                      },
                    );
                  } else if (state is CardOperationFailure) {
                    return Center(
                        child: Text('Failed to load cards: ${state.error}'));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddCardDialog(context, userId),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _showAddCardDialog(BuildContext context, String userId) {
    final TextEditingController fullnameController = TextEditingController();
    final TextEditingController numberController = TextEditingController();
    final TextEditingController balanceController = TextEditingController();
    final TextEditingController bankNameController = TextEditingController();
    final TextEditingController cardNameController = TextEditingController();
    final TextEditingController typeController = TextEditingController();
    DateTime? selectedDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Card'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: fullnameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                ),
                TextField(
                  controller: numberController,
                  decoration: InputDecoration(labelText: 'Card Number'),
                ),
                TextField(
                  controller: balanceController,
                  decoration: InputDecoration(labelText: 'Balance'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: bankNameController,
                  decoration: InputDecoration(labelText: 'Bank Name'),
                ),
                TextField(
                  controller: cardNameController,
                  decoration: InputDecoration(labelText: 'Card Name'),
                ),
                TextField(
                  controller: typeController,
                  decoration: InputDecoration(labelText: 'Type'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (date != null) {
                      selectedDate = date;
                    }
                  },
                  child: Text('Select Expiry Date'),
                ),
                if (selectedDate != null)
                  Text('Selected Date: ${selectedDate!.toLocal()}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Please select a valid expiry date')),
                  );
                  return;
                }

                final card = CardModel(
                  id: '',
                  userId: userId,
                  fullname: fullnameController.text,
                  number: numberController.text,
                  expiryDate: selectedDate!,
                  balance: double.parse(balanceController.text),
                  bankName: bankNameController.text,
                  cardName: cardNameController.text,
                  type: typeController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
