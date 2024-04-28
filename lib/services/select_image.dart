import 'package:image_picker/image_picker.dart';

Future<XFile?> getImageFromPhone() async {
  //instancia para utilzar el objeto
  final ImagePicker picker = ImagePicker();
  //funcion que espera la respuesta de la galeria
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  return image;
}
