// ignore_for_file: unused_local_variable, avoid_print
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

  pickImage(ImageSource imagesource) async {
  
  final ImagePicker _picker = ImagePicker();
  XFile? _image  = await _picker.pickImage(source: imagesource);
   
  if(_image != null){
      return await _image.readAsBytes();
  }
  else{  
    print("Image is not selected!");
  }

}
