import 'package:add_video/components/add_Video/widgets/timerCustomToast.dart';
import 'package:add_video/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class temp1 extends StatelessWidget {
  const temp1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("app bar"),),
      body: Container(
        child: Column(
          children: [ElevatedButton(onPressed: () {
            timerCustomToast.show(  context);
    
    
          }, child: Text("click")),
          
          
          ],
        ),
      ),
    );
  }
}
