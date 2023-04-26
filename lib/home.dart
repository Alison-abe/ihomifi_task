import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ihomifi/add_room.dart';
import 'package:ihomifi/imagecard.dart';
import 'package:ihomifi/update_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference users = firestore.collection('rooms');
class _HomepageState extends State<Homepage> {
  int curr_room = 0;
  List<String> current_appliances = [];
  List<Color> buttonColor = [const Color.fromARGB(255, 40, 98, 190)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 176, 210, 237),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Devices',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 45, 69, 89)),
                      )),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => const New_Room())));
                    },
                    icon: const Icon(Icons.add),
                    iconSize: 30,
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream: users.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  for (int i = 1; i < documents.length; i++) {
                    buttonColor.add(const Color.fromARGB(255, 45, 69, 89));    
                  }
                  return Column(children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,  
                        itemCount: documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return 
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                height: 50,
                                width: documents[index].get('roomname').length*15.0,
                                child: ElevatedButton(
                                    onLongPress: () {
                                      setState(() {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) => Update(
                                                    room_id: documents[index]
                                                        .get('id'))));
                                      });
                                    },
                                    onPressed: () {
                                      setState(() {
                                        curr_room = index;
                                        for (int i = 0;
                                            i < documents.length;
                                            i++) {
                                          if (i == curr_room) {
                                            buttonColor[i] =
                                                const Color.fromARGB(255, 40, 98, 190);
                                          } else {
                                            buttonColor[i] = const Color.fromARGB(255, 45, 69, 89);
                                          }
                                        }
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              buttonColor[index]),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                        '${documents[index].get('roomname')}')),
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                          documents[curr_room].get('appliances').length,
                          (index) {
                        return ImageCard(documents: documents, currroom: curr_room, index: index);
                      }),
                    )
                  ]);
                },
              ),
            ]),
          ),
        ));
  }
}
