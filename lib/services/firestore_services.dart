

import 'package:birdz_app/consts/firebase_consts.dart';

class FirestoreServices {
  //get user data
  static getUser(uid) {
    return firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();
  }

  //get birdsInfoList
  static getBirdsInfoList(){
    return firestore.collection(birdsInfoCollection).orderBy('BName').get();
  }
  static getBreedingGuideList() {
    return firestore.collection(breedingGuideCollection).orderBy('BName').get();
  }
  static getMedicationList(){
    return firestore.collection(medicationCollection).orderBy('Breed').get();
  }
  //get category products according to category
 static getProducts(category){
    return firestore.collection(ctgProductCollection).where('cp_category',isEqualTo: category).snapshots();
 }

  static getAllAds(){
    return firestore.collection(ctgProductCollection).where('cp_name').snapshots();
  }
  static getYoutubeLink(){
    return firestore.collection(birdsInfoCollection).where('Youtube').get();
  }

 //for getting all chat messages
static getChatMessages(docId){
    return firestore.collection(chatsCollection).doc(docId).collection(messagesCollection).orderBy('created_on',descending: false).snapshots();
}
static getAllMessages(){
    return firestore.collection(chatsCollection).where('from_Id',isEqualTo: currentUser!.uid).snapshots();
}

static getFeaturedProducts(){
    return firestore.collection(ctgProductCollection).where('is_featured',isEqualTo: true).get();
}
static searchProducts(title){
    return firestore.collection(ctgProductCollection).where('cp_name',isLessThanOrEqualTo: title).get();
}
static getSubCategoryProducts(title){
     return firestore.collection(ctgProductCollection).where('cp_subcategory',isEqualTo: title).snapshots();
}
// for my ads screen
static getMyAds(uid){
    return firestore.collection(ctgProductCollection).where('vendor_id',isEqualTo: uid).snapshots();
}
}