import 'package:add_video/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class success_page extends StatelessWidget {
  const success_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("app baar"),),
      body: const Center(
        child: Text("successfully uploaded", style: TextStyle(fontSize: 20, fontWeight: fontwightAssets.Bold)),
      ),
    );
  }
}