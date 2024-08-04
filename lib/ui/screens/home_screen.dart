import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vazifa_10/ui/screens/card_screen.dart';
import 'package:vazifa_10/ui/screens/payments_screen.dart';
import 'package:vazifa_10/ui/widgets/custom_drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vazifa_10/ui/widgets/show_dilog_card_add.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 20.h,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) => CardScreen(userId: userId),
                ),
              );
            },
            icon: Icon(Icons.card_travel_outlined),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) => PaymentScreen(),
                ),
              );
            },
            icon: Icon(Icons.transfer_within_a_station_rounded),
          ),
        ],
      ),
      drawer: CustomDrawerWidget(),
      body: Column(),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.amber.shade800,
        onPressed: () => showAddCardDialog(context, userId),
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
