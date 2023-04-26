import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ihomifi/room.dart';


  Future createRoom({required String roomname,required List<String> roomappliances}) async{
      final docRoom=FirebaseFirestore.instance.collection('rooms').doc();
      final room =Room(id: docRoom.id, roomname: roomname, appliances: roomappliances);
      final result=room.toJson();
      await docRoom.set(result);
  }