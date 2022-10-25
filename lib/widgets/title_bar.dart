import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  final String title;
  const TitleBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 20),child: Row(
      children: [
        const SizedBox(
          width: 20,
        ),
       /* InkWell(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),*/
        Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )),
        //   const Spacer(),
        /*const ProfilePicNavigatable(),
        const SizedBox(
          width: 20,
        )*/
      ],
    ),);
  }
}
