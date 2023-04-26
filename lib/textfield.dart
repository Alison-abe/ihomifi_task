import 'package:flutter/material.dart';

class TextfieldDecoration{
  InputDecoration textdecoration(String? text){
      return  InputDecoration(
                      label: text==null? const Text('') :
                      Text(text,style:const TextStyle(color: Color.fromARGB(255, 45, 69, 89))),
                      enabledBorder:const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Color.fromARGB(255, 45, 69, 89)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder:const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Color.fromARGB(255, 45, 69, 89)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    );
  }
}