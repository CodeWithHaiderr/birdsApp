

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';



Widget featuredAds({String? title, img}) {
  return Row(
    children: [
      Image.asset(img,width: 50, height: 50, fit: BoxFit.cover,),
      const SizedBox(width: 10,),
      title!.text.fontWeight(FontWeight.bold).color(Colors.black).make(),

    ],
  ).box.width(250).height(80).margin(const EdgeInsets.symmetric(horizontal: 4)).color(Colors.white).padding(const EdgeInsets.all(10)).roundedSM.outerShadowSm.make();
  
}



// return Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(20),
// ),
// child: Row(
// children: [
// Image.asset("assets/images/cockatiel.jpg",width: 60, fit: BoxFit.cover,),
// SizedBox(height: 10,),
// Text("Birds.Pk",style: TextStyle(fontWeight: FontWeight.w600),),
// ],
// ),
// );