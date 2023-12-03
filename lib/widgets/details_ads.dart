

import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

Widget DetailsAd({width, String? count,String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.color(Vx.black).bold.size(16).make(),
      10.heightBox,
      title!.text.color(Vx.black).make(),
    ],
  ).box.green200.rounded.shadow3xl.width(width).height(80).padding(const EdgeInsets.all(4)).make();
}