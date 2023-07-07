import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:payment_m/const.dart';
import 'package:payment_m/shared_pref_services.dart';


class PayByWalletScreen extends StatefulWidget {
  @override
  _PayByWalletScreenState createState() => _PayByWalletScreenState();
}

class _PayByWalletScreenState extends State<PayByWalletScreen> {

  final TextEditingController price=TextEditingController();

  @override
  Widget build(BuildContext context) {

    

    var configuration = PaymentSdkConfigurationDetails(
        profileId: Constant.profileId,
        serverKey: Constant.serverKey,
        clientKey: Constant.clientKey,
        merchantName: "merchant name",
        screentTitle: "Pay with Card",
        billingDetails: Constant.billingDetails,
        showShippingInfo: false,
        showBillingInfo: false,
        locale: PaymentSdkLocale.EN, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
        amount: double.tryParse(price.text)??0*10,
        currencyCode: "EGP",
        merchantCountryCode: "eg");

    var theme = IOSThemeConfigurations();
    theme.logoImage = "assets/logo.png";
    configuration.iOSThemeConfigurations = theme;
    configuration.showBillingInfo = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay by Wallet'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.center,
                child: Text('${SharedPreferencesServices.getDate(key: 'priceWallet')??0}',
                style: const TextStyle(fontSize: 25,color: Colors.teal),),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: price,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Enter Price",
                ),
                onChanged: (val){
                  setState(() {

                  });
                },
              ),

              const SizedBox(height: 10,),
              Image.asset('assets/pay.jpg'),
              const SizedBox(height: 10,),

             Row(
               children: [
                 Expanded(child: ElevatedButton.icon(
                   onPressed: () {
                     if(price.text.isNotEmpty){
                       FlutterPaytabsBridge.startCardPayment(configuration, (event) {
                         setState(() {
                           if (event["status"] == "success") {
                             var transactionDetails = event["data"];
                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                               content: Text('Payment Completed'),
                               backgroundColor:Colors.teal,
                             ));

                             if (transactionDetails["isSuccess"]) {

                               double priceWallet= SharedPreferencesServices.getDate(key: 'priceWallet')??0;
                               double newPriceWallet=priceWallet+double.parse(price.text);
                               SharedPreferencesServices.setDate(key: 'priceWallet',value: newPriceWallet);
                               price.clear();

                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                 content: Text('Payment Completed'),
                                 backgroundColor:Colors.teal,
                               ));
                             } else {
                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                 content: Text('Payment Failed'),
                                 backgroundColor:Colors.teal,
                               ));
                             }
                           }
                           else if (event["status"] == "error") {
                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                               content: Text('Payment Failed'),
                               backgroundColor:Colors.teal,
                             ));
                           } else if (event["status"] == "event") {
                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                               content: Text('Payment Failed'),
                               backgroundColor:Colors.teal,
                             ));
                           }
                         });
                       });
                     }else{
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                         content: Text('Please Enter Price'),
                         backgroundColor:Colors.teal,
                       ));

                     }
                   },
                   icon: const Icon(Icons.attach_money),
                   label: const Text("Charging the wallet"),
                 ),),
                 const SizedBox(width: 10,),
                 Expanded(child: ElevatedButton.icon(
                   onPressed: () {
                     if(price.text.isNotEmpty){
                       if(double.parse(SharedPreferencesServices.getDate(key: 'priceWallet').toString()??'0') >= double.parse(price.text)){
                         FlutterPaytabsBridge.startCardPayment(configuration, (event) {
                           setState(() {
                             if (event["status"] == "success") {
                               var transactionDetails = event["data"];
                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                 content: Text('Payment Completed'),
                                 backgroundColor:Colors.teal,
                               ));

                               if (transactionDetails["isSuccess"]) {
                                 double priceWallet= SharedPreferencesServices.getDate(key: 'priceWallet')??0;
                                 double newPriceWallet=priceWallet-double.parse(price.text);
                                 SharedPreferencesServices.setDate(key: 'priceWallet',value: newPriceWallet);

                                 price.clear();
                                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                   content: Text('Payment Completed'),
                                   backgroundColor:Colors.teal,
                                 ));
                               } else {
                                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                   content: Text('Payment Failed'),
                                   backgroundColor:Colors.teal,
                                 ));
                               }
                             }
                             else if (event["status"] == "error") {
                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                 content: Text('Payment Failed'),
                                 backgroundColor:Colors.teal,
                               ));
                             } else if (event["status"] == "event") {
                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                 content: Text('Payment Failed'),
                                 backgroundColor:Colors.teal,
                               ));
                             }
                           });
                         });
                       }else{
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                           content: Text('Price in Wallet Not more then this price'),
                           backgroundColor:Colors.teal,
                         ));
                       }

                     }else{
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                         content: Text('Please Enter Price'),
                         backgroundColor:Colors.teal,
                       ));

                     }
                   },
                   icon: const Icon(Icons.attach_money),
                   label: const Text("Withdraw from the wallet"),
                 ),),
               ],
             )
            ],
          ),
        ),
      ),
    );
  }
}