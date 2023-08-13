import 'dart:io';

import 'package:add_video/components/add_Video/draft.dart';
import 'package:add_video/components/add_Video/draft_screen.dart';
import 'package:provider/provider.dart';
import 'package:add_video/components/add_Video/s_5_add_video_form/s_5_add_video_form_screen.dart';
import 'package:add_video/constant/constant.dart';
import './add_video_provider.dart';
import 'package:add_video/components/add_Video/s_3_video_grid.dart';
import 'package:flutter/material.dart';

class s_2_edit_video_screen extends StatefulWidget {
  static const namedRoute = "/s_2_edit_video_screen";
  const s_2_edit_video_screen({super.key});

  @override
  State<s_2_edit_video_screen> createState() => _s_2_edit_video_screenState();
}

class _s_2_edit_video_screenState extends State<s_2_edit_video_screen> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _add_video_provider = Provider.of<add_video_provider>(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // --------------------------------- camera -----------
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : s_3_video_grid_screen_screen(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Color.fromARGB(82, 0, 0, 0),
                height: 130,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                    ),
                    // ------------------------------------------------------------------------
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      // mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 65.0,
                          width: 65.0,
                          child: Stack(
                            children: [
                              Center(
                                child: GestureDetector(
                                    onTap: () {
                                      // _s_1_video_scre.check_popup();
                                      _add_video_provider.setback = false;
                                      // Navigator.pop(context);
                                      Navigator.maybePop(context);
                                    },
                                    // onTapUp: (_) async {

                                    // },
                                    child: const CircleAvatar(
                                        backgroundColor: colorAssets.ORANGE,
                                        radius: 30,
                                        child: CircleAvatar(
                                          backgroundColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          radius: 25,
                                          child: Icon(
                                            Icons.add,
                                            weight: 40,
                                            size: 42,
                                            color: colorAssets.ORANGE,
                                          ),
                                        ))),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "Add Video",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Consumer<add_video_provider>(
                          builder: (ctx, provider, child) => GestureDetector(
                              onTap: () {
                                if (provider.getItems.isEmpty) {
                                } else {
                                  print("clicked!");
                                  _add_video_provider.getFrame();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              add_video_form_screen()));
                                }
                                // ?Container(
                                //   height: 25.0,
                                //   width: 60.0,
                                //     color: Colors.black,
                                //   ):
                              },
                              child: Container(
                                  height: 50,
                                  width: 60,
                                  // color: Color.fromARGB(255, 218, 218, 218),
                                  decoration: const BoxDecoration(
                                      color: colorAssets.ORANGE,
                                      border: Border(),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ))),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            "Next",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: const Color.fromARGB(255, 0, 0, 0),
                height: 90,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _add_video_provider.setback = true;
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),

                        // height: 50,
                        // width: 50,
                        // decoration: BoxDecoration(
                        //     color: colorAssets.ORANGE,
                        //     border: Border.all(),
                        //     borderRadius: BorderRadius.all(Radius.circular(20))),

                        // color: colorAssets.ORANGE,
                        child: const Text(
                          "< Back",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.0,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: fontwightAssets.Bold,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                         draft _draft_provider =
                  Provider.of<draft>(context, listen: false);
              _draft_provider.loaddraftData();
                        
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                    
                        // height: 50,
                        // width: 50,
                        // decoration: BoxDecoration(
                        //     color: colorAssets.ORANGE,
                        //     border: Border.all(),
                        //     borderRadius: BorderRadius.all(Radius.circular(20))),
                    
                        // color: colorAssets.ORANGE,
                        child: const Text(
                          "EDIT",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22.0,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: fontwightAssets.Blank,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      height: 50,
                      width: 50,
                      // decoration: BoxDecoration(
                      //     color: colorAssets.ORANGE,
                      //     border: Border.all(),
                      //     borderRadius: BorderRadius.all(Radius.circular(20))),

                      // color: colorAssets.ORANGE,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.flash_off,
                              color: Color.fromARGB(255, 0, 0, 0))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
