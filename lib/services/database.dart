import 'package:brew_crew/models/myuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/coffee.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //Collection reference
  final CollectionReference coffeeCollection = FirebaseFirestore.instance.collection('coffees');

  Future updateUserData(String name, String choice, String sugars, int strength) async {
    return await coffeeCollection.doc(uid).set({'name': name, 'choice': choice,'sugars': sugars, 'strength': strength});
  }

  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Coffee(name: doc.get('name') ?? '', choice: doc.get('choice') ?? '', sugars: doc.get('sugars') ?? 0, strength: doc.get('strength') ?? 0);
    }).toList();
  }

  //User data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(uid: uid, name: snapshot['name'], choice: snapshot['choice'], sugars: snapshot['sugars'], strength: snapshot['strength']);
  }

  //Coffee Stream
  Stream<List<Coffee>> get coffees {
    return coffeeCollection.snapshots().map(_coffeeListFromSnapshot);
  }

  //User Doc Stream
  Stream<UserData> get userData {
    return coffeeCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}