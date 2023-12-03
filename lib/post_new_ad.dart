import 'package:birdz_app/controller/post_product_controller.dart';
import 'package:birdz_app/widgets/loading_indicator.dart';
import 'package:birdz_app/widgets/post_ad_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'components/ad_dropdown.dart';
import 'components/ad_images.dart';

class PostNewAd extends StatelessWidget {
  const PostNewAd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<PostProductController>();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent.shade400,
          actions: [
            controller.isloading.value ? loadingIndicator() : SizedBox(
              width: 85,
              child: ElevatedButton(
                  onPressed: () async {
                    controller.isloading(true);
                    await controller.uploadAdImages();
                    await controller.uploadProductAd(context);
                    Get.back();
                  },
                child: Text("Post Ad",style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.bold),),
            ),),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30,),
                postAdTextField(hint: "eg. Parrots",label: "Product Name",controller: controller.pNameController),
                const SizedBox(height: 10,),
                postAdTextField(hint: "Product Description",label: "Description", isDesc: true,controller: controller.pDescController),
                const SizedBox(height: 10,),
                postAdTextField(hint: "eg. 1000",label: "Price",controller: controller.pPriceController),
                const SizedBox(height: 10,),
                postAdTextField(hint: "eg. Islamabad, Karachi, Lahore",label: "Location",controller: controller.pLocationController),
                const Divider(color: Colors.grey,),
                const SizedBox(height: 10,),
                productCtgDropdown(hint: "Category",list: controller.catergoryList, dropvalue: controller.categoryValue, controller: controller),
                const SizedBox(height: 10,),
                productCtgDropdown(hint: "Subcategory",list: controller.subcatergoryList, dropvalue: controller.subcategoryValue, controller: controller),
                // SizedBox(height: 10,),
                // productCtgDropdown(),
                const SizedBox(height: 10,),
                const Divider(color: Colors.grey,),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Choose product images",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                ),
                const SizedBox(height: 9,),
                Obx(
                  () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      List.generate(3, (index) => controller.pAdImagesList[index] != null
                          ? Image.file(controller.pAdImagesList[index], width:100,height: 130,).onTap(() {
                            controller.pickAdImage(index, context);
                      })
                          : adProductImages(label: "${index+1}").onTap(() {
                        controller.pickAdImage(index, context);
                      })),
                    ),
                ),
                const SizedBox(height: 5,),
                Text("Your first image will be your ad display image",style: TextStyle(color: Colors.grey.shade400),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
