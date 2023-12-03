

import 'package:birdz_app/controller/catergory_controller.dart';
import 'package:birdz_app/category_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'consts/lists.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CategoryController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Featured Categories",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.greenAccent.shade400,
      ),
      body: Container(
        height: double.infinity,
        color: Colors.green.shade200,
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 200),
            itemBuilder:(context,index){
          return InkWell(
            onTap: (){
              controller.getSubCategories(catergoryListTxt[index]);
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryMain(title: catergoryListTxt[index])));
            },
            child: Column(
              children: [
                Image.asset(categoryListImg[index],height: 130,width: 200,fit: BoxFit.cover,),
                const SizedBox(height: 10,),
                Text(catergoryListTxt[index],style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),),
              ],
            ).box.green200.rounded.clip(Clip.antiAlias).outerShadow.make(),
          );
            }),
      ),
    );
  }
}
