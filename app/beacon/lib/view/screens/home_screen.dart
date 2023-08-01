import 'package:beacon/view/screens/floorplan_screen.dart';
import 'package:beacon/view/screens/notify_staff_screen.dart';
import 'package:flutter/material.dart';
import 'package:beacon/view/widgets/appbar_widget.dart';
import 'package:beacon/view/shared/global.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBarWidget(
          title: 'Smart Receptionist System',
        ),
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
            width: double.infinity,
            color: Global.red,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset('images/receptionist.png'),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "What would you like to do?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(250, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FloorPlanScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Navigate",
                    style: TextStyle(color: Global.red),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(250, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotifyStaff(),
                      ),
                    );
                  },
                  child: const Text(
                    "Meet",
                    style: TextStyle(color: Global.red),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
