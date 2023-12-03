

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget myAdsButton(context, {title,count,icon}){
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(title,style: TextStyle(fontSize: 12,color: Colors.grey.shade900,fontWeight: FontWeight.bold),),
              Text(count,style: TextStyle(fontSize: 20,color: Colors.grey.shade900,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
      Icon(icon,size: 45,),
    ],
  ).box.color(Colors.grey.shade300).shadow2xl.rounded.size(size.width * 0.4, 76).padding(const EdgeInsets.all(8)).make();
}