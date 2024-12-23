import 'package:flutter/material.dart';
import 'package:tamagochi_d/models/pet_state.dart';
import 'package:tamagochi_d/ui/common/app_colors.dart';

class PetMoodIndicator extends StatelessWidget {
  final PetMood mood;

  const PetMoodIndicator({
    required this.mood,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getMoodColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getMoodIcon(),
          const SizedBox(width: 4),
          Text(
            _getMoodText(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getMoodColor() {
    switch (mood) {
      case PetMood.happy:
        return Colors.green;
      case PetMood.neutral:
        return Colors.blue;
      case PetMood.sad:
        return Colors.orange;
      case PetMood.sick:
        return Colors.red;
      case PetMood.sleeping:
        return kcMediumGrey;
    }
  }

  Icon _getMoodIcon() {
    switch (mood) {
      case PetMood.happy:
        return const Icon(Icons.sentiment_very_satisfied, color: Colors.white);
      case PetMood.neutral:
        return const Icon(Icons.sentiment_neutral, color: Colors.white);
      case PetMood.sad:
        return const Icon(Icons.sentiment_dissatisfied, color: Colors.white);
      case PetMood.sick:
        return const Icon(Icons.sick, color: Colors.white);
      case PetMood.sleeping:
        return const Icon(Icons.bedtime, color: Colors.white);
    }
  }

  String _getMoodText() {
    switch (mood) {
      case PetMood.happy:
        return 'Happy';
      case PetMood.neutral:
        return 'Normal';
      case PetMood.sad:
        return 'Sad';
      case PetMood.sick:
        return 'Sick';
      case PetMood.sleeping:
        return 'Sleeping';
    }
  }
}
