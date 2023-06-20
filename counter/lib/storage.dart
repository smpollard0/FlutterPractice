import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'firebase_options.dart';


class CounterStorage{
  bool _initialized = false;
  CounterStorage();

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initialized = true;
    if (kDebugMode) {
      print('Initialized default app $app');
    }
  }

  bool get isInitialized => _initialized;

  // write a value to the counter an store it in the SQLite database
  Future<bool> writeCounter(int counter) async {
    try{
      if (!isInitialized){
        await initializeDefault();
      }
      return true;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  // read the value of the counter
  Future<int> readCounter() async {
      if (!isInitialized){
        await initializeDefault();
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot ds =
          await firestore.collection("example").doc("cins467").get();
      if (ds.data != null){
        Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
        if (data.containsKey("count"))
      }
    
      bool writeSuccess = await writeCounter(0);
      if(writeSuccess){
        return 0;
      }
    return -1;
  }

}