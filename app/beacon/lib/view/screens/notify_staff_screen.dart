import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

import 'package:beacon/view/shared/global.dart';
import 'package:beacon/view/widgets/appbar_widget.dart';

class NotifyStaff extends StatefulWidget {
  const NotifyStaff({super.key});

  @override
  State<NotifyStaff> createState() => _NotifyStaffState();
}

class _NotifyStaffState extends State<NotifyStaff> {
  _NotifyStaffState() {
    valRecep = recepientList[0];
    valLocal = localList[0];
  }
  late TextEditingController _controller;
  String sender = '';

  String? valRecep;
  String? valLocal;
  var recepientList = ["Ahmed Asyeeq", "Gary Payton", "Andrew Wiggins"];
  var localList = ["Front Desk", "Room 1", "Room 2", "Room 3"];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    sender = '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBarWidget(title: 'Notify Staff'),
      ),
      body: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: Center(
            child: Container(
              width: double.infinity,
              color: Global.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    'Recipient',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton(
                    value: valRecep,
                    items: recepientList
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        valRecep = val as String;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton(
                    value: valLocal,
                    items: localList
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        valLocal = val as String;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Sender (Your Name)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300.0,
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white54,
                          ),
                        ),
                        labelText: 'Sender',
                        labelStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      onSubmitted: (String value) {
                        setState(() {
                          sender = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(250, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      sendEmail();
                    },
                    child: const Text(
                      "Send",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Global.red,
                      ),
                    ),
                  ),
                  const SizedBox(height: 300),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future sendEmail() async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    const String serviceId = 'service_wi97w3p';
    const String templateId = 'template_o2tuujr';
    const String userId = 'gFX3VUemHcI30rTP5';

    String subject = "Visitor Waiting";
    String message = "$sender is waiting at $valLocal";
    String email = "";

    if (valRecep == "Ahmed Asyeeq") {
      email = "b05190003@student.unimy.edu.my";
    }

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        },
      }),
    );
    if (response.body == 'OK') {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Notified Staff',
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        text: response.body,
      );
    }
  }
}
