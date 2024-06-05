import 'package:flutter/material.dart';

class RatingPopUp extends StatelessWidget {
  final int reportId;
  final Function(int) onRatingSubmitted;

  const RatingPopUp({
    super.key,
    required this.reportId,
    required this.onRatingSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: Text('Rate Report #$reportId'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter rating (1-5)',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            int rating = int.tryParse(controller.text) ?? 0;
            if (rating >= 1 && rating <= 5) {
              onRatingSubmitted(rating);
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Please enter a valid rating between 1 and 5')),
              );
            }
          },
          child: const Text('Submit'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
