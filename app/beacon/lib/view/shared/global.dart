import 'package:flutter/material.dart';

abstract class Global {
  static const Color red = Color(0xffB74F6F);

  static const List beacons = [
    {
      // front desk
      'name': 'A',
      'identifier': '6872f642dfd00b137424a6173acd5e18',
      'UID': 'b9407f30-f5f8-466e-aff9-25556b57fe6d',
      'floor': 'Lobby',
      'position': [40.0, 180.0],
    },
    {
      // to lift or room
      'name': 'B',
      'identifier': '1599f9a4e04485eae967c17c6b940510',
      'UID': 'b9407f30-f5f8-466e-aff9-25556b57fe7d',
      'floor': 'Lobby',
      'position': [190.0, 180.0],
    },
    {
      // lift
      'name': 'C',
      'identifier': 'bbc29d4941db290a7982aa3e232ee521',
      'UID': 'b9407f30-f5f8-466e-aff9-25556b57fe8d',
      'floor': 'Lobby',
      'position': [190.0, 250.0],
    },
    {
      // room 1
      'name': 'D',
      'identifier': '89bd4908100269524eb20908b5d75f29',
      'UID': 'b9407f30-f5f8-466e-aff9-25556b57fe9d',
      'floor': 'Lobby',
      'position': [190.0, 160.0],
    },
    {
      // room 2
      'name': 'E',
      'identifier': '62c91f680ef857a769982e6a4091033b',
      'UID': '22bf1ed8-81b4-40ce-ab3f-e30325040059',
      'floor': 'Lobby',
      'position': [190.0, 90.0],
    },
    {
      // room 3
      'name': 'F',
      'identifier': '19dd2b01a889f1b059fe1829d573db03',
      'UID': '7a4167df-3b92-461b-bdaf-386fd6363727',
      'floor': 'Lobby',
      'position': [190.0, 30.0],
    },
  ];
}
