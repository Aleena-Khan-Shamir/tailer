import 'dart:io';
import 'dart:typed_data';

import 'package:alma_app/authenticationHelper/authentication_helper.dart';
import 'package:alma_app/components/custom_suffix_icon.dart';
import 'package:alma_app/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../home_for_tailor/home_screen.dart';

class CompleteProfileFormT extends StatefulWidget {
  CompleteProfileFormT({Key? key}) : super(key: key);

  @override
  State<CompleteProfileFormT> createState() => _CompleteProfileFormTState();
}

class _CompleteProfileFormTState extends State<CompleteProfileFormT> {
  final TextEditingController fNameC = TextEditingController();

  final TextEditingController lNameC = TextEditingController();

  final TextEditingController pNumberC = TextEditingController();

  final TextEditingController addressC = TextEditingController();
  File? _photo;
  bool _isLoading = false;
  selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() {
      _photo = File(pickedFile.path);
    });
  }

  // Future getImageFromGallery() async {
  //   final _photo = (await ImagePicker().pickImage(source: ImageSource.gallery));
  //   if (_photo == null) return;
  //   setState(() {
  //     _photo;
  //   });

  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
        child: Column(
          children: [
            Stack(
              children: [
                _photo != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: FileImage(File(_photo!.path)),
                        backgroundColor: Colors.transparent,
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage:
                            NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                        backgroundColor: Colors.transparent,
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                )
              ],
            ),
            SizedBox(height: 0.02.sh),
            buildFirstNameFormField(),
            SizedBox(height: 0.03.sh),
            buildLastNameFormField(),
            SizedBox(height: 0.03.sh),
            buildLPhoneNumberFormField(),
            SizedBox(height: 0.03.sh),
            buildAddressFormField(),
            SizedBox(height: 0.04.sh),
            DefaultButton(
                text: 'Continue',
                press: () {
                  AuthenticationHelper.compProfile(fNameC.text, lNameC.text,
                          pNumberC.text, addressC.text, _photo)
                      .then((value) {
                    //  print('abc:${value}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TailorHomeScreen(),
                      ),
                    );
                  });
                  //Navigator.pushNamed(context, TailorHomeScreen.routeName);
                })
          ],
        ),
      ),
    );
  }

  TextFormField buildLPhoneNumberFormField() {
    return TextFormField(
      controller: pNumberC,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Phone number',
        hintText: 'Enter your phone number',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Phone.svg",
        ),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: addressC,
      decoration: const InputDecoration(
        labelText: 'Address',
        hintText: 'Enter your address ',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Location point.svg",
        ),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: lNameC,
      decoration: const InputDecoration(
        labelText: 'Last Name',
        hintText: 'Enter your last Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: fNameC,
      decoration: const InputDecoration(
        labelText: 'FirstName',
        hintText: 'Enter your first Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/User.svg",
        ),
      ),
    );
  }
}
