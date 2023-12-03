

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget adProductImages({required label, onPress}) {
  return Text(label,style: TextStyle(
    color: Colors.grey.shade800,
    fontSize: 16,
  ),).box.green200.shadowSm.size(100, 100).make();
}