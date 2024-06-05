import 'package:flutter/material.dart';
import 'package:proyecto_flutter_admin/domain/entities/report.dart';
import 'package:proyecto_flutter_admin/ui/controllers/report_controller.dart';
import 'package:get/get.dart';

import './qualify_reports.dart';

class ReportList extends StatelessWidget {
  final Report entry;
  ReportList(this.entry, {Key? key}) : super(key: key);

  ReportController user_supportController = Get.find();
  void _showRatingDialog(BuildContext context, int reportId) {
    showDialog(
      context: context,
      builder: (context) {
        return RatingPopUp(
          reportId: reportId,
          onRatingSubmitted: (rating) {
            // Handle the rating submission logic here
            entry.calification = rating;
            user_supportController.updateReport(entry);
            print('Rating submitted: $rating');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showRatingDialog(context, entry.id ?? 0),
      child: Container(
        margin: const EdgeInsets.all(8.0),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(Icons.person, color: Colors.blue),
                    ),
                    const SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Name', // Asumiendo que deberías obtener el nombre desde otra fuente
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Report Id: ${entry.id ?? 'N/A'}'),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Calification',
                        style: TextStyle(fontSize: 12.0)),
                    Text(
                     entry.calification != 0 ? entry.calification.toString() : '-',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Client: Client name', // Asumiendo que deberías obtener el nombre del cliente desde otra fuente
              style: TextStyle(fontSize: 14.0),
            ),
            Text(
              'Client id: ${entry.id_client}',
              style: const TextStyle(fontSize: 14.0),
            ),
            Text(
              'Date: ${entry.time_started}',
              style: const TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              entry.problem,
              style: const TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Duration time: ${entry.time_end}', // Aquí deberías calcular y mostrar la duración
              style: const TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
