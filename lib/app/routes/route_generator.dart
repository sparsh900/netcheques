import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netCheques/app/screens/hardWallet/hardWallet.dart';
import 'package:netCheques/app/screens/homepage/homePage.dart';
import 'package:netCheques/app/screens/login_screens/utilities/slider_obj.dart';
import 'package:netCheques/app/screens/login_screens/get_started.dart';
import 'package:netCheques/app/screens/login_screens/registration.dart';
import 'package:netCheques/app/screens/login_screens/verification.dart';
import 'package:netCheques/app/screens/payOfflineScreen/payOfflineScreen.dart';
import 'package:netCheques/app/screens/sendScreens.dart/send.dart';
import 'package:netCheques/app/screens/successFulPaymentScreen/successfulPayment.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    if (args != null) print(args);
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => GetStarted());
      case '/registration':
        return MaterialPageRoute(
            builder: (_) => RegistrationScreen(
                  sliderObj: SliderObj(
                      title: "Registration/Login",
                      description:
                          "Enter your mobile number we will send you an OTP to verify you later",
                      path: "assets/svg/001-online-voting.svg"),
                ));
      case '/login':
        return MaterialPageRoute(
            builder: (_) => RegistrationScreen(
                  sliderObj: SliderObj(
                      title: "Login",
                      description: "Enter your mobile number to login",
                      path: "assets/svg/002-password.svg"),
                ));
      case '/verification':
        return MaterialPageRoute(
            builder: (_) => VerificationScreen(
                  sliderObj: SliderObj(
                      title: "Verification",
                      description: "Enter your otp sent to your mobile",
                      path: "assets/svg/002-password.svg"),
                ));
      case '/homePage':
        return MaterialPageRoute(
            settings: RouteSettings(name: "/homePage"),
            builder: (_) => HomeScreen());
      case '/send':
        return MaterialPageRoute(builder: (_) => SendScreen());
      case '/successFulPayment':
        {
          var data = settings.arguments as Map;
          double amount = data['amount'];
          String phoneNumberReceiver = data['phoneNumberReceiver'];
          return MaterialPageRoute(
              builder: (_) => SuccessFulPayment(
                    amount: amount,
                    phoneNumberReceiver: phoneNumberReceiver,
                  ));
        }
      case '/payOfflieScreen':
        return MaterialPageRoute(builder: (_) => PayOfflineScreen());
      case '/hardWallet':
        return MaterialPageRoute(builder: (_) => Merchantform());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff9958b7), Color(0x00ffffff)])),
          child: Center(
            child: Text("Error"),
          ),
        ),
      );
    });
  }
}
