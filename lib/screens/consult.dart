import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/userModel.dart';
class Consult extends StatefulWidget {
  const Consult({Key? key}) : super(key: key);

  @override
  State<Consult> createState() => _ConsultState();
}

class _ConsultState extends State<Consult> {
  final Query queries = FirebaseDatabase.instance.ref('doctorData');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: const Text(
            "Consult",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Text(
          "Psychologist's",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: FirebaseAnimatedList(
            query: queries,
            itemBuilder: (context, snapshot, animation, index) {
              Map<dynamic, dynamic> doctor =
              snapshot.value as Map<dynamic, dynamic>;
              return GestureDetector(
                onTap: () {
                  showPopUp(
                      imageUrl: doctor['imageUrl'],
                      firstName: doctor['firstName'],
                      lastName: doctor['lastName'],
                      city: doctor['city'],
                      qualification: doctor['qualification'],
                      specification: doctor['specification'],
                      email: doctor['email'],
                      description: doctor['description']);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 20,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: CircleAvatar(
                            radius: 40,
                            child: ClipOval(
                              child: Image(
                                image: NetworkImage(doctor['imageUrl']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        reusingFormat(doctor['firstName'], 10),
                        reusingFormat(doctor['lastName'], 10),
                        reusingFormat(doctor['specification'], 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Padding reusingFormat(String data, double bottomPadding) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, bottomPadding),
      child: Text(data),
    );
  }

  Padding reusingFormatWithDesign(String data, double bottomPadding,
      TextAlign textAlign, double fontSize, FontWeight fontWeight) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, bottomPadding),
      child: Text(
        data,
        textAlign: textAlign,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }

  Future showPopUp(
      {required String imageUrl,
        required String firstName,
        required String lastName,
        required String city,
        required String email,
        required String qualification,
        required String specification,
        required String description}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: Wrap(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: CircleAvatar(
                        radius: 60,
                        child: ClipOval(
                          child: Image(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    reusingFormatWithDesign("$firstName $lastName", 10,
                        TextAlign.center, 20, FontWeight.bold),
                    reusingFormatWithDesign(specification, 10, TextAlign.center,
                        17, FontWeight.normal),
                    reusingFormatWithDesign(description, 10, TextAlign.justify,
                        15, FontWeight.normal),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                        Theme.of(context).colorScheme.onPrimary,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        elevation: 15,
                        shape: const StadiumBorder(), //Colors.tealAccent,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        dialog(firstName,email);
                      },
                      child: const Text("Connect"),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future dialog(String firstName, String email){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        content: Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(8,0,0,10),
                  child: Text("ARE YOU SURE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                      sendEmail(firstName,email);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "You will be emailed about further details"),
                        ),
                      );
                    },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                          Theme.of(context).colorScheme.onPrimary,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          elevation: 15,
                          shape: const StadiumBorder(), //Colors.tealAccent,
                        ),
                        child: const Text("YES")),
                    ElevatedButton(onPressed: (){
                        Navigator.pop(context);
                      },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                          Theme.of(context).colorScheme.onPrimary,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          elevation: 15,
                          shape: const StadiumBorder(), //Colors.tealAccent,
                        ),
                        child: const Text("NO"))
                  ],
                )
              ],
            ),
          ],
        )
      );
    });
  }

  Future sendEmail(String firstName,String email) async{
    final url=Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId="service_ajylttf";
    const templateId="template_ye5jlpg";
    const userId="Cg5cuQeP20yLImQjy";
    final UserModel user = await getUserInfo();
    final responce=await http.post(url,headers:{'Content-Type':'application/json'},
    body:json.encode({
      "service_id":serviceId,
      "template_id":templateId,
      "user_id":userId,
      "template_params":{
        "patientName": user.name,
        "doctorEmail": email,
        "doctorName": firstName,
        "patientUsn": user.usn,
        "patientEmail": user.email,
        "patientPhno": user.phno,
      }
    })
    );
    print(responce.statusCode);
    return responce.statusCode;
  }

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
}
