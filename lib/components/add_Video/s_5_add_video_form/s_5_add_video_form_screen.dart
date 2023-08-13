import 'dart:io';

import 'package:add_video/components/add_Video/draft.dart';
import 'package:add_video/components/add_Video/draft_screen.dart';
import 'package:add_video/components/add_Video/s_1_video_screen.dart';
import 'package:add_video/components/add_Video/widgets/popup.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:add_video/components/add_Video/add_video_provider.dart';
import 'package:add_video/constant/constant.dart';
import 'package:location/location.dart';

// import 'package:path_provider/path_provider.dart';
import 'package:add_video/components/add_Video/s_5_add_video_form/successPage.dart';
// import 'package:tryapp/components/edit_profile_screen.dart/form/dropdowns/drop1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:video_player/video_player.dart';
// import 'package:textfield_tags/textfield_tags.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:material_tag_editor/tag_editor_layout_delegate.dart';
import 'package:material_tag_editor/tag_layout.dart';
import 'package:material_tag_editor/tag_render_layout_box.dart';

// final text1 =   GoogleFonts.poppins( fontSize: 16, color: Colors.white,
//   fontWeight: FontWeight.w700,
// );

// text1({size = 16.0, color = Colors.white, fontWeight = FontWeight.w700}) {
//   return TextStyle(
//       fontSize: size, color: color, fontWeight: fontWeight);
// }

class add_video_form_screen extends StatefulWidget {
  static const namedRoute = "/s_5_add_video_form_screen";
  // final List videos;
  const add_video_form_screen({Key? key}) : super(key: key);
  @override
  _add_video_form_screenState createState() => _add_video_form_screenState();
}

class _add_video_form_screenState extends State<add_video_form_screen> {
  final _formKey = GlobalKey<FormState>();

  // var dropdownAvailabilty;
  String Describe_experience = "";
  String Review_place = "";
  // int rate_experience = 0;
  // bool? draft;
  // String authority = "";
  // String location = "";
  // List<File> allFileList = [];
  CameraController? _cameraController;

  String dropdownValueAvailabilty = 'Private';
  var dropdownValueAvailabiltyitems = <String>[
    'Private',
    'Public',
  ];

  String dropdownCategory = 'Solo Trip';
  var dropdownvalueCategoryItems = <String>[
    'Solo Trip',
    'Family Trip',
    "Local Visits",
    "Nearby Outings",
    "Visits with friends",
    "Attended festivals",
    "Food and restaurants",
    "Pubs & bars",
    "Fashion"
  ];

  String dropdownGenre = 'Lifestyle';
  var dropdownvalueGenreItems = <String>[
    'Lifestyle',
    'Heritage Visits',
    'Art & Culture',
    'Museum',
    "Wildlife attractions",
    "Advanture Places",
    "Entertainment Parks",
    "National Parks",
    "Festivals",
    "Markets",
    "Cliffs / Mountains",
    "Waterfalls",
    "Forests",
    "Beaches",
    "Riversites",
    "Resorts",
    "Invsion Sites",
    "Island",
    "Caves",
    "Exhibition",
    "Food Culture",
    "Fashion",
    "Handycrafts",
    "Famous Products",
    "Party Culture",
    "Haunted places",
    "Aquatic Ecosystem"
  ];

  var _isInit = false;
  VideoPlayerController? videoController;
  bool play = false;
  List loader_video = [];
  // ---------------------- star count ----------------------------
  int star_count = 0;

  // ---------------- pros values -------------
  List<String> pros_list = ["verry good", "lovely", "amazing", "incredible"];
  List<String> Pros_values = [];
  List<String> _build_pros_ChoiceList_list = [];
  bool pros_flag = false;

  // ---------------- cons values -------------
  List<String> cons_list = ["Not_relevant", "Illegal", "Spam", "Offensive"];
  List<String> cons_values = [];
  List<String> _build_cons_ChoiceList_list = [];
  bool cons_flag = false;

  bool progress = false;
  late FocusNode Node1Describe;
  late FocusNode Node2pros;
  late FocusNode Node3cons;
  late FocusNode Node4review;

