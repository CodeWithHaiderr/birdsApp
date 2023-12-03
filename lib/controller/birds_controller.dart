

import 'package:birdz_app/consts/firebase_consts.dart';
import 'package:get/get.dart';

class BirdsController extends GetxController{

 getInfoList() async {
   var birdsInfoList = firestore.collection(birdsInfoCollection).orderBy('BName',).snapshots();
 }
 getBreedingGuide() async{
   var breedingGuide = firestore.collection(breedingGuideCollection).orderBy('BName').snapshots();
 }
 getMedicationGuide() async{
   var medicationGuide = firestore.collection(medicationCollection).orderBy('Breed').snapshots();
 }
}