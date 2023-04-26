
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  final int currroom,index;
const ImageCard({Key? key,required this.documents,required this.currroom,required this.index}) : super(key: key);

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 150,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 45, 69, 89).withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/bulb.png'))),
              ),
              const SizedBox(
                height: 15
              ),
              Text(
                '${widget.documents[widget.currroom].get('appliances')[widget.index]}',
                style: const TextStyle(fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
