import 'package:flutter/material.dart';
import 'package:beacon/view/shared/global.dart';
import 'package:beacon/view/widgets/image_loader.dart';

class PathfinderView extends StatelessWidget {
  const PathfinderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Global.red,
      ),
      child: const ImageLoader(),
    );
  }
}
