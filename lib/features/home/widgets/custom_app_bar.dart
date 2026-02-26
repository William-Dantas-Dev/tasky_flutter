import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String greeting;
  final String subtitle;

  const CustomAppBar({
    super.key,
    required this.greeting,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D2330),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6D7485),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}