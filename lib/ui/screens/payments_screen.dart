import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vazifa_10/ui/screens/home_screen.dart';
import 'package:vazifa_10/ui/widgets/formated_card_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _senderCardNumberController = TextEditingController();
  final _recipientCardNumberController = TextEditingController();
  final _amountController = TextEditingController();
  late final String _userId;

  @override
  void initState() {
    super.initState();
    _userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20.h,
            )),
        title: Text(
          'Transfer Money',
          style: TextStyle(fontSize: 20.h),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Icon(Icons.abc, size: 200, color: Colors.amber.shade700),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _senderCardNumberController,
                  inputFormatters: [CardNumberFormatter()],
                  decoration: InputDecoration(
                    labelText: 'Sender Card Number',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the sender card number';
                    }
                    final cardNumber = value.replaceAll(' ', '');
                    if (cardNumber.length != 16) {
                      return 'Invalid card number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _recipientCardNumberController,
                  decoration: InputDecoration(
                    labelText: 'Recipient Card Number',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the recipient card number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 200.h),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('Form is valid');
                        final senderCardNumber =
                            _senderCardNumberController.text;
                        final recipientCardNumber =
                            _recipientCardNumberController.text;
                        final amount = double.parse(_amountController.text);
                        print('Sender Card Number: $senderCardNumber');
                        print('Recipient Card Number: $recipientCardNumber');
                        print('Amount: $amount');
                      } else {
                        print('Form is invalid');
                      }
                    },
                    child: Text('Transfer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
