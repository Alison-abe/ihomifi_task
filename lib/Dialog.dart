import 'package:flutter/material.dart';
import 'package:ihomifi/textfield.dart';
class dialog extends StatefulWidget {
  final String text;
  final VoidCallback onpressed;
  final TextEditingController controller;
  const dialog({Key? key,required this.text,required this.onpressed,required this.controller}) : super(key: key);

  @override
  State<dialog> createState() => _dialogState();
}

class _dialogState extends State<dialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child:Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width * 3 / 4,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                               Text(
                                widget.text,
                                style:const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 3 / 4,
                                child: TextField(
                                    controller: widget.controller,
                                    decoration: TextfieldDecoration().textdecoration(''))
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: widget.onpressed,
                                  child: const Text('OK'))
                            ],
                          ),
                        ),
    );
  }
}