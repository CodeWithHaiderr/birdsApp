


import 'package:flutter/material.dart';

Widget postAdTextField({label,hint,controller,isDesc = false}){
  return TextFormField(
    maxLines: isDesc ? 4 : 1,
    controller: controller,
    decoration: InputDecoration(
      isDense: true,
      label: Text(label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.white,
        )),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.white,
        )),
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade800)
    ),
  );
}