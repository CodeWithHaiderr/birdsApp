


import 'dart:io';

import 'package:birdz_app/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';
import '../consts/firebase_consts.dart';
import '../models/category_model.dart';

class PostProductController extends GetxController{

  var isloading = false.obs;
  // 3 text field controllers for product name , description and price
  // 3 dropdowns for location, category and subcategory
  var pNameController = TextEditingController();
  var pDescController = TextEditingController();
  var pPriceController = TextEditingController();
  var pLocationController = TextEditingController();


  var catergoryList = <String>[].obs;
  var subcatergoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesLinks = [];
  // var pLocationList = [].obs;

  var pAdImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;

  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  } 
  
  populateCategoryList() {
    catergoryList.clear();

    for (var item in category) {
      catergoryList.add(item.name);
    }
  }
    
    populateSubcategory(cat){
      subcatergoryList.clear();
      
      var data = category.where((element) => element.name == cat).toList();

      for(var i=0 ; i < data.first.subcategory.length ; i++){
        subcatergoryList.add(data.first.subcategory[i]);
      }
    }

  pickAdImage(index,context) async {
    try {
      final img = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      }
      else {
        pAdImagesList[index] = File(img.path);
      }
    }
    catch(e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadAdImages() async{
    pImagesLinks.clear();
    for(var item in pAdImagesList){
      if(item!=null){
        var filename = basename(item.path);
        var destination = 'images/vendor/${currentUser!.uid}/filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImagesLinks.add(n);
      }
    }
  }

  uploadProductAd(context) async{
    var store = firestore.collection(ctgProductCollection).doc();
    await store.set({
      'cp_category': categoryValue.value,
      'cp_desc': pDescController.text,
      'cp_imgs': FieldValue.arrayUnion(pImagesLinks),
      'cp_location': pLocationController.text,
      'cp_name': pNameController.text,
      'cp_price': pPriceController.text,
      'cp_rating': "5.0",
      'cp_seller_name': Get.find<HomeController>().username,
      'cp_subcategory': subcategoryValue.value,
      'featured_id': '',
      'is_featured': false,
      'vendor_id': currentUser!.uid,
    });
    isloading(false);
    VxToast.show(context, msg: "Ad posted..");

  }

  adFeatured(docId) async {
    await firestore.collection(ctgProductCollection).doc(docId).set({
      'featured_id' : currentUser!.uid,
      'is_featured': true,
    }, SetOptions(merge: true));
  }

  removeFeatured(docId) async {
    await firestore.collection(ctgProductCollection).doc(docId).set({
      'featured_id' : '',
      'is_featured': false,
    }, SetOptions(merge: true));
  }

  deleteProduct(docId) async{
    await firestore.collection(ctgProductCollection).doc(docId).delete();
  }



}