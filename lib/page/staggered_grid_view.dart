import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredGridViewRoute extends StatefulWidget {
  @override
  StaggeredGridViewRouteState createState() {
    return new StaggeredGridViewRouteState();
  }
}

class StaggeredGridViewRouteState extends State<StaggeredGridViewRoute> {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.blue,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('$index'),
            ),
          ),
        );
      },
      staggeredTileBuilder: (int index) {
        return StaggeredTile.count(2, index.isEven ? 2 : 1);
      },
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
    );
  }
}
