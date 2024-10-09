import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:makemoney/service/stateManagment/provider/mobile_course_provider.dart';
import 'package:makemoney/widgets/buy_sell_save_button.dart';
import 'package:makemoney/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class CourseRequestWidget extends StatefulWidget {
  const CourseRequestWidget({super.key});

  @override
  State<CourseRequestWidget> createState() => _CourseRequestWidgetState();
}

class _CourseRequestWidgetState extends State<CourseRequestWidget> {
  final _db = FirebaseFirestore.instance.collection("courseRequest");

  final stuName = TextEditingController();

  final stuClass = TextEditingController();

  final courseName = TextEditingController();

  bool isSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("کورس کی درخواست"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.02),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('براہ مہربانی فارم بھریں'),
            ),
            TextFieldWidget(
              controller: stuName,
              hintText: 'طالب علم کا نام',
            ),
            TextFieldWidget(
              controller: stuClass,
              hintText: 'طالب علم کی کلاس',
            ),
            TextFieldWidget(
              controller: courseName,
              hintText: 'کورس کا نام',
            ),
            SizedBox(height: Get.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: SaveButton(
                  isSubmit: isSubmit,
                  onSave: () async {
                    final pro = Provider.of<MobileCourseProvider>(context,
                        listen: false);
                    if (FirebaseAuth.instance.currentUser != null) {
                      if (stuName.text.isNotEmpty &&
                          stuClass.text.isNotEmpty &&
                          courseName.text.isNotEmpty) {
                        await addDoc(
                          FirebaseAuth.instance.currentUser!.uid,
                          {
                            'studentName': stuName.text,
                            'studentClass': stuClass.text,
                            'courseName': courseName.text,
                            'userId': FirebaseAuth.instance.currentUser!.uid,
                            'createdAt': FieldValue.serverTimestamp(),
                          },
                        );
                        pro.loadCourseCount();
                      } else {
                        AppUtils()
                            .toast('براہ کرم فارم کے تمام فیلڈز کو پُر کریں۔');
                      }
                    } else {
                      AppUtils()
                          .toast('براہ کرم فارم بھرنے کے لیے لاگ ان کریں۔');
                    }
                  },
                  text: "درخواست بھیجیں",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addDoc(String userId, Map<String, dynamic> data) async {
    QuerySnapshot querySnapshot = await _db
        .where('userId', isEqualTo: userId) // Check for matching userId field
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      AppUtils().toast('آپ پہلے ہی درخواست جمع کر چکے ہیں۔');
    } else {
      try {
        setState(() {
          isSubmit = true;
        });
        await _db.add(data);
        AppUtils().toast('آپ کی درخواست کی تصدیق ہو گئی ہے۔');
        Get.back();
        setState(() {
          isSubmit = false;
        });
      } on FirebaseException catch (e) {
        AppUtils().toast(e.message.toString());
        setState(() {
          isSubmit = false;
        });
      }
    }
  }
}
