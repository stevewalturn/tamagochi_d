import 'package:flutter/material.dart';
import 'package:tamagochi_d/ui/common/app_colors.dart';

class PetStatsBar extends StatelessWidget {
  final String label;
  final int value;
  final Color? color;

  const PetStatsBar({
    required this.label,
    required this.value,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: value / 100,
          backgroundColor: kcLightGrey,
          color: color ?? kcPrimaryColor,
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }
}
