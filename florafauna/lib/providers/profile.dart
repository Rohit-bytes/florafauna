import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class Profileprovider extends ChangeNotifier {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  String firstletter ="";
   File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  File? get imageFile => _imageFile;

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      notifyListeners(); // Notify UI of change
    } else {
      print('No image selected.');
    }
  }

  void clearImage() {
    _imageFile = null;
    notifyListeners();
  }
  bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
}