  @override
  void initState() {
    super.initState();
    // Provider.of<add_video_provider>(context, listen: false)
    // .get_current_address();
    Node1Describe = FocusNode();
    Node2pros = FocusNode();
    Node3cons = FocusNode();
    Node4review = FocusNode();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  onDelete1(index) {
    setState(() {
      Pros_values.removeAt(index);
    });
  }

  onDelete2(index) {
    setState(() {
      cons_values.removeAt(index);
    });
  }

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     Provider.of<add_video_provider>(context, listen: false)
  //         .get_current_address();
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }
  // void testAlert(BuildContext context) {
  // showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Scaffold(
  //         body: Container(
  //             alignment: AlignmentDirectional.center,
  //             decoration: BoxDecoration(
  //               color: Colors.white70,
  //             ),
  //             child: Container(
  //                 decoration: BoxDecoration(
  //                     color: Colors.blue[200],
  //                     borderRadius: BorderRadius.circular(10.0)),
  //                 width: 300.0,
  //                 height: 200.0,
  //                 alignment: AlignmentDirectional.center,
  //                 child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       Center(
  //                         child: SizedBox(
  //                           height: 50.0,
  //                           width: 50.0,
  //                           child: CircularProgressIndicator(
  //                             value: null,
  //                             strokeWidth: 7.0,
  //                           ),
  //                         ),
  //                       ),
  //                       Container(
  //                         margin: const EdgeInsets.only(top: 25.0),
  //                         child: Center(
  //                           child: Text(
  //                             "loading.. wait...",
  //                             style: TextStyle(color: Colors.white),
  //                           ),
  //                         ),
  //                       )
  //                     ]))),
  //       );
  //     });
  // }

// ----------------------------------------------------------------------

