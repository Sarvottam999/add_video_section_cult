 // import 'package:tryapp3/provider/video_provider.dart';
// import 'package:tryapp3/components/add_video_camera/s_4_product_tems.dart';
import 'package:add_video/components/add_Video/s_4_product_tems.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:add_video/components/add_Video/add_video_provider.dart';
// import 'package:tryapp/model/video_model.dart';
// import 'package:tryapp/preview_video/product_tems.dart';

class s_3_video_grid_screen_screen extends StatelessWidget {
  static const namedRoute = "/s_3_video_grid_screen_screen";
  
  final bool showFavs = true;
  // List list;
  // s_3_video_grid_screen({});
// -------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    List loader_video = Provider.of<add_video_provider>(context).getItems;

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(10.0,110.0,10.0,10.0),
      itemCount: loader_video.length,
      itemBuilder: (ctx, i) => s_4_videoItem(
        clip: loader_video[i],
        index: i,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2/3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
