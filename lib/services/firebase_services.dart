import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsers() async {
  List users = [];

  CollectionReference collectionReferenceUsers = db.collection('users');

  QuerySnapshot queryUsers = await collectionReferenceUsers.get();

  queryUsers.docs.forEach((documento) {
    users.add(documento.data());
  });

  return users;
}

Future<List<Map<String, dynamic>>> getCars() async {
  List<Map<String, dynamic>> carsList = [];

  CollectionReference collectionReferenceUsers = db.collection('users');

  QuerySnapshot queryUsers = await collectionReferenceUsers.get();

  queryUsers.docs.forEach((documento) {
    var userData = documento.data();
    if (userData != null &&
        userData is Map<String, dynamic> &&
        userData['cars'] != null) {
      // Extraer los coches y agregarlos a la lista
      Map<String, dynamic> cars = userData['cars'];
      carsList.addAll(cars.values.cast<Map<String, dynamic>>());
    }
  });

  return carsList;
}

Future<List<Map<String, dynamic>>> getMyCars(String id) async {
  List<Map<String, dynamic>> carsList = [];

  CollectionReference collectionReferenceUsers = db.collection('users');

  QuerySnapshot queryUsers = await collectionReferenceUsers.get();

  queryUsers.docs.forEach((documento) {
    var userData = documento.data();
    print(userData);
    if (userData != null &&
        userData is Map<String, dynamic> &&
        userData['cars'] != null) {
      // Extraer los coches y agregarlos a la lista
      Map<String, dynamic> cars = userData['cars'];
      carsList.addAll(cars.values.cast<Map<String, dynamic>>());
    }
  });

  return carsList;
}

/**El id que recibe es el id del usuario, que quiere saber los amigos */
Future<List<int>> getMyFriends(String username) async {
  print('\n\nUsername que se recibe::::${username}');

  CollectionReference collectionReferenceUsers = db.collection('users');

  QuerySnapshot queryUsers = await collectionReferenceUsers.get();

  List<int> friends = [];

  queryUsers.docs.forEach((documento) {
    var userData = documento.data();

    print(userData);
    if (userData != null &&
        userData is Map<String, dynamic> &&
        userData['id_friends'] != null) {
      // Extraer los coches y agregarlos a la lista
      friends = userData['id_friends'];
      //carsList.addAll(cars.values.cast<Map<String, dynamic>>());
    }
  });
  print('* ' * 30);
  print(friends);
  return friends;
}
