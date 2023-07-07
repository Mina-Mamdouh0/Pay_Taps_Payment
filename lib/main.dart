import 'package:flutter/material.dart';
import 'package:payment_m/shared_pref_services.dart';


import 'Pay_wallet.dart';
import 'choose_payment.dart';
import 'credit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesServices.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MenuScreen(),
    );
  }
}

