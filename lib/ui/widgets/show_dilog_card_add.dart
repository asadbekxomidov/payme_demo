import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa_10/blocs/card/card_event.dart';
import 'package:vazifa_10/data/model/card_model.dart';
import 'package:vazifa_10/blocs/card/card_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showAddCardDialog(BuildContext context, String userId) {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add New Card',
            style: TextStyle(
              fontSize: 18.h,
            )),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: numberController,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: expiryDateController,
                decoration: InputDecoration(
                  labelText: 'Expiry Date (yyyy.MM.dd)',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: balanceController,
                decoration: InputDecoration(
                  labelText: 'Balance',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: bankNameController,
                decoration: InputDecoration(
                  labelText: 'Bank Name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: cardNameController,
                decoration: InputDecoration(
                  labelText: 'Card Name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                  labelText: 'Type',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.5)),
                    borderSide: BorderSide(
                      color: Colors.amber.shade900,
                      width: 3.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilledButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FilledButton(
                child: Text('Add Card'),
                onPressed: () {
                  String expiryDateStr = expiryDateController.text;
                  List<String> dateParts = expiryDateStr.split('.');
                  String formattedDate =
                      '${dateParts[0]}-${dateParts[1]}-${dateParts[2]}';
                  try {
                    final card = CardModel(
                      id: '',
                      fullname: fullNameController.text,
                      number: numberController.text,
                      expiryDate: DateTime.parse(formattedDate),
                      balance: double.parse(balanceController.text),
                      bankName: bankNameController.text,
                      cardName: cardNameController.text,
                      type: typeController.text,
                      userId: userId,
                    );

                    BlocProvider.of<CardBloc>(context).add(AddCard(card));

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Card added successfully!'),
                      ),
                    );

                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error adding card: ${e.toString()}'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
