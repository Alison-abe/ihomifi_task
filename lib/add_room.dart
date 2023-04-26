import 'package:flutter/material.dart';
import 'package:ihomifi/functions.dart';
import 'package:ihomifi/home.dart';
import 'package:ihomifi/textfield.dart';

class New_Room extends StatefulWidget {
  const New_Room({Key? key}) : super(key: key);

  @override
  State<New_Room> createState() => _New_RoomState();
}

final roomname_controller = TextEditingController();
final appliances_controller = TextEditingController();
final focusnode = FocusNode();
List<TextEditingController> Controllers=[];
int no_of_appliances = 0;
List<String> room_appliances=[];
class _New_RoomState extends State<New_Room> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    no_of_appliances = 0;
    roomname_controller.clear();
    appliances_controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
                icon:const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: ((context) => const Homepage())));
                },
              ),
        title:const Text(
          "Add New Room",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 45, 69, 89),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 3 / 4,
                child: FocusScope(
                  child: TextField(
                    controller: roomname_controller,
                    decoration: 
                    TextfieldDecoration().textdecoration('Room Name')
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 3 / 4,
                child: FocusScope(
                  child: TextField(
                    focusNode: focusnode,
                    controller: appliances_controller,
                    decoration:  
                    TextfieldDecoration().textdecoration('Number of Appliances'),
                    onEditingComplete: () {
                      setState(() {
                        no_of_appliances = int.parse(appliances_controller.text);
                         Controllers.clear();
                         Controllers = List.generate(no_of_appliances, (_) => TextEditingController());
                      });
                      focusnode.unfocus();
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
             ConstrainedBox(
                constraints: BoxConstraints(maxHeight: no_of_appliances*250),
                child: ListView.builder(
                   shrinkWrap: true,
                   physics:const NeverScrollableScrollPhysics(),
                    itemCount: no_of_appliances,
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 3 / 4,
                          child: Column(
                            children: [TextField(
                              controller:Controllers[index],
                              decoration: 
                              TextfieldDecoration().textdecoration('Appliance ${index+1}')
                            ),
                            const SizedBox(height: 40,)
                      ]),
                        ),
                      );
                    }),
              ),
            
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () async{
                  for(int i=0;i<no_of_appliances;i++){
                    room_appliances.add(Controllers[i].text);
                  }
                await createRoom(roomname: roomname_controller.text,roomappliances: room_appliances);
                roomname_controller.clear();
                appliances_controller.clear();
                for(int i=0;i<no_of_appliances;i++){
                  Controllers[i].clear();
                }
                room_appliances.clear();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: ((context) => const Homepage())));
                },
                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(const Color.fromARGB(255, 45, 69, 89)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),

                child: const Text(
                  'Create',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      )),
    );
  }
}
