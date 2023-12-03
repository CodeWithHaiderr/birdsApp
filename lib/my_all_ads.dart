


import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import 'consts/lists.dart';
import 'my_ad_details.dart';
class MyAllAds extends StatelessWidget {
  const MyAllAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text("My Ads",style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.bold,fontSize: 17),),
        actions: [
          Center(child: Text(intl.DateFormat.yMd().add_jm().format(DateTime.now()),style: TextStyle(color: Colors.purple.shade800,fontWeight: FontWeight.bold),)),
          const SizedBox(width: 15,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
                20, (index) => ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAdDetails()));
              },
              leading: Image.asset(cockatiel,width: 100,height: 100,fit: BoxFit.cover,),
              title: Text("Ad Title",style: TextStyle(color: Colors.grey.shade900),),
              subtitle: Text("Rs 0000",style: TextStyle(color: Colors.grey.shade900),),
              trailing: const Icon(Icons.chevron_right),
            )),
          ),
        ),
      ),
    );
  }
}
