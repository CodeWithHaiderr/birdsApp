

import 'package:birdz_app/controller/post_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productCtgDropdown({hint, required List<String> list, dropvalue, required PostProductController controller}){
 return Obx(
   () => DropdownButtonHideUnderline(
     child: DropdownButton(
       hint: Text("$hint",style: TextStyle(color: Colors.grey.shade800),),
       value: dropvalue.value == '' ? null : dropvalue.value,
         isExpanded: true,
         items: list.map((e) {
           return DropdownMenuItem(
             value: e,
             child: e.toString().text.make(),
           );
         }).toList(),
         onChanged: (newValue) {
         if(hint == "Category"){
           controller.subcategoryValue.value = '';
           controller.populateSubcategory(newValue.toString());
         }
         dropvalue.value = newValue.toString();
         }
     ),
   ).box.gray200.padding(const EdgeInsets.symmetric(horizontal: 4)).shadowSm.roundedSM.make(),
 );
}