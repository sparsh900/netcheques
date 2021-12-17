import 'dart:math';

import 'package:flutter/material.dart';
import 'package:netCheques/app/screens/colors.dart';

class SuccessFulPayment extends StatelessWidget {
  const SuccessFulPayment(
      {Key key, @required this.amount, @required this.phoneNumberReceiver})
      : super(key: key);
  final String phoneNumberReceiver;
  final double amount;
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
        width: _size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/images/backgroundImage.png"),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(2, 2),
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 2.0,
                spreadRadius: 0,
              ),
            ],
            color: pinkWhite,
          ),
          child: SuccessFulPaymentCard(
            amount: amount,
            phoneNumberReceiver: phoneNumberReceiver,
          ),
        ),
      ),
    );
  }
}

class SuccessFulPaymentCard extends StatelessWidget {
  SuccessFulPaymentCard(
      {@required this.phoneNumberReceiver, @required this.amount});
  final String phoneNumberReceiver;
  final double amount;
  @override
  Widget build(BuildContext context) {
    DateTime _time = DateTime.now();
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: blueColor,
        ),
        child: Icon(Icons.celebration, size: 60, color: pinkWhite),
      ),
      Column(
        children: [
          Text('You Successfully'),
          SizedBox(
            height: 10,
          ),
          Text('Send Money To $phoneNumberReceiver'),
          SizedBox(
            height: 10,
          ),
          Text('Rs $amount'),
        ],
      ),
      Container(
        margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
        decoration: BoxDecoration(
            color: lightBlue, borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Row(
            children: [
              Container(
                height: 65,
                width: 65,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: blueColor),
                child: Icon(
                  Icons.person,
                  color: pinkWhite,
                ),
              ),
              Expanded(child: Container()),
              Text(
                '$phoneNumberReceiver',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
      Column(
        children: [
          Text(
              'Transection Done on  ${_time.day}/${_time.month}/${_time.year} '),
          SizedBox(
            height: 10,
          ),
          Text(
              'Your Reference number is ${(Random().nextDouble() * 1000000).ceil()}')
        ],
      ),
      GestureDetector(
        onTap: () {
          print("Done");
          Navigator.of(context).popUntil(ModalRoute.withName("/homePage"));
        },
        child: Container(
          height: 40,
          width: 230,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: blueColor),
          child: Center(
            child: Text(
              "Done",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      )
    ]);
  }
}
