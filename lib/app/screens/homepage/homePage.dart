import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:netCheques/app/screens/colors.dart';
import 'package:netCheques/app/screens/homepage/utilities/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => {
                  SystemNavigator.pop(animated: true),
                  exit(0),
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    //final Widget svg = new SvgPicture.asset('assets/homeTopBackground.svg');
    // final String svgpath = "assets/homeTopBackground.svg";
    Size _sizeOfContext = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: pinkWhite,
        body: Stack(
          children: <Widget>[
            Container(
              child: Positioned(
                top: -20,
                width: _sizeOfContext.width,
                child: Image.asset(
                  'assets/images/homePageTopBackground.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: _sizeOfContext.height,
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    stretch: true,
                    onStretchTrigger: null,
                    expandedHeight: 150.0,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.fromLTRB(40, 20, 20, 20),
                      collapseMode: CollapseMode.pin,
                      title: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.amber),
                            child: Center(child: Text("+91")),
                          ),
                          FutureBuilder(
                              future: FlutterSession().get("phoneNumber"),
                              builder: (context, snapshot) =>
                                  Text(snapshot.data.toString()))
                        ],
                      ),
                    ),
                    automaticallyImplyLeading: false,
                    toolbarHeight: 80,
                    backgroundColor: Colors.transparent,
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.notifications_none_outlined),
                        tooltip: 'notifications',
                        onPressed: () {},
                      ),
                    ],
                    pinned: true,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      MainFeatures(),
                      FutureBuilder(
                        future: FlutterSession().get("type"),
                        builder: (context, snapshot) =>
                            snapshot.data.toString() == "merchants"
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: 10,
                                        bottom: 30,
                                        right: 15,
                                        left: 15),
                                    width: 350,
                                    height: 50,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      color: Color(0xFF7966FF),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('/hardWallet');
                                      },
                                      child: Text(
                                        "MERCHANT HARD WALLET",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 0,
                                  ),
                      ),
                      HomePageHistory(),
                      HomePagePromo(),
                      // Container(height: 250, color: Colors.amber),
                      // Container(height: 150, color: Colors.pink),
                      // Container(height: 180, color: Colors.indigo),
                      // Container(height: 280, color: Colors.pink),
                    ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainFeatures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
      child: Container(
        height: 150,
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
          color: whiteColor,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 4),
              child: Row(
                children: [
                  Text('My Balance'),
                  Expanded(
                    child: Container(),
                  ),
                  Text('Rs 2000')
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pushNamed('/send'),
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: pinkWhite,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/homePageSend.png',
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                      Text("Send")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () =>
                            Navigator.of(context).pushNamed('/payOfflieScreen'),
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: pinkWhite, shape: BoxShape.circle),
                          child: Center(
                            child: Image.asset(
                              'assets/images/homePagePay.png',
                              width: 60,
                            ),
                          ),
                        ),
                      ),
                      Text("Pay"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: pinkWhite, shape: BoxShape.circle),
                        child: Center(
                          child: Image.asset(
                            'assets/images/homePageTopUp.png',
                            width: 60,
                          ),
                        ),
                      ),
                      Text("Top Up"),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: pinkWhite, shape: BoxShape.circle),
                        child: Center(
                          child: Image.asset(
                            'assets/images/homePageRequest.png',
                            width: 50,
                          ),
                        ),
                      ),
                      Text("Request")
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 0, 35, 20),
      child: Container(
        height: 200,
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
          color: whiteColor,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 4, 30, 0),
              child: Row(
                children: [
                  Text('History'),
                  Expanded(
                    child: Container(),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 24,
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(" Utkarsh Singh"), Text("Rs 2800 ")],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(" Aditya Tiwari"), Text("Rs 1200 ")],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(" Aaryan"), Text("Rs 900 ")],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomePagePromo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CarouselController _carouselctrl = CarouselController();
    return Padding(
      padding: EdgeInsets.fromLTRB(1, 0, 1, 20),
      child: Container(
        height: 150,
        child: CarouselSlider(
          carouselController: _carouselctrl,
          options: CarouselOptions(
            autoPlay: true,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          items: [
            PromoContainer(
              backGroudImage: 'assets/images/containerBackground3.png',
              childImage: 'assets/images/homePageSend.png',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text("Pay at Shop"), Text("Get 10% off")],
              ),
            ),
            PromoContainer(
              backGroudImage: 'assets/images/containerBackground1.png',
              childImage: 'assets/images/homePageSend.png',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text("Pay at Shop"), Text("Get 10% off")],
              ),
            ),
            PromoContainer(
              backGroudImage: 'assets/images/containerBackground2.png',
              childImage: 'assets/images/homePageSend.png',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text("Pay at Shop"), Text("Get 10% off")],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
