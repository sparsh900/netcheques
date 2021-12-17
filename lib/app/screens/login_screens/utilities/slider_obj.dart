import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SliderObj {
  SliderObj(
      {@required this.title, @required this.path, @required this.description});
  final String title;
  final String description;
  final String path;
}

Widget sliderItemWidget(SliderObj item, {double fontSize=16}) {
  return Column(
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SvgPicture.asset(
        item.path,
        height: 200,
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          item.description,
          style: TextStyle(
            color: Colors.grey,
              fontSize: fontSize
          ),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 3,

        ),
      )
    ],
  );
}
