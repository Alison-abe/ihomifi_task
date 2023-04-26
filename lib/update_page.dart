import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ihomifi/Dialog.dart';
import 'package:ihomifi/home.dart';

class Update extends StatefulWidget {
  final String room_id;
  Update({Key? key, required this.room_id}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

List roomresult = [];
final changeController = TextEditingController();
final addController = TextEditingController();

class _UpdateState extends State<Update> {
  late DocumentSnapshot document;

  Stream<DocumentSnapshot> getDocument() {
    return FirebaseFirestore.instance
        .collection('rooms')
        .doc(widget.room_id)
        .snapshots();
  }

 void editappliance(AsyncSnapshot<DocumentSnapshot> snapshot, int index,BuildContext context) {
    Navigator.of(context).pop();
    roomresult.clear();
    roomresult = snapshot.data!.get('appliances');

    roomresult[index] = changeController.text;
    final docUser =
        FirebaseFirestore.instance.collection('rooms').doc(widget.room_id);
    docUser.update({'appliances': roomresult});
    changeController.clear();
  }

 void addappliance(AsyncSnapshot<DocumentSnapshot> snapshot,BuildContext context) {
    Navigator.of(context).pop();
    roomresult.clear();
    roomresult = snapshot.data!.get('appliances');

    roomresult.add(addController.text);
    final docUser =
        FirebaseFirestore.instance.collection('rooms').doc(widget.room_id);
    docUser.update({'appliances': roomresult});
    addController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: getDocument(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 45, 69, 89),
              title: Text(snapshot.data!.get('roomname')),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: ((context) => const Homepage())));
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => const Homepage())));
                      Future.delayed(const Duration(seconds: 1), () {
                        final docUser = FirebaseFirestore.instance
                            .collection('rooms')
                            .doc(widget.room_id);
                        docUser.delete();
                      });
                    },
                    icon: const Icon(Icons.delete)),
                const SizedBox(
                  width: 23,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Appliances',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 45, 69, 89),
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 40),
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight:
                              snapshot.data!.get('appliances').length * 200.0,
                          maxWidth: MediaQuery.of(context).size.width),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.get('appliances').length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(
                                  '${snapshot.data!.get('appliances')[index]}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return 
                                            dialog(text: 'EnterChange', onpressed: (() {
                                              editappliance(snapshot, index, context);
                                            }), controller: changeController);
                                            
                                          });
                                    },
                                  ),
                                  IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        roomresult.clear();
                                        roomresult =
                                            snapshot.data!.get('appliances');
                                        roomresult.remove(snapshot.data!
                                            .get('appliances')[index]);
                                        final docUser = FirebaseFirestore
                                            .instance
                                            .collection('rooms')
                                            .doc(widget.room_id);
                                        docUser
                                            .update({'appliances': roomresult});
                                      })
                                ],
                              ),
                            );
                          }))
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 45, 69, 89),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return 
                      dialog(text: 'Enter new Appliances', onpressed: (){
                        addappliance(snapshot, context);
                      }, controller: addController);
                    });
              },
              child: const Icon(Icons.add),
            ),
          );
        } else {
          return const SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                value: 0,
              ));
        }
      },
    );
  }
}
