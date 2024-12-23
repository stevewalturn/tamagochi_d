import 'package:flutter/material.dart';
import 'package:tamagochi_d/models/pet_state.dart';
import 'package:tamagochi_d/ui/common/app_colors.dart';

class PetAvatar extends StatelessWidget {
  final PetMood mood;
  final double size;

  const PetAvatar({
    required this.mood,
    this.size = 150,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getBackgroundColor(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: _getPetEmoji(),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (mood) {
      case PetMood.happy:
        return Colors.green.withOpacity(0.2);
      case PetMood.neutral:
        return Colors.blue.withOpacity(0.2);
      case PetMood.sad:
        return Colors.orange.withOpacity(0.2);
      case PetMood.sick:
        return Colors.red.withOpacity(0.2);
      case PetMood.sleeping:
        return kcMediumGrey.withOpacity(0.2);
    }
  }

  Widget _getPetEmoji() {
    String emoji;
    switch (mood) {
      case PetMood.happy:
        emoji = '😊';
      case PetMood.neutral:
        emoji = '😐';
      case PetMood.sad:
        emoji = '😢';
      case PetMood.sick:
        emoji = '🤒';
      case PetMood.sleeping:
        emoji = '😴';
    }
    return Text(
      emoji,
      style: TextStyle(
        fontSize: size * 0.5,
      ),
    );
  }
}
