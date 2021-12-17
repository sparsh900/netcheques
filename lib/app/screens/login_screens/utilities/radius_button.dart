import 'package:flutter/material.dart';

class RaisedButtonRounded extends StatelessWidget {
  RaisedButtonRounded(
      {@required this.title,
      @required this.func,
      @required this.bgColor,
      @required this.color});
  final String title;
  final func;
  final Color bgColor;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: bgColor,
        onPressed: func,
        child: Text(
          title,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
