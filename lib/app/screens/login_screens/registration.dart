import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netCheques/app/screens/login_screens/utilities/slider_obj.dart';
import 'package:netCheques/app/screens/login_screens/utilities/radius_button.dart';
import 'package:netCheques/services/api.dart';
import 'package:netCheques/services/api_services.dart';
import 'package:toast/toast.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({@required this.sliderObj});
  final SliderObj sliderObj;
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode myFocusNode = FocusNode();
  final ScrollController _scrollController = new ScrollController();

  final passwordController = new TextEditingController();
  final phoneNumberController = new TextEditingController();

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
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<bool> isLoginRegistered() async {
    int message;
    try {
      APIService apiService = APIService(api: API.sandbox());
      message = await apiService.doAuth(
          password: passwordController.text,
          phoneNumber: phoneNumberController.text);
    } on Exception catch (e) {
      print(e);
      return false;
    }

    if (message == 200) {
      var session = FlutterSession();
      await session.set("phoneNumber", phoneNumberController.text);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Step 1",
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
                height: 300,
                child: Form(
                  key: _formKey,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/svg/001-india.svg',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            Container(
                              width: 200,
                              child: TextFormField(
                                focusNode: myFocusNode,
                                controller: phoneNumberController,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Please enter your number';

                                  if (value.length != 10 ||
                                      int.parse(value[0].toString()) < 6)
                                    return 'Wrong number entered';

                                  return null;
                                },
                                maxLines: 1,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: "Mobile Number",
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  // prefixIcon:  SvgPicture.asset('assets/svg/001-india.svg' , width: 20, height: 20,),
                                ),
                              ),
                            ),
                          ]),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              Container(
                                width: 200,
                                child: TextFormField(
                                  // focusNode: myFocusNode,
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return 'Please enter your passsword';

                                    if (value.length < 8)
                                      return 'Weak password';

                                    return null;
                                  },
                                  maxLines: 1,

                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    // prefixIcon:  SvgPicture.asset('assets/svg/001-india.svg' , width: 20, height: 20,),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: RaisedButtonRounded(
                                title: "Continue",
                                func: () async => {
                                      if (_formKey.currentState.validate())
                                        {
                                          if (await isLoginRegistered())
                                            Navigator.of(context)
                                                .pushNamed('/verification')
                                          else
                                            Toast.show(
                                                "Error ${widget.sliderObj.title}",
                                                context,
                                                duration: Toast.LENGTH_SHORT,
                                                gravity: Toast.BOTTOM)
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
