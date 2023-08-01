import 'package:beacon/view/widgets/appbar_widget.dart';
import 'package:beacon/view/widgets/pathfinder_widget.dart';
import 'package:flutter/material.dart';
import 'package:beacon/view/shared/global.dart';

class FloorPlanScreen extends StatelessWidget {
  const FloorPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBarWidget(
          title: 'Floor Plan',
        ),
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          color: Global.red,
          child: Row(children: const [
            PathfinderView(),
          ]),
        ),
      ),
    );
  }
}
