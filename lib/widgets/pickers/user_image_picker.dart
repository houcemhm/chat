import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class userImagePicker extends StatefulWidget {
  const userImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  State<userImagePicker> createState() => _userImagePickerState();
}

class _userImagePickerState extends State<userImagePicker> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final pickedImageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    if (pickedImageFile == null) {
      return;
    }
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickFn(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage as File) : null,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text('Add Image')),
      ],
    );
  }
}
