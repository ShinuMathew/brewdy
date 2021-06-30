import 'package:chaiwala420/models/chai_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  //  Collection reference
  final CollectionReference chaiCollection = FirebaseFirestore.instance.collection("chai");

  Future updateUserData(String sugar, String name, int strength) async {
    return await chaiCollection.doc(uid).set({
      'sugars' : sugar,
      'name' : name,
      'strength' : strength
    });
  }

  // Chai list from snapshot
  List<ChaiModel> _chaiListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((chai) {
      return ChaiModel(name: chai.get('name') ?? '',
          strength: chai.get('strength') ?? 0,
          sugars: chai.get('sugars') ?? '0');
    }).toList();
  }

  Stream<List<ChaiModel>> get chai {
    return chaiCollection.snapshots()
    .map(_chaiListFromSnapshot);
  }
}