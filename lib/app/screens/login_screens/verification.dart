import 'dart:math';

import 'package:flutter/material.dart';
import 'package:netCheques/app/screens/login_screens/utilities/slider_obj.dart';
import 'package:netCheques/app/screens/login_screens/utilities/radius_button.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({@required this.sliderObj});
  final SliderObj sliderObj;
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode myFocusNode = FocusNode();
  final ScrollController _scrollController = new ScrollController();
  final TextEditingController _textEditingController =
      new TextEditingController();
  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        _scrollController.animateTo(800,
            duration: new Duration(seconds: 1), curve: Curves.ease);
        _scrollController.jumpTo(200);
      }
    });

    WidgetsBinding.instance
        .addPostFrameCallback((_) => executeAfterBuildComplete(context));
  }

  void executeAfterBuildComplete([BuildContext context]) async {
    await Future.delayed(
        Duration(seconds: 2),
        () => {
              _textEditingController.text =
                  ((Random().nextDouble() + 1) * 100000).ceil().toString()
            });

    Future.delayed(
        Duration(milliseconds: 500),
        () => {
              if (_formKey.currentState.validate())
                {Navigator.of(context).pushNamed('/homePage')}
            });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Step 2",
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.purple,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  width: 400,
                  child: sliderItemWidget(widget.sliderObj, fontSize: 18)),
              Container(
                width: 300,
                height: 200,
                child: Form(
                  key: _formKey,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            child: TextFormField(
                              focusNode: myFocusNode,
                              controller: _textEditingController,
                              validator: (value) {
                                if (value.isEmpty) return 'Please enter otp';

                                if (value.length != 6)
                                  return 'Wrong otp entered';

                                return null;
                              },
                              maxLines: 1,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                // prefixIcon:  SvgPicture.asset('assets/svg/001-india.svg' , width: 20, height: 20,),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: RaisedButtonRounded(
                                title: "Continue",
                                func: () => {
                                      if (_formKey.currentState.validate())
                                        {
                                          Navigator.of(context)
                                              .pushNamed('/homePage')
                                        }
                                    },
                                bgColor: Colors.purple,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
