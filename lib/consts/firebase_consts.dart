

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collections
const usersCollection = "users";
const ctgProductCollection = "category_products";
const chatsCollection = "chats";
const messagesCollection = 'messages';
const birdsInfoCollection = 'birds_list';
const breedingGuideCollection = "breeding_guide";
const medicationCollection = "medication";
