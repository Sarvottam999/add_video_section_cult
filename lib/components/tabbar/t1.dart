import 'package:flutter/material.dart';

class mtTabbar extends StatelessWidget {
  const mtTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tabs Demo'),
        ),
        body: TabBarView(physics:ScrollPhysics(parent: NeverScrollableScrollPhysics()) ,
          children: [
            Icon(Icons.flight, size: 350),
            Icon(Icons.directions_transit, size: 350),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
