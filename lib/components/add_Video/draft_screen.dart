// import 'package:add_video/components/add_Video/draft.dart';
// import 'package:add_video/components/add_Video/model/add_video_data_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:provider/provider.dart';

// class draft_screen extends StatefulWidget {
//   const draft_screen({super.key});

//   @override
//   State<draft_screen> createState() => _draft_screenState();
// }

// class _draft_screenState extends State<draft_screen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _add_video_provider = Provider.of<draft>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("draft list"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         tooltip: 'Capture Image',
//         child: Icon(Icons.camera_alt),
//       ),
//       body: Container(
//         child: FutureBuilder<List<add_video_data_model>>(
//           future: _add_video_provider.loaddraftData(),
//           builder: (BuildContext context,
//               AsyncSnapshot<List<add_video_data_model>> snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     // leading: Image.memory(
//                     //   snapshot.data![index].bytes, fit: BoxFit.cover,
//                     //   // height: 200,
//                     // ),
//                     // title: Text(snapshot.data![index].thumbnail as String),
//                     // subtitle: Text(snapshot.data![index].start_lat as String  ),
//                   );
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
