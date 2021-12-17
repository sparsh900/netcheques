import 'package:flutter/material.dart';
import 'package:netCheques/app/screens/colors.dart';
import 'package:netCheques/app/screens/login_screens/utilities/radius_button.dart';
import 'package:netCheques/services/api.dart';
import 'package:netCheques/services/api_services.dart';
import 'package:toast/toast.dart';

class SendScreen extends StatefulWidget {
  @override
  _SendScreenState createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  bool isSwitched = false;
  final _formKey = GlobalKey<FormState>();
  Future<bool> isSuccessFulTransaction() async {
    var message;
    try {
      APIService apiService = APIService(api: API.sandbox());
      message = await apiService.doSend(
        amount: double.parse(amountController.text),
        phoneNumber: phoneController.text,
        toWhom: isSwitched ? "merchants" : "users",
      );
    } on Exception catch (e) {
      print(e);
      return false;
    }

    if (message['statusCode'] == 200) {
      return true;
    } else {
      Toast.show(message['message'], context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _sizeOfContext = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: pinkWhite,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.purple,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(
            "Send Online",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Stack(children: <Widget>[
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
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      height: 500,
                      padding: EdgeInsets.all(20.0),
                      child: Card(
                        elevation: 6,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 30),
                                width: 300,
                                child: TextFormField(
                                  controller: phoneController,
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "Please enter receiver's number";

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
                              Container(
                                width: 300,
                                child: TextFormField(
                                  controller: amountController,
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return 'Please enter amount';

                                    if (double.parse(value) > 1000000)
                                      return 'Transactions Limited to 10 lakh rupees';
                                    return null;
                                  },
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "₹ Amount",
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    // prefixIcon:  SvgPicture.asset('assets/svg/001-india.svg' , width: 20, height: 20,),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 30),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Sending to merchant account ?",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                          maxLines: 2,
                                        ),
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
                              Container(
                                child: RaisedButtonRounded(
                                    title: "Continue",
                                    func: () async => {
                                          if (_formKey.currentState.validate())
                                            {
                                              FocusScope.of(context).unfocus(),
                                              if (await isSuccessFulTransaction())
                                                Navigator.of(context).pushNamed(
                                                    '/successFulPayment',
                                                    arguments: {
                                                      'phoneNumberReceiver':
                                                          phoneController.text,
                                                      'amount': double.parse(
                                                          amountController.text)
                                                    })
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
                  ]),
                )
              ],
            ),
          ),
        ]));
  }
}
