import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_flutter_admin/domain/entities/user_support.dart';

import '../controllers/user_support_controller.dart';

class SupportList extends StatelessWidget {
  final UserSupport entry;
  const SupportList(this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    UserSupportController userSupportcontroller = Get.find();
    int id = entry.id ?? 0;
    // Placeholder values for attributes not present in UserSupport
    int reportCount = 0; // This should be obtained from another function
    double averageRating = 0.0; // This should be obtained from another function

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'id: ${id.toString()}',
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 4.0),
              Text(
                '# of reports: $reportCount',
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 4.0),
              Text(
                entry.email,
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  Text(
                    'Password: ${entry.password}',
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'average rating: $averageRating',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
