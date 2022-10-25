import 'package:flutter/material.dart';

import '../utilities/top_level_variables.dart';

class Btn extends StatelessWidget {
  final VoidCallback onClicked;
  final String label;
  final IconData? iconData;
  final Size? size;
  final Color? color;
  final Color? iconColor;
  final TextStyle? textStyle;
  const Btn({Key? key, required this.onClicked, required this.label, this.iconData, this.size, this.textStyle, this.color, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size btnSize = Size(screenWidth!/1.6, 35);
    return ElevatedButton(
        onPressed: onClicked,
        style: ButtonStyle(
         // backgroundColor: MaterialStateProperty.all(color??appTheme.primaryColor),
            backgroundColor: MaterialStateProperty.all(Colors.green),
          minimumSize: size == Size.zero ? null : MaterialStateProperty.all<Size>(size??btnSize),
          maximumSize: size == Size.zero ? null : MaterialStateProperty.all<Size>(size??btnSize),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green),
                  //  side: BorderSide(color: color??appTheme.primaryColor)
                )
            )
        ),
        child: Stack(
          children: [
            Icon(iconData, color: iconColor,),
           // SizedBox(width: screenWidth/12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Container(
                 padding: const EdgeInsets.symmetric(vertical: 5),
                 child: Text(label,style: textStyle??const TextStyle(color: Colors.white),),
               )
              ],
            )
          ],
        ));
  }
}
