


import 'package:flutter/material.dart';

Widget loadingIndicator(){
  return  const SizedBox(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.red),
    ),
  );
}