  _build_pros_ChoiceList() {
    List<Widget> choices2 = [];
    pros_list.forEach((item) {
      choices2.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          shape: const StadiumBorder(
              side: BorderSide(color: colorAssets.ORANGE, width: 1)),
          labelStyle: const TextStyle(color: Colors.white),
          selectedColor: colorAssets.ORANGE,
          backgroundColor: colorAssets.BLACK,
          label: Text(item),
          selected: _build_pros_ChoiceList_list.contains(item),
          onSelected: (selected) {
            setState(() {
              // selectedChoice = item;
              // print(selectedChoices.first);
              _build_pros_ChoiceList_list.contains(item)
                  ? _build_pros_ChoiceList_list.remove(item)
                  : _build_pros_ChoiceList_list.add(item);
            });
          },
        ),
      ));
    });
    return choices2;
  }

  _build_cons_ChoiceList() {
    List<Widget> choices1 = [];
    cons_list.forEach((item) {
      choices1.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          shape: const StadiumBorder(
              side: BorderSide(color: colorAssets.ORANGE, width: 1)),
          labelStyle: const TextStyle(color: Colors.white),
          selectedColor: colorAssets.ORANGE,
          backgroundColor: colorAssets.BLACK,
          label: Text(item),
          selected: _build_cons_ChoiceList_list.contains(item),
          onSelected: (selected) {
            setState(() {
              // selectedChoice = item;
              // print(selectedChoices.first);
              _build_cons_ChoiceList_list.contains(item)
                  ? _build_cons_ChoiceList_list.remove(item)
                  : _build_cons_ChoiceList_list.add(item);

              print(_build_cons_ChoiceList_list);
              print([...cons_values, ..._build_cons_ChoiceList_list]);
            });
          },
        ),
      ));
    });
    return choices1;
  }

  @override
  void dispose() {
    super.dispose();
    // Clean up the focus node when the Form is disposed.
    Node1Describe.dispose();
    Node2pros.dispose();
    Node3cons.dispose();
    Node4review.dispose();
  }

  draft_show_dialog() {
    return showDialog<String>(
      barrierColor: Color.fromARGB(113, 135, 135, 135),
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => popup_ok(
        path: asset.draft_icon,
        text: "Your Draft is saved, you can check your drafts on settings.",
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            s_1_video_screen.namedRoute,
            (route) => false, // Remove all routes from stack
          );
        },
      ),
    );
  }

  publish_show_dialog() {
    return showDialog<String>(
      barrierColor: Color.fromARGB(113, 135, 135, 135),
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => popup_ok(
        path: asset.addVideo_Popup,
        text: "You successfully upload your Story !.",
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            s_1_video_screen.namedRoute,
            (route) => false, // Remove all routes from stack
          );
        },
      ),
    );
  }

  // @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    add_video_provider _add_video_provider =
        Provider.of<add_video_provider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // ------------------------- app bar ---------------
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        title: const Text(
          'COMPOSE',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        leadingWidth: 100.0,
        leading: Container(
            alignment: Alignment.center,
            // padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "< Back",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ))),
        actions: [
          GestureDetector(
            onTap: () {
              print("clikded");
              draft _draft_provider =
                  Provider.of<draft>(context, listen: false);
              _draft_provider.clear_all_draft();
            },
            child: Icon(
              Icons.settings,
              size: 25,
            ),
          )
        ],
      ),

      // ------------------------------------------------------
      body: SafeArea(
        child: progress
            ? Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                color: colorAssets.BLACK,
                child: CircularProgressIndicator(
                  color: colorAssets.ORANGE, //<-- SEE HERE
                  backgroundColor: colorAssets.BLACK,
                ),
              )
            : Stack(children: [
                Container(
                    padding: EdgeInsets.only(
                        bottom: 30.0, left: 40.0, right: 40.0, top: 10.0),
                    color: Colors.black,
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                  width: 200,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: Colors.white, width: 8),
                                  ),
                                  child: Consumer<add_video_provider>(
                                      builder: (ctx, provider, child) =>
                                          provider.getimage_bytes != null
                                              ? Image.memory(
                                                  provider.getimage_bytes,
                                                  height: 200,
                                                )
                                              : Container(
                                                  color: Colors.black,
                                                ))),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.white),
                                  const Text('Location',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "poppins",
                                          fontSize: 14.0,
                                          fontWeight: fontwightAssets.Bold)),
                                  Consumer<add_video_provider>(
                                      builder: (ctx, location, child) => Text(
                                          location.convert_cord_to_location(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "poppins",
                                              fontSize: 14.0,
                                              fontWeight:
                                                  fontwightAssets.Bold))),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  // const Text('EDIT',
                                  //     style: TextStyle(
                                  //         color: Colors.orange,
                                  //         fontFamily: "poppins",
                                  //         fontSize: 14.0,
                                  //         fontWeight: fontwightAssets.Bold)),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Category",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "poppins",
                                            fontSize: 14.0,
                                            fontWeight: fontwightAssets.Bold),
                                      ),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: DropdownButton<String>(
                                          dropdownColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          icon: const Icon(Icons.expand_more,
                                              color: colorAssets.ORANGE),
                                          value: dropdownCategory,
                                          items: dropdownvalueCategoryItems
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,
                                                  style: const TextStyle(
                                                      color:
                                                          colorAssets.ORANGE)),
                                            );
                                          }).toList(),
                                          onChanged: (selectedItem) {
                                            setState(() {
                                              dropdownCategory = selectedItem!;
                                              print(dropdownCategory);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Genre",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "poppins",
                                              fontSize: 14.0,
                                              fontWeight:
                                                  fontwightAssets.Bold)),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: DropdownButton<String>(
                                          dropdownColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          icon: const Icon(Icons.expand_more,
                                              color: colorAssets.ORANGE),
                                          value: dropdownGenre,
                                          items: dropdownvalueGenreItems
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,
                                                  style: const TextStyle(
                                                      color:
                                                          colorAssets.ORANGE)),
                                            );
                                          }).toList(),
                                          onChanged: (selectedItem) {
                                            setState(() {
                                              dropdownGenre = selectedItem!;
                                              print(dropdownGenre);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            // --------------------------------------------------------------------------------------------
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0,
                                  MediaQuery.of(context).viewInsets.bottom),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Describe your experience',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "poppins",
                                          fontSize: 14.0,
                                          fontWeight: fontwightAssets.Bold)),
                                  TextFormField(
                                    focusNode: Node1Describe,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: 'Type Here...',
                                      hintStyle:
                                          const TextStyle(color: Colors.white),
                                      errorText: Describe_experience.isEmpty
                                          ? "please fill"
                                          : null,
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.orange),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.orange)),
                                      labelStyle: const TextStyle(
                                          color: colorAssets.WHITE),
                                      // labelText: 'Description'
                                    ),
                                    // maxLines: 3,on
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      setState(() {
                                        Describe_experience = value;
                                      });
                                    },

                                    onFieldSubmitted: (value) {
                                      Node1Describe.unfocus();
                                    },
                                    // focusNode: _descriptionFocusNode,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a description.';
                                      }
                                      if (value.length < 10) {
                                        return 'Should be at least 10 characters long.';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // --------------------------------------------------------------------------------------------
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('What you Love here ?',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "poppins",
                                          fontSize: 14.0,
                                          fontWeight: fontwightAssets.Bold)),
                                  Wrap(
                                    children: [
                                      Wrap(
                                        children: _build_pros_ChoiceList(),
                                      ),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    pros_flag
                                                        ? colorAssets.ORANGE
                                                        : Colors.black),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    side: BorderSide(
                                                        color: Colors.red))),
                                            side: MaterialStateProperty.all(
                                              BorderSide.lerp(
                                                  const BorderSide(
                                                    style: BorderStyle.solid,
                                                    color: colorAssets.ORANGE,
                                                    width: 2.0,
                                                  ),
                                                  const BorderSide(
                                                    style: BorderStyle.solid,
                                                    color: colorAssets.ORANGE,
                                                    width: 2.0,
                                                  ),
                                                  10.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              pros_flag = !pros_flag;
                                              Node2pros.requestFocus();
                                            });
                                          },
                                          child: const Text(" + others"))
                                    ],
                                  ),
                                  Container(
                                      child: !pros_flag
                                          ? const Center(
                                              child: Text(
                                                  "click button to know more"))
                                          : TagEditor(
                                              onSubmitted: (value) {
                                                Node2pros.unfocus();
                                              },
                                              focusNode: Node2pros,
                                              textStyle: TextStyle(
                                                  color: Colors.white),
                                              length: Pros_values.length,
                                              delimiters: const [','],
                                              hasAddButton: true,
                                              inputDecoration:
                                                  const InputDecoration(
                                                hintText: "Type Here...",
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Color(0xffFB8C00)),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Color(0xffFB8C00)),
                                                ),
                                              ),
                                              onTagChanged: (Value) {
                                                setState(() {
                                                  Pros_values.add(Value);
                                                });
                                              },
                                              tagBuilder: (context, index) =>
                                                  _Chip(
                                                index: index,
                                                label: Pros_values[index],
                                                onDeleted: onDelete1,
                                              ),
                                            ))
                                ],
                              ),
                            ),

                            // --------------------------------------------------------------------------------------------
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      'What you don’t like about this place?  ?',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "poppins",
                                          fontSize: 14.0,
                                          fontWeight: fontwightAssets.Bold)),
                                  Wrap(
                                    children: [
                                      Wrap(
                                        children: _build_cons_ChoiceList(),
                                      ),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    cons_flag
                                                        ? colorAssets.ORANGE
                                                        : Colors.black),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    side: BorderSide(
                                                        color: Colors.red))),
                                            side: MaterialStateProperty.all(
                                              BorderSide.lerp(
                                                  const BorderSide(
                                                    style: BorderStyle.solid,
                                                    color: colorAssets.ORANGE,
                                                    width: 2.0,
                                                  ),
                                                  const BorderSide(
                                                    style: BorderStyle.solid,
                                                    color: colorAssets.ORANGE,
                                                    width: 2.0,
                                                  ),
                                                  10.0),
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              Node3cons.requestFocus();
                                              cons_flag = !cons_flag;
                                            });
                                          },
                                          child: Text(" + others"))
                                    ],
                                  ),
                                  Container(
                                      child: !cons_flag
                                          ? Center(
                                              child: Text(
                                                  "click button to know more"))
                                          : TagEditor(
                                              onSubmitted: (value) {
                                                Node3cons.unfocus();
                                                FocusScope.of(context)
                                                    .requestFocus(Node4review);
                                              },
                                              focusNode: Node3cons,
                                              textStyle: TextStyle(
                                                  color: Colors.white),
                                              length: cons_values.length,
                                              delimiters: [','],
                                              hasAddButton: true,
                                              inputDecoration:
                                                  const InputDecoration(
                                                hintText: "Type Here...",
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Color(0xffFB8C00)),
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 3,
                                                      color: Color(0xffFB8C00)),
                                                ),
                                              ),
                                              onTagChanged: (Value) {
                                                setState(() {
                                                  cons_values.add(Value);
                                                });
                                              },
                                              tagBuilder: (context, index) =>
                                                  _Chip(
                                                index: index,
                                                label: cons_values[index],
                                                onDeleted: onDelete2,
                                              ),
                                            ))
                                ],
                              ),
                            ),

                            // --------------------------------------------------------------------------------------------
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Review this place ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "poppins",
                                              fontSize: 14.0,
                                              fontWeight:
                                                  fontwightAssets.Bold)),
                                      TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          hintText: 'Type Here...',
                                          hintStyle: const TextStyle(
                                              color: Colors.white),
                                          errorText: Review_place.isEmpty
                                              ? "please fill"
                                              : null,
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.orange),
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.orange)),
                                          labelStyle: const TextStyle(
                                              color: colorAssets.WHITE),
                                          // labelText: 'Description'
                                        ),
                                        // maxLines: 3,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onChanged: (value) {
                                          setState(() {
                                            Review_place = value!;
                                          });
                                        },

                                        // focusNode: _descriptionFocusNode,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a description.';
                                          }
                                          if (value.length < 10) {
                                            return 'Should be at least 10 characters long.';
                                          }
                                          return null;
                                        },
                                      ),
                                    ])),

                            // --------------------------------------------------------------------------------------------
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Rate your Expereince here ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "poppins",
                                              fontSize: 14.0,
                                              fontWeight:
                                                  fontwightAssets.Bold)),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      FivePointedStar(
                                        gap: 4,
                                        size: const Size(35, 35),
                                        count: 5,
                                        color: Color.fromARGB(255, 83, 83, 83),
                                        selectedColor:
                                            Color.fromARGB(255, 255, 255, 255),
                                        onChange: (count) {
                                          setState(() {
                                            star_count = count;
                                          });
                                        },
                                      ),
                                    ])),

                            // ----------------------------------------------------------------------------------------------

                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Make This Video',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "poppins",
                                              fontSize: 14.0,
                                              fontWeight:
                                                  fontwightAssets.Bold)),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      Container(
                                        // height: 50,
                                        // color: Colors.white,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),

                                        padding:
                                            EdgeInsets.fromLTRB(30, 5, 30, 5),
                                        child: DropdownButton<String>(
                                          dropdownColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          icon: const Icon(Icons.expand_more,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                          value: dropdownValueAvailabilty,
                                          items: dropdownValueAvailabiltyitems
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0))),
                                            );
                                          }).toList(),
                                          onChanged: (selectedItem) {
                                            setState(() {
                                              dropdownValueAvailabilty =
                                                  selectedItem!;
                                              print(dropdownValueAvailabilty);
                                            });
                                          },
                                        ),
                                      ),
                                    ])),

                            // Consumer<FormProvider>(builder: (context, model, child) {
                            //   return ElevatedButton(
                            //     onPressed: () {
                            //       if (model.validate) {
                            //         Navigator.of(context).push(
                            //           MaterialPageRoute(
                            //             builder: (_) => success_page(),
                            //           ),
                            //         );
                            //       }
                            //     },
                            //     child: const Text('Submit'),
                            //   );
                            // })

                            Container(
                                color: Color.fromARGB(255, 0, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    OutlinedButton(
                                      child: Text("SAVE DRAFT"),
                                      style: OutlinedButton.styleFrom(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        primary: colorAssets.ORANGE,
                                        side: BorderSide(
                                          color: colorAssets.ORANGE,
                                        ),
                                      ),
                                      onPressed: () {
                                        _add_video_provider.setValue(
                                          Describe_experience:
                                              Describe_experience,
                                          genre: dropdownGenre,
                                          Review_place: Review_place,
                                          availability_shared:
                                              dropdownValueAvailabilty,
                                          category: dropdownCategory,
                                          rate_experience: star_count,
                                          cons: [
                                            ...cons_values,
                                            ..._build_cons_ChoiceList_list
                                          ],
                                          pros: [
                                            ...Pros_values,
                                            ..._build_pros_ChoiceList_list
                                          ],
                                          draft: true,
                                        );

                                        _add_video_provider
                                            .save_draft_operation(context) .then((value) {
                                          value ? draft_show_dialog() : null;
                                          return;
                                        });;
                                        // print(
                                        //     "${add_video_consumer.getthumbnail}");

                                        // draftprovider
                                        //     .adddraftData(
                                        //   Category: dropdownCategory!,
                                        //   Genre: dropdownGenre!,
                                        //   Describe_experience:
                                        //       Describe_experience,
                                        //   pros: [
                                        //     ...Pros_values,
                                        //     ..._build_pros_ChoiceList_list
                                        //   ],
                                        //   cons: [
                                        //     ...cons_values,
                                        //     ..._build_cons_ChoiceList_list
                                        //   ],
                                        //   rate_experience: star_count,
                                        //   Review_place: Review_place,
                                        //   availability_shared:
                                        //       dropdownValueAvailabilty!,
                                        //   // bytes: add_video_consumer.getimage_bytes,
                                        //   // thumbnailnew:add_video_consumer.getthumbnail,
                                        //   start_lat: add_video_consumer
                                        //       .get_startPosition!.latitude!,
                                        //   start_long: add_video_consumer
                                        //       .get_startPosition!.longitude!,
                                        //   // cordin_to_address: add_video_consumer
                                        //   // .get_cordin_to_address
                                        // )
                                        //     .then((value) {
                                        //   value ? draft_show_dialog() : null;
                                        //   return;
                                        // });
                                      },
                                    ),
                                    ElevatedButton(
                                      child: Text("  SUBMIT  "),
                                      style: ElevatedButton.styleFrom(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        primary: colorAssets.ORANGE,
                                        elevation: 0,
                                      ),
                                      onPressed: () async {
                                        // draft _draft_provider =
                                        //     Provider.of<draft>(context,
                                        //         listen: false);
                                        // _draft_provider.loaddraftData();


                                         if (_add_video_provider != null) {
                                setState(() {
                                  progress = true;
                                });

                                await _add_video_provider.setValue(
                                  category: dropdownCategory,
                                  genre: dropdownGenre,
                                  Describe_experience: Describe_experience,
                                  pros: [
                                    ...Pros_values,
                                    ..._build_pros_ChoiceList_list
                                  ],
                                  cons: [
                                    ...cons_values,
                                    ..._build_cons_ChoiceList_list
                                  ],
                                  Review_place: Review_place,
                                  rate_experience: star_count,
                                  availability_shared:
                                      dropdownValueAvailabilty!,
                                  draft: false,
                                );

                                _add_video_provider
                                    .upload_video()
                                    .then((value) {
                                  publish_show_dialog();
                                });
                              }
                              // --------------------------
                                      },
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    )),
                //   Positioned(
                //     bottom: 0,
                //     left: 0,
                //     right: 0,
                //     child: Container(
                //         color: Color.fromARGB(255, 0, 0, 0),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             GestureDetector(
                //               onTap: () {
                //                 print(
                //                     "{_add_video_provider.getthumbnail}************************");
                //               },
                //               child: Container(
                //                   padding: EdgeInsets.all(10),
                //                   decoration: BoxDecoration(
                //                       border: Border.all(color: Colors.orange),
                //                       color: Colors.black,
                //                       borderRadius:
                //                           BorderRadius.all(Radius.circular(5))),
                //                   child: const Text(
                //                     "SAVE DRAFT",
                //                     style: TextStyle(
                //                       fontSize: 20,
                //                       color: Colors.orange,
                //                       fontWeight: FontWeight.w800,
                //                     ),
                //                   )),
                //             ),
                //             GestureDetector(
                //               onTap: () async {
                //                 print("=========================");
                //                 // draft draft_model = draft();
                //                 // draft_model.clear_all();
                //                 // if (_add_video_provider != null) {
                //                 //   setState(() {
                //                 //     progress = true;
                //                 //   });

                //                 //   await _add_video_provider.setValue(
                //                 //     category: dropdownCategory!,
                //                 //     genre: dropdownGenre!,
                //                 //     Describe_experience: Describe_experience,
                //                 //     pros: [
                //                 //       ...Pros_values,
                //                 //       ..._build_pros_ChoiceList_list
                //                 //     ],
                //                 //     cons: [
                //                 //       ...cons_values,
                //                 //       ..._build_cons_ChoiceList_list
                //                 //     ],
                //                 //     Review_place: Review_place,
                //                 //     rate_experience: star_count,
                //                 //     availability_shared:
                //                 //         dropdownValueAvailabilty!,
                //                 //     draft: false,
                //                 //   );

                //                 //   _add_video_provider
                //                 //       .upload_video()
                //                 //       .then((value) {
                //                 //     publish_show_dialog();
                //                 //   });
                //                 // }
                //                 // -----------------------------------------------
                //               },
                //               child: Container(
                //                   padding:
                //                       const EdgeInsets.fromLTRB(20, 10, 20, 10),
                //                   decoration: BoxDecoration(
                //                       border: Border.all(color: Colors.orange),
                //                       color: Colors.orange,
                //                       borderRadius: const BorderRadius.all(
                //                           Radius.circular(5))),
                //                   child: const Text(
                //                     "PUBLISH",
                //                     style: TextStyle(
                //                       fontSize: 20,
                //                       color: Colors.white,
                //                       fontWeight: FontWeight.w800,
                //                     ),
                //                   )),
                //             ),
                //           ],
                //         )),
                //   ),
              ]),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Color(0xffFB8C00),
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      labelStyle: const TextStyle(color: Colors.white),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}

//