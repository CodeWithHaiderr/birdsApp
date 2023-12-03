


import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MedicationHomeScreen extends StatelessWidget {
  final String? title;
  final dynamic data;
  const MedicationHomeScreen({Key? key,required this.title,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade400,
        title: Text('$title', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VxSwiper.builder(
                            itemCount: data['Imgs'].length,
                            // autoPlay: true,
                            height:200,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.9,
                            itemBuilder: (context,index) {
                              return Image.network(
                                data["Imgs"],
                                width: double.infinity,
                                fit: BoxFit.fitHeight,
                              );
                            }),
                        const SizedBox(height: 20,),
                        Text(title!,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 23),),
                        const SizedBox(height: 10,),
                        Text("${data['Diseases']}"),




                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),

    );
  }
}
