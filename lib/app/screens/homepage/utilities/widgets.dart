import 'package:flutter/material.dart';
import 'package:netCheques/app/screens/colors.dart';

class PromoContainer extends StatelessWidget {
  final String backGroudImage;
  final String childImage;
  final Widget child;
  const PromoContainer({
    Key key,
    @required this.backGroudImage,
    @required this.childImage,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: blueColor,
        image: DecorationImage(
            image: AssetImage(backGroudImage), fit: BoxFit.fill),
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(childImage)),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: child,
          ),
        ],
      ),
    );
  }
}
