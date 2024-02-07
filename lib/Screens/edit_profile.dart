import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:realpalooza/Screens/base_screen.dart';
import 'package:realpalooza/constant/icons.dart';
import '../Theme/theme_provider.dart';
import '../components/text_field_two.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class EditProfille extends StatefulWidget {
  const EditProfille({super.key});

  @override
  State<EditProfille> createState() => _EditProfilleState();
}

class _EditProfilleState extends State<EditProfille> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final UserNameController = TextEditingController();
  final Cf = TextEditingController();
  final Cc = TextEditingController();
  final Atc = TextEditingController();

  String imageUrl = '';

  bool isUploading = false;
  FocusNode myFocusNode = FocusNode();

  void errorShowMessage(BuildContext context, String text) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: Dialog(
              backgroundColor: const Color(0xffe4f3ec),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xff26b051),
                      fontSize: 16,
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future submitFile() async{
    try {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser.email)
          .set({
        'dp' : imageUrl,
        'username' : UserNameController.text==''?currentUser.email?.split('@')[0]:UserNameController.text,
        'codeForces': Cf.text,
        'codeChef' : Cc.text,
        'atCoder' : Atc.text,
        'Email' : currentUser.email,

      });
    } catch(error){
      print(error);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const BaseScreen();
        },
      ),
    );

  }

  Future ByCamera() async {
    Navigator.pop(context);
    //1
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    //print('${file?.path}hello');

    if (file == null) return;

    String uniqueFileName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();

    //2
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    //3

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    //store

    setState(() {
      isUploading = true; // Set the flag to true when starting the upload
    });

    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      setState(() {
        isUploading = false;
      });
    } on PlatformException catch (e) {
      //some error
      print(e);
      setState(() {
        isUploading = false;
      });
    }
  }

  Future ByGallery() async{
    Navigator.pop(context);
    //1
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    //print('${file?.path}hello');

    if (file == null) return;

    String uniqueFileName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();

    //2
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    //3

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    //store

    setState(() {
      isUploading = true; // Set the flag to true when starting the upload
    });

    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      setState(() {
        isUploading = false;
      });
    } on PlatformException catch (e) {
      //some error
      print(e);
      setState(() {
        isUploading = false;
      });
    }
  }

  Future AltCamera() async=>
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .background,
            title: BounceInDown(
              child: Center(
                child: Text(
                  'Choose your Options',
                  style: TextStyle(color: Theme
                      .of(context)
                      .colorScheme
                      .secondary, fontSize: 16, fontFamily: 'Comfortaa'),
                ),
              ),
            ),
            content:
            Row(
              children: [
                const SizedBox(width: 40,),
                BounceInLeft(
                  child: IconButton(
                    onPressed: () {
                      ByCamera();
                    },
                    icon: Icon(Icons.camera_alt),
                    color: Theme
                        .of(context)
                        .brightness == Brightness.dark
                        ? Colors.white.withOpacity(.8)
                        : Colors.grey[800],
                    iconSize: 50,
                  ),
                ),
                const SizedBox(width: 30,),
                BounceInLeft(
                  child: GestureDetector(
                    onTap: ByGallery,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage(Theme
                              .of(context)
                              .brightness == Brightness.dark
                              ? gallery2
                              : gallery,),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
              ],
            ),
          );
        },);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
        appBar: AppBar(
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .primary,
            centerTitle: true,
            title: Text(
              'Edit Profile',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 25,
                color: Theme
                    .of(context)
                    .colorScheme
                    .secondary,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
                icon: Icon(
                  Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Icons.dark_mode
                      : Icons.dark_mode_outlined,
                  color: Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Colors.white.withOpacity(.8)
                      : Colors.grey[800],
                ),
              ),
            ],
            leading: BackButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BaseScreen(),
                      )
                  );
                }
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            )
        ),
        body:
          StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.email)
        .snapshots(),

            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> userData = <String, dynamic>{};
                if (snapshot.data!.data() != null) {
                  userData = snapshot.data!.data() as Map<String, dynamic>;
                } else {
                  userData['username'] = currentUser.email?.split('@')[0];
                  userData['dp'] =
                  'https://i.postimg.cc/CL3mxvsB/emptyprofile.jpg';
                }
                return SingleChildScrollView(
                    child: Column(
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Stack(
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  child: ClipOval(
                                    child: Image.network(
                                      userData['dp']==''?'https://i.postimg.cc/CL3mxvsB/emptyprofile.jpg':userData['dp'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 0,
                                            color: Theme
                                                .of(context)
                                                .brightness == Brightness.dark
                                                ? Colors
                                                .black12
                                                : Color(0xff26b051)
                                        ),
                                        color: Theme
                                            .of(context)
                                            .brightness == Brightness.dark
                                            ? Colors.grey
                                            : Color(0xff26b051)
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        AltCamera();
                                        //Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.camera_alt_outlined),
                                      color: Theme
                                          .of(context)
                                          .brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.white.withOpacity(.8),
                                    ),
                                  ),
                                )

                              ]
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Mytextfield2(
                            controller: UserNameController,
                            hintText: 'Enter Your New Name',
                            obscuretext: false,
                            focusNode: myFocusNode,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Mytextfield2(
                            controller: Cf,
                            hintText: 'Enter Your CodeForces Handle',
                            obscuretext: false,
                            focusNode: myFocusNode,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Mytextfield2(
                            controller: Cc,
                            hintText: 'Enter Your CodeChef Handle',
                            obscuretext: false,
                            focusNode: myFocusNode,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Mytextfield2(
                            controller: Atc,
                            hintText: 'Enter Your Atcoder Handle',
                            obscuretext: false,
                            focusNode: myFocusNode,
                          ),
                          const SizedBox(height: 50,),
                          GestureDetector(
                            onTap: () {
                              if(!isUploading){
                                submitFile();
                              }
                              else{
                                errorShowMessage(context, 'Uploading is ongoing');
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 120),
                              decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .brightness == Brightness.dark ? Colors
                                    .white
                                    .withOpacity(.8) : Color(0xff26b051),
                                borderRadius: BorderRadius.circular(30),
                              ),

                              child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .brightness == Brightness.dark
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Comfortaa',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                    )
                );
              }else if (snapshot.hasError) {
                //debug
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
