import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:netCheques/app/screens/colors.dart';
import 'package:netCheques/app/screens/login_screens/utilities/radius_button.dart';
import 'package:netCheques/services/api.dart';
import 'package:netCheques/services/api_services.dart';
import 'package:toast/toast.dart';

class Merchantform extends StatefulWidget {
  _MerchantformState createState() => _MerchantformState();
}

class _MerchantformState extends State<Merchantform> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  Future<bool> isSubmitted() async {
    var message;
    try {
      APIService apiService = APIService(api: API.sandbox());
      message = await apiService.doSubmitRequestForHardWallet(
          discount: double.parse(discountController.text),
          walletName: nameController.text);
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

  // final TextEditingController extra;
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
            "SET UP YOUR WALLET",
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
                          height: 500, //700
                          padding: EdgeInsets.all(20.0),
                          child: Card(
                              elevation: 6,
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: _buildForm(),
                              ))),
                    ]))
                  ]))
        ]));
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    controller: nameController,
                    validator: (value) => value.isNotEmpty
                        ? null
                        : 'Wallet`s Name can\'t be empty',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color(0xFF000000),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle:
                          TextStyle(fontSize: 15, color: Color(0xFF7966FF)),
                      labelText: 'Enter Your Wallet`s Name',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 21),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 20.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: TextFormField(
                    controller: discountController,
                    validator: (value) => value.isNotEmpty
                        ? null
                        : 'discount percentage can\'t be empty',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: Color(0xFF000000),
                          width: 3,
                        ),
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
                      counterStyle:
                          TextStyle(fontSize: 15, color: Color(0xFF7966FF)),
                      labelText: 'Enter the discount (in percentage)',
                    ),
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(height: 21),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Expanded(
          //       child: Container(
          //         decoration: BoxDecoration(
          //             shape: BoxShape.rectangle,
          //             color: Colors.white,
          //             boxShadow: [
          //               new BoxShadow(
          //                 color: Color(0x0D000000),
          //                 blurRadius: 20.0,
          //               ),
          //             ],
          //             borderRadius: BorderRadius.circular(6)),
          //         child: TextFormField(
          //           validator: (value) => value.isNotEmpty
          //               ? null
          //               : 'Mobile Number can\'t be empty',
          //           textInputAction: TextInputAction.next,
          //           keyboardType: TextInputType.name,
          //           decoration: InputDecoration(
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(6),
          //               borderSide: BorderSide(
          //                 color: Color(0xFF000000),
          //                 width: 3,
          //               ),
          //             ),
          //             contentPadding:
          //                 EdgeInsetsDirectional.fromSTEB(13, 17, 0, 17),
          //             counterStyle:
          //                 TextStyle(fontSize: 15, color: Color(0xFF7966FF)),
          //             labelText: 'Enter Your Mobile number',
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(height: 55),
          Text(
            "* The percentage you add is cashback you are offering to customer from your pocket",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
          Container(
              margin: EdgeInsets.only(top: 50, bottom: 15, left: 15, right: 15),
              width: 360,
              height: 45,
              child: RaisedButtonRounded(
                bgColor: Colors.purple,
                color: Colors.white,
                title: "Done",
                func: () async {
                  if (_formKey.currentState.validate()) {
                    // Toast.show("Successfully Registered ", context,
                    //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                    FocusScope.of(context).unfocus();
                    if (await isSubmitted()) {
                      await showDialog(
                        context: context,
                        builder: (context) => new AlertDialog(
                          title: new Text('Successful'),
                          content: new Text(
                              'You have registered successfully for hard wallet'),
                          actions: <Widget>[
                            new FlatButton(
                              onPressed: () => {
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/homePage')),
                              },
                              child: new Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
              )),
        ],
      ),
    );
  }
}
