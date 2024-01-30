import 'package:flutter/material.dart';

class HourlyCard extends StatelessWidget {
  final String time;
  final IconData hourIcon;
  final double temp;

  const HourlyCard(
      {super.key,
      required this.time,
      required this.hourIcon,
      required this.temp});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          color: Colors.blueGrey[600],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Icon(
                hourIcon,
                size: 32,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                temp.toString(),
                style: const TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
