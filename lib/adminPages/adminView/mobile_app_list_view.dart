import 'package:flutter/material.dart';
import 'package:makemoney/service/stateManagment/provider/mobile_course_provider.dart';
import 'package:provider/provider.dart';

import '../../core/commen/constants.dart';
import '../../service/model/course_model.dart';
import '../../widgets/listtile_shimmer_widget.dart';

class CourseRequestAdminWidget extends StatelessWidget {
  const CourseRequestAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Course Requests'),
      ),
      body: StreamBuilder<List<CourseModel>>(
        stream: Provider.of<MobileCourseProvider>(context).getCourseAdmin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ListTileShimmerWidget();
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Course Requests'));
          }
          List<CourseModel> courses = snapshot.data!;
          return ListView.builder(
            itemCount: courses.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final course = courses[index];

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Course Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            course.courseName!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          Text(
                            DateFormatter.formatDate(course.dateTime!),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Student Name
                      Row(
                        children: [
                          const Icon(Icons.person, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            course.studentName!,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black87),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Status with Chip
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.class_, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text(
                                course.studentClass!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
