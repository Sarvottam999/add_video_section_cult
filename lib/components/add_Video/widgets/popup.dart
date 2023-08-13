import 'package:add_video/components/add_Video/s_5_add_video_form/s_5_add_video_form_screen.dart';
import 'package:add_video/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class popup_ok extends StatelessWidget {
  popup_ok(
      {super.key,
      required this.path,
      required this.text,
      required this.onPressed});
  String path;
  String text;
  GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.black),
          height: 400.0,
          // width: 420.0,
          // margin: EdgeInsets.only(left: 30.0, right: 30.0),
          padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
          // color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(path),
              Container(
                height: 80.0,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400)),
              ),
              TextButton(
                  onPressed: () {
                    // Navigator.pop(context, 'OK');

                    onPressed();

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => s_2_edit_video_screen()),
                    // );
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                        color: Color(0xffFB8C00),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ));
  }
}
