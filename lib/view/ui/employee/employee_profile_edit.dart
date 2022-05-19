import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpi_app/config/constants.dart';
import 'package:kpi_app/global.dart';
import 'package:kpi_app/models/user_models.dart';
import 'package:kpi_app/view/utils/background_all.dart';
import 'package:kpi_app/view/utils/round_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeProfileUpdate extends StatefulWidget {
  EmployeeProfileUpdate({Key? key}) : super(key: key);

  @override
  State<EmployeeProfileUpdate> createState() => _EmployeeProfileUpdateState();
}

class _EmployeeProfileUpdateState extends State<EmployeeProfileUpdate> {
  String _fullName = "";
  String _image = "";
  String _passWord = "";
  String _phone = "";
  String _email = "";
  String _designation = "";
  String _address = "";
  String _relationStatus = "";
  String _joinDate = "";

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final designationController = TextEditingController();
  final addressController = TextEditingController();

  Map<String, dynamic>? userInfoMap;
  var oldUserInfo;
  File? pickedImage;
  late String url;
  GlobalMethods _globalMethods = GlobalMethods();

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      //Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      fullNameController.text = value.getString('oldFullName')!;
      phoneController.text = value.getString('oldPhone')!;
      designationController.text = value.getString('oldDesignation')!;
      addressController.text = value.getString('oldCity')!;
      _joinDate = value.getString('oldJoinDate')!;
      if (value.getString('oldStatus')!.length > 2) {
        _relationStatus = value.getString('oldStatus')!;
      }
      setState(() {});
    });
  }

  // @override
  // void dispose() async{
  //   // TODO: implement dispose
  //   super.dispose();
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // sharedPreferences.clear();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      header: ' Employee Profile Update ',
      child: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * .002,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  Container(
                    width: size.width * 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.green, width: 5),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: pickedImage != null
                                            ? Image.file(
                                                pickedImage!,
                                                width: size.width * 0.35,
                                                height: size.height * 0.15,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.asset(
                                                "assets/images/kpii.png",
                                                height: size.height * 0.15,
                                                width: size.width * 0.35,
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 5,
                                      child: IconButton(
                                        onPressed: () {
                                          pickImage(ImageSource.gallery);
                                        },
                                        icon: const Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            pickImage(ImageSource.gallery);
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        TextField(
                          controller: fullNameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            suffixIcon: Icon(
                              Icons.perm_identity,
                              color: Colors.lightGreen.shade500,
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        TextField(
                          controller: designationController,
                          decoration: InputDecoration(
                            labelText: "Designation",
                            suffixIcon: Icon(
                              Icons.whatshot_outlined,
                              color: Colors.lightGreen.shade500,
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            suffixIcon: Icon(
                              Icons.phone,
                              color: Colors.lightGreen.shade500,
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        TextField(
                          controller: addressController,
                          decoration: InputDecoration(
                            labelText: "Address",
                            suffixIcon: Icon(
                              Icons.location_city,
                              color: Colors.lightGreen.shade500,
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        DropdownSearch(
                          mode: Mode.MENU,
                          items: const ["Married", "Unmarried", "Cancel"],
                          label: "Relationship Status",
                          onChanged: (value) {
                            _relationStatus = value.toString();
                          },
                          selectedItem: _relationStatus,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        DateTimePicker(
                          type: DateTimePickerType.date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          dateLabelText: 'Join Date',
                          icon: const Icon(Icons.event),
                          onChanged: (value) {
                            _joinDate = value;
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: size.height * .045,
                      ),
                      RoundedButton(
                        text: "Save Info",
                        color: PrimaryButtonColor,
                        textColor: Colors.black,
                        onPressed: () {
                          _fullName = fullNameController.value.text.toString();
                          _address = addressController.value.text.toString();
                          _designation =
                              designationController.value.text.toString();
                          _phone = phoneController.value.text.toString();

                          if (_phone != null &&
                              _fullName != null &&
                              _address != null &&
                              _relationStatus != null &&
                              _designation != null) {
                            var user = UserModel(
                              email: _email,
                              id: '1',
                              fullName: _fullName,
                              phoneNumber: _phone,
                              city: _address,
                              joinDate: _joinDate.toString(),
                              designation: _designation,
                              status: _relationStatus,
                              password: _passWord,
                            );
                            editProfile(user);
                          } else {
                            showToast('Something Wrong', Colors.red);
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * .03,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  void editProfile(UserModel user) async {
    try {
      if (pickedImage == null) {
        _globalMethods.authErrorHandle('Please pick an image', context);
      } else {
        final ref = FirebaseStorage.instance
            .ref()
            .child('userimages')
            .child(_fullName + '.jpg');
        await ref.putFile(pickedImage!);
        url = await ref.getDownloadURL();
      }
      FirebaseAuth auth = FirebaseAuth.instance;
      var userID = auth.currentUser;

      final CollectionReference userCollection =
          await FirebaseFirestore.instance.collection('UserInfo');
      await userCollection.doc(userID!.uid).set({
        'fullName': user.fullName.toString(),
        'phone': user.phoneNumber.toString(),
        'email': userID.email,
        'relationshipStatus': user.status.toString(),
        'joinDate': user.joinDate.toString(),
        'designation': user.designation.toString(),
        'city': user.city.toString(),
        'image': url,
      }).then((value) {
        showToast('Edit Successful', Colors.green);

        Navigator.of(context)
            .pushNamedAndRemoveUntil("/dashboard/user", (route) => false);
      });
    } catch (e) {
      showToast('User Profile Update failed', Colors.red);
      print(e.toString());
    }
  }

  void showToast(String message, Color colors) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colors,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
