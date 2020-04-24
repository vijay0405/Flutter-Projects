import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    setState(() {
      _storedImage = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text("No Image Taken"),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
            label: Text(
              'Take Picture',
              textAlign: TextAlign.center,
            ),
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
