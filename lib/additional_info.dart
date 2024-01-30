import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final IconData addicon;
  final String condition;
  final String temp;

  const AdditionalInfo({
    super.key,
    required this.addicon,
    required this.condition,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              addicon,
              size: 36,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              condition,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              temp,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
