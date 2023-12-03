


import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BreedingGuideHome extends StatelessWidget {
  final String? title;
  final dynamic data;
  const BreedingGuideHome({Key? key,required this.title,required this.data}) : super(key: key);

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
                            itemCount: data['BImg'].length,
                            // autoPlay: true,
                            height:200,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.9,
                            itemBuilder: (context,index) {
                              return Image.network(
                                data["BImg"],
                                width: double.infinity,
                                fit: BoxFit.fitHeight,
                              );
                            }),

                        // const SizedBox(height: 20,),
                        // Text(title!,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 23),),
                        // SizedBox(height: 10,),
                        // Text("${data['BDesc']}"),
                        // SizedBox(height: 15,),
                        // Row(
                        //   children: [
                        //     Text("Breeding Age:   ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        //     Text("${data['BreedingAge']}"),
                        //   ],
                        // ),
                        // SizedBox(height: 10,),
                        // Row(
                        //   children: [
                        //     Text("Breeding Temperature:   ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        //     Text("${data['BreedingTemp']}"),
                        //   ],
                        // ),
                        // SizedBox(height: 10,),
                        // Row(
                        //   children: [
                        //     Text("Eggs per clutch:   ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        //     Text("${data['BEggs']}"),
                        //   ],
                        // ),
                        // SizedBox(height: 10,),
                        // Text("Diet:  ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        // SizedBox(height: 3,),
                        // Text("${data['Diet']}"),
                        // SizedBox(height: 10,),
                        // Text("Ideal Cage Size:  ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        // SizedBox(height: 3,),
                        // Text("${data['CageSize']}"),





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
