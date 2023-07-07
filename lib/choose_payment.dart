import 'package:flutter/material.dart';
import 'package:payment_m/Pay_wallet.dart';
import 'package:payment_m/credit.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         elevation: 0.0,
        backgroundColor: Colors.teal,
        title: const Text(
          "Now you can choose your payment method", // Add title here
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 18,

          ),
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>PayByWalletScreen()));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_balance_wallet, size: 50,
                      color: Colors.red[200]),
                  Text('Wallet',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.teal[700],
                      fontWeight: FontWeight.bold,
                    ), ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>PayWithCreditCard()));

              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.credit_card, size: 50,
                    color: Colors.red[200],),
                  Text('Credit',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.teal[700],
                      fontWeight: FontWeight.bold,
                    ),),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Hello :)',
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      ),
                      content: Text('You Can Pay To Driver',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[200],
                          fontFamily: 'Roboto',

                        ),
                      ),

                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.money, size: 50,
                    color:Colors.red[200],),
                  Text('Cash',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],



                    ),),
                ],
              ),
            ),
          ],
        ),
      )

    );
  }
}