import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:netCheques/app/screens/login_screens/utilities/slider_obj.dart';
import 'package:netCheques/app/screens/login_screens/utilities/radius_button.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  int _current = 0;
  bool isSwitched = false;

  List<SliderObj> list = [
    SliderObj(
        title: "Let's Get Started",
        description: "Never a better time to start making transactions offline",
        path: "assets/svg/get_started_1.svg"),
    SliderObj(
        title: "Offline Transactions",
        description: "You don't need to be online every time !!",
        path: "assets/svg/wallet.svg")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          CarouselSlider(
            options: CarouselOptions(
                height: 360,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: list.map((item) => sliderItemWidget(item)).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: list.map((url) {
              int index = list.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Colors.purple
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.only(top: 90, bottom: 15),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Are you a merchant ?",
                style: TextStyle(fontSize: 16),
              ),
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                  });
                },
                activeTrackColor: Colors.purpleAccent,
                activeColor: Colors.purple,
              ),
            ]),
          ),
          RaisedButtonRounded(
            title: "Login/Create an account",
            bgColor: Colors.purple,
            color: Colors.white,
            func: () {
              if (isSwitched) {
                FlutterSession().set("type", "merchants");
              } else {
                FlutterSession().set("type", "users");
              }
              Navigator.of(context).pushNamed('/registration');
            },
          ),
          // RaisedButtonRounded(
          //     title: "Login to Account",
          //     bgColor: Colors.white,
          //     color: Colors.purple,
          //     func: () => Navigator.of(context).pushNamed('/login')),
        ],
      ),
    );
  }
}
