import 'package:add_video/constant/constant.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class timerCustomToast {
  static void show(  BuildContext context) {
    Color textColor = Colors.white;
    dismiss();
    timerCustomToast._createView(  context, textColor);
  }

  static OverlayEntry? _overlayEntry;
  static bool isVisible = false;

  static void _createView(
   
    BuildContext context,
     Color textColor,
  ) async {
    var overlayState = Overlay.of(context);

    // final themeData = Theme.of(context);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => _ToastAnimatedWidget(
        // child: 
      ),
    );
    isVisible = true;
    overlayState!.insert(_overlayEntry!);
  }

  static dismiss() async {
    if (!isVisible) {
      return;
    }
    isVisible = false;
    _overlayEntry?.remove();
  }
}
// ===================================================================
class _ToastAnimatedWidget extends StatefulWidget {
  _ToastAnimatedWidget({
    Key? key,
    // required this.child,
  }) : super(key: key);

  // final Widget child;

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastAnimatedWidget>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  int _start = 60;
  bool   _isVisible =  true; //update this value later
    Color backgroundColor = Color.fromARGB(255, 211, 211, 211);
 
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
      Duration?  oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec!,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _isVisible = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

    setText(){




    return  _timer!.tick <= 1?  "timer started": "${60 - _timer!.tick}";
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 150.0,
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 700),
          opacity: _isVisible ? 1.0 : 0.0,
          child: Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              child:
                  Text(setText(), softWrap: true, style: textstyleAssets.Regular12),
            ),
          ),
        ),
        ));
  }
}
