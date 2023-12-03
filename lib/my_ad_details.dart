



import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyAdDetails extends StatelessWidget {
  final String? title;
  final dynamic data;

  const MyAdDetails({Key? key,this.title,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey.shade800,
        ),
        backgroundColor: Colors.white,
        // title: Text(title!,style: TextStyle(color: Colors.grey.shade800),),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VxSwiper.builder(
                  itemCount: data['cp_imgs'].length,
                  // autoPlay: true,
                  height:200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.9,
                  itemBuilder: (context,index) {
                    return Image.network(
                      data["cp_imgs"][index],
                      width: double.infinity,
                      fit: BoxFit.fitHeight,
                    );
                  }),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title!,style: TextStyle(color: Colors.grey.shade800,fontSize: 18,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("${data['cp_category']}",style: TextStyle(color: Colors.grey.shade500),),
                        const SizedBox(width: 15,),
                        Text("${data['cp_subcategory']}",style: TextStyle(color: Colors.grey.shade500),),

                      ],
                    ),
                    const SizedBox(height: 10,),
                    VxRating(
                      value: 3.0,
                      onRatingUpdate: (value){},
                      normalColor: Vx.gray300,
                      selectionColor: const Color(0xffad9c03),
                      count: 5,
                      maxRating: 5,
                      size: 25,
                    ),
                    const SizedBox(height: 15,),
                    Text("Rs ""${data['cp_price']}""/-",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFF3E2723)),),
                    const SizedBox(height: 15,),
                    const Text("Description:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    const SizedBox(height: 5,),
                    Text("${data['cp_desc']}",),

                    const SizedBox(height: 80,),
                    Row(
                      children: [
                        const Icon(Icons.location_on),
                        const SizedBox(width: 5,),
                        Text("${data['cp_location']}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),

      ),
    );
  }
}
