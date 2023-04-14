import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../models/userModel.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String cal =
      "As Indian Cuisine is very large and the calories vary a lot no matter if it is a heavy meal or a lighter one thus it becomes difficult to take account of each and every dish thus we found the average of the most frequent heavy and light meals and concluded heavy meals as 400 Calories and a light meal as 200 Calories.";
  String about =
      "We the KARL group after seeing huge increase in the mental health illness throughout the country we thought of helping them with right services and helping them to recover and showing the best path for recovery.";

  late String profilePicUrl;

  Future<String> getEachUserInfo(String data) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    var eachInfo = await FirebaseDatabase.instance
        .ref('userData/$currentUserId/basicInfo/$data')
        .get();
    return eachInfo.value.toString();
  }

  Future<UserModel> getUserInfo() async {
    String usn = await getEachUserInfo('usn');
    String name = await getEachUserInfo('name');
    String email = await getEachUserInfo('email');
    String phno = await getEachUserInfo('phno');
    String profilePicUrl = await getEachUserInfo('profilePicUrl');
    profilePicUrl ??= await FirebaseStorage.instance.ref('defaultImages/man5').getDownloadURL();
    UserModel userModel = UserModel(
        usn: usn,
        name: name,
        email: email,
        phno: phno,
        profilePicUrl: profilePicUrl);
    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getUserInfo(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              UserModel tempUser = UserModel(
                  usn: snapshot.data.usn,
                  name: snapshot.data.name,
                  email: snapshot.data.email,
                  phno: snapshot.data.phno,
                  profilePicUrl: snapshot.data.profilePicUrl);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              child: ClipOval(
                                child: Image(
                                  image: NetworkImage(tempUser.profilePicUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  profileImageSelection();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text(
                        "Personal Info",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      //color: Colors.tealAccent,
                    ),
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: const Text('Name'),
                      trailing: Text(tempUser.name),
                    ),
                    ListTile(
                      leading: const Icon(Icons.school_outlined),
                      title: const Text('USN'),
                      trailing: Text(tempUser.usn),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email_outlined),
                      title: const Text('Email'),
                      trailing: Text(tempUser.email),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone_android_outlined),
                      title: const Text('Phone'),
                      trailing: Text(tempUser.phno),
                    ),
                    const Divider(
                      thickness: 2,
                      //color: Colors.tealAccent,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text(
                        "FAQ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      //color: Colors.tealAccent,
                    ),
                    ExpandablePanel(
                      header: const ListTile(
                        leading: Icon(Icons.arrow_right_alt),
                        title: Text("How are Calories calculated?"),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Text(
                          cal,
                          textAlign: TextAlign.justify,
                          softWrap: true,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      collapsed: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Text(
                          cal,
                          textAlign: TextAlign.justify,
                          softWrap: true,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    ExpandablePanel(
                      header: const ListTile(
                        leading: Icon(Icons.arrow_right_alt),
                        title: Text("About Us?"),
                      ),
                      expanded: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Text(
                          about,
                          textAlign: TextAlign.justify,
                          softWrap: true,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      collapsed: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: Text(
                          about,
                          textAlign: TextAlign.justify,
                          softWrap: true,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(0, 75, 0, 0 ),),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("try again later"),
              );
            }
          },
        ),
      ),
    );
  }

  Future profileImageSelection() {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (BuildContext contest) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Select your desired option to set your profile picture",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: IconButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              imageFromUser(ImageSource.camera);
                            },
                            icon: const Icon(Icons.photo_camera_outlined)),
                      ),
                      const Text(
                        "Camera",
                      )
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              imageFromUser(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.photo_library_outlined)),
                      ),
                      const Text(
                        "Gallery",
                      )
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              selectingDefaultImage();
                            },
                            icon: const Icon(Icons.mood)),
                      ),
                      const Text(
                        "Default",
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future selectingDefaultImage() {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              const Text(
                "Select your desired profile picture",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              FutureBuilder(
                  future: getAllDefaultImages(),
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      return Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          shrinkWrap: true,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            crossAxisCount: 3,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                imageFromDefault(snapshot.data![index]);
                              },
                              child: CircleAvatar(
                                radius: 80,
                                child: ClipOval(
                                  child: Image(
                                    image: NetworkImage(snapshot.data![index]),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(child: Text("check your internet"));
                    }
                  })
            ],
          );
        });
  }

  Future<List<String>> getAllDefaultImages() async {
    Reference reference = FirebaseStorage.instance.ref('defaultImages');
    final listResult = await reference.listAll();
    List<String> downloadUrls = [];
    for (var item in listResult.items) {
      String url = await item.getDownloadURL();
      downloadUrls.add(url);
    }
    return downloadUrls;
  }

  void imageFromUser(ImageSource imageSource) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? result = await imagePicker.pickImage(source: imageSource);
    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Image Selected"),
        ),
      );
      return null;
    }
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: result.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).colorScheme.onPrimary,
            toolbarWidgetColor: Theme.of(context).colorScheme.primary,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
      ],
    );
    Uint8List bytes = await croppedFile!.readAsBytes();
    await updateImageInBackend(bytes);
  }

  void imageFromDefault(String downloadUrl) async {
    Uint8List bytes =
    (await NetworkAssetBundle(Uri.parse(downloadUrl)).load(downloadUrl))
        .buffer
        .asUint8List();
    await updateImageInBackend(bytes);
  }

  Future<void> updateImageInBackend(Uint8List bytes) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    try {
      Reference ref =
      FirebaseStorage.instance.ref('profilePics/$currentUserId');
      UploadTask uploadTask =
      ref.putData(bytes, SettableMetadata(contentType: 'image/jpeg'));
      TaskSnapshot taskSnapshot = await uploadTask
          .whenComplete(() => print('done'))
          .catchError((error) => print('something went wrong'));
      String url = await taskSnapshot.ref.getDownloadURL();
      DatabaseReference reference =
      FirebaseDatabase.instance.ref("userData/$currentUserId/basicInfo");
      await reference.update({
        "profilePicUrl": url,
      });
      setState(() {
        profilePicUrl = url;
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
