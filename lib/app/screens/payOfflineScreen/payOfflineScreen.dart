import 'package:flutter/material.dart';
import 'package:netCheques/app/screens/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PayOfflineScreen extends StatelessWidget {
  const PayOfflineScreen({Key key}) : super(key: key);

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
          child: PayOfflineCard(),
        ),
      ),
    );
  }
}

class PayOfflineCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        QrImage(
          data: 'This is a simple QR code by @J-Nokwal',
          version: QrVersions.auto,
          size: 320,
          gapless: false,
        ),
        GestureDetector(
          onTap: () {
            print("Done");
            Navigator.pop(context);
          },
          child: Container(
            height: 40,
            width: 230,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: blueColor),
            child: Center(
                child: Text(
              "Done",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ],
    );
  }
}
