
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:image_picker/image_picker.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  File? _image;
  final picker = ImagePicker();
  String? base64Image;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      base64Image = base64Encode(_image!.readAsBytesSync());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.themeGreenColor,
        title: const Text('Ask Question'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(width * 0.04),
          decoration: BoxDecoration(
            color: AppColors.themeWhiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Subject:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textButtonColor,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                    width: width * 0.7,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '  Your Subject',
                        contentPadding: const EdgeInsets.all(0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.09),
                    child: const Text(
                      ' Description:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textButtonColor,
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.65,
                    decoration: const BoxDecoration(),
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: '  your description?',
                        contentPadding: EdgeInsets.all(width * 0.02),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.6),
                child: TextButton(
                  onPressed: () {
                    _settingModalBottomSheet(context);
                  },
                  child: const Text('+ Attach Image'),
                ),
              ),
              _image != null
                  ? Container(
                height: height * 0.35,
                width: width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image: FileImage(_image!),
                    fit: BoxFit.fill,
                  ),
                ),
              )
                  : Container(),
              SizedBox(height: height * 0.02),
              const AppBtn(
                title: 'Post',
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _settingModalBottomSheet(context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: heights / 7,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  widths / 12, 0, widths / 12, heights / 60),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: heights / 20,
                      width: widths / 2.7,
                      decoration: BoxDecoration(
                          // color: Colors.blue,
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.gradientFirstColor,
                              AppColors.gradientSecondColor
                            ],
                          ),
                          border: Border.all(
                              color: AppColors.themeWhiteColor, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        'Camera',
                        style: TextStyle(color: AppColors.themeWhiteColor),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: heights / 20,
                      width: widths / 2.7,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.gradientFirstColor,
                              AppColors.gradientSecondColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        'Gallery',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
