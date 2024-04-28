import 'package:cloud_firestore/cloud_firestore.dart';

getUsers() async {
  //obteniendo la coleccion
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users");
  //consultado la coleccion obtenido anteriormente. obteniendo todo lo que tiene esa coleccion con .get
  QuerySnapshot users = await collectionReference.get();
  var usuarios = [];

//si no esta vacia la coleccion la imprimie
  if (users.docs.length != 0) {
    for (var doc in users.docs) {
      //data es la informacion que contiene
      usuarios.add(doc.data());
      print('\nUSARIO::${doc.data()};\n\n');
    }
    return usuarios;
  }
  return 'No recibio nada';
}
