import 'package:employee_details/Utils/responsive_template.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final SizeInfo size;
  final String leading;
  final String data;
  final double? dataFontSize;
  final double? leadingFontSize;

  const TextWidget({
    required this.size,
    required this.leading,
    required this.data,
    this.dataFontSize,
    this.leadingFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "${leading} : ",
        style: TextStyle(
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
          fontSize: leadingFontSize ?? size.height * 0.025,
          color: Colors.black54,
        ),
        children: <TextSpan>[
          TextSpan(
            text: data,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: dataFontSize ?? size.height * 0.02,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
