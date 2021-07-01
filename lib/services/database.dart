import 'package:chaiwala420/models/chai_model.dart';
import 'package:chaiwala420/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chaiwala420/models/user_model.dart';

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

  //  UserData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength'),
    );
  }

  //  Get chai stream
  Stream<List<ChaiModel>> get chai {
    return chaiCollection.snapshots()
    .map(_chaiListFromSnapshot);
  }

  //  Get user document
  Stream<UserData> get userData {
    return chaiCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}