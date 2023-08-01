import 'package:flutter/material.dart';
import 'package:beacon/view/shared/global.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: Size.zero,
        child: Row(
          children: [
            const SizedBox(
              width: 20.0,
            ),
            Column(
              children: [
                GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Global.red,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            const SizedBox(
              width: 50,
            ),
            Column(
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Global.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
