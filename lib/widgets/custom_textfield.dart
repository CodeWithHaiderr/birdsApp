import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customTextField({String? hint,controller,isPass}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 25,),
      Padding(
        padding: const EdgeInsets.only(right: 15,left: 15,),
        child: TextFormField(
          obscureText: isPass,
          controller: controller,
          decoration: InputDecoration(


            fillColor: Colors.grey.shade200,
            hintText: hint,
            isDense: true,
            filled: true,
            border: InputBorder.none,
            // focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF4E343E)) , borderRadius: BorderRadius.circular(20)),
          ),
        ).box.roundedSM.clip(Clip.antiAlias).height(35).shadowSm.make(),
      ),
    ],
  );
}