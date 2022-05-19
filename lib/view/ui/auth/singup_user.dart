import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpi_app/config/constants.dart';
import 'package:kpi_app/global.dart';
import 'package:kpi_app/models/user_models.dart';
import 'package:kpi_app/view/utils/background_unlogged.dart';
import 'package:kpi_app/view/utils/round_button.dart';

class SignupScreenUser extends StatefulWidget {
  @override
  State<SignupScreenUser> createState() => _SignupScreenUserState();
}

class _SignupScreenUserState extends State<SignupScreenUser> {
  String _fullName = "";

  String _passWord = "";
  String _phone = "";
  String _email = "";
  String _designation = "";
  String _address = "";
  String _relationStatus = "";
  String _date = "";
  String _id = "";
  bool _passwordHide = true;
  bool _passwordHide1 = true;

  final fullNameController = TextEditingController();
  final passWordController = TextEditingController();
  final passWordConfirmController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final designationController = TextEditingController();
  final addressController = TextEditingController();
  final relationStatusController = TextEditingController();
  var imagecontroller = new TextEditingController();

  //TextEditingController _ashik=new TextEditingController();
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

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    child: Container(
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.amber,
                          onTap: () {
                            pickImage(ImageSource.camera);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.camera,
                                color: Colors.white,
                              ),
                              Text(
                                "Camera",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [Colors.green, Colors.black87],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     pickImage(ImageSource.camera);
                  //   },
                  //   icon: const Icon(Icons.camera),
                  //   label: const Text("CAMERA"),
                  // ),
                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     pickImage(ImageSource.gallery);
                  //   },
                  //   icon: const Icon(Icons.image),
                  //   label: const Text("GALLERY"),
                  // ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    child: Container(
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.amber,
                          onTap: () {
                            pickImage(ImageSource.gallery);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.image,
                                color: Colors.white,
                              ),
                              Text(
                                "Galary",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [Colors.green, Colors.black87],
                          )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    child: Container(
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          splashColor: Colors.amber,
                          onTap: () {
                            Get.back();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                "Close",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [Colors.green, Colors.black87],
                          )),
                    ),
                  ),
                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     Get.back();
                  //   },
                  //   icon: const Icon(Icons.close),
                  //   label: const Text("CANCEL"),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackgroundUnlogged(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: <Widget>[
                Container(
                  height: size.height * .10,
                  child: Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text: "Signup",
                              style: TextStyle(
                                fontSize: 35,
                                color: PrimaryColor,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Alice-Regular',
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
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
                                border:
                                    Border.all(color: Colors.green, width: 5),
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
                                      )
                                    : Image.asset(
                                        "assets/images/kpii.png",
                                        height: size.height * 0.15,
                                        width: size.width * 0.35,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 5,
                              child: IconButton(
                                onPressed: () {
                                  imagePickerOption();
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
                    imagePickerOption();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextField(
                              controller: fullNameController,
                              decoration: InputDecoration(
                                labelText: "Full Name",
                                suffixIcon: Icon(
                                  Icons.perm_identity,
                                  color: Colors.lightGreen.shade500,
                                ),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Colors.lightGreen.shade500,
                                ),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .01,
                            ),
                            TextField(
                              obscureText: _passwordHide,
                              controller: passWordController,
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: Icon(Icons.vpn_key_rounded),
                                suffixIcon: IconButton(
                                  color: Colors.lightGreen.shade500,
                                  icon: _passwordHide
                                      ? Icon(Icons.visibility_rounded)
                                      : Icon(Icons.visibility_off_rounded),
                                  onPressed: () {
                                    setState(() {
                                      _passwordHide = !_passwordHide;
                                    });
                                  },
                                ),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            TextField(
                              obscureText: _passwordHide1,
                              controller: passWordConfirmController,
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
                                prefixIcon: Icon(Icons.vpn_key_rounded),
                                suffixIcon: IconButton(
                                  color: Colors.lightGreen.shade500,
                                  icon: _passwordHide1
                                      ? Icon(Icons.visibility_rounded)
                                      : Icon(Icons.visibility_off_rounded),
                                  onPressed: () {
                                    setState(() {
                                      _passwordHide1 = !_passwordHide1;
                                    });
                                  },
                                ),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
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
                                    borderSide:
                                        BorderSide(color: Colors.black)),
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
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .01,
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
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .01,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: size.height * .025,
                          ),
                          RoundedButton(
                              text: "Submit",
                              onPressed: () {
                                _email = emailController.value.text.toString();
                                _fullName =
                                    fullNameController.value.text.toString();
                                _address =
                                    addressController.value.text.toString();
                                _designation =
                                    designationController.value.text.toString();
                                _passWord =
                                    passWordController.value.text.toString();
                                _phone = phoneController.value.text.toString();
                                _relationStatus = relationStatusController
                                    .value.text
                                    .toString();
                                if (_email != null &&
                                    _phone != null &&
                                    _fullName != null &&
                                    _address != null &&
                                    _passWord != null &&
                                    _designation != null) {
                                  if (passWordConfirmController.value.text
                                          .toString() ==
                                      passWordController.value.text
                                          .toString()) {
                                    var user = UserModel(
                                      email: _email,
                                      id: '1',
                                      fullName: _fullName,
                                      phoneNumber: _phone,
                                      city: _address,
                                      joinDate: '111',
                                      designation: _designation,
                                      status: _relationStatus,
                                      password: _passWord,
                                    );
                                    createNewUser(user);
                                  } else {
                                    showToast(
                                        'Password Does not match', Colors.red);
                                  }
                                } else {
                                  showToast('Something Wrong', Colors.red);
                                }
                              }),
                          SizedBox(
                            height: size.height * .02,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).pushNamed("/");
                                },
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                          text: 'Already have an Account?',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Alice-Regular',
                                          )),
                                      TextSpan(
                                          text: ' Sign in',
                                          style: TextStyle(
                                            color: Colors.lightGreen.shade800,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * .03,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void createNewUser(UserModel user) async {
    try {
      if (pickedImage == null) {
        _globalMethods.authErrorHandle('Please select an image', context);
      } else {
        final ref = FirebaseStorage.instance
            .ref()
            .child('userimages')
            .child(_fullName + '.jpg');
        await ref.putFile(pickedImage!);
        url = await ref.getDownloadURL();
      }
      // print(user.email);
      // print(user.password);
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: user.email.toString(), password: user.password.toString());
      var newUser = userCredential.user;
      //print(newUser);
      final CollectionReference userCollection =
          await FirebaseFirestore.instance.collection('UserInfo');

      await userCollection.doc(newUser!.uid).set({
        'fullName': user.fullName.toString(),
        'email': user.email.toString(),
        'phone': user.phoneNumber.toString(),
        'relationshipStatus': user.status.toString(),
        'designation': user.designation.toString(),
        'city': user.city.toString(),
        'image': url,
      }).then((value) {
        showToast('User Created Successfully', Colors.green);
        Navigator.of(context).pushReplacementNamed("/dashboard/user");
      });
    } on FirebaseAuthException catch (e) {
      showToast('User Creation failed', Colors.red);
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.', Colors.red);
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.', Colors.red);
      }
    } catch (e) {
      showToast('User Creation failed', Colors.red);
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
