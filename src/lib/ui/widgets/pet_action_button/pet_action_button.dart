import 'package:flutter/material.dart';
import 'package:tamagochi_d/models/pet_actions.dart';
import 'package:tamagochi_d/ui/common/app_colors.dart';

class PetActionButton extends StatelessWidget {
  final PetAction action;
  final VoidCallback onPressed;
  final bool isEnabled;

  const PetActionButton({
    required this.action,
    required this.onPressed,
    this.isEnabled = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: _getActionColor(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getActionIcon(),
          const SizedBox(width: 8),
          Text(
            action.description,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${action.cost} coins',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Color _getActionColor() {
    switch (action) {
      case PetAction.feed:
        return Colors.orange;
      case PetAction.play:
        return Colors.blue;
      case PetAction.clean:
        return Colors.purple;
      case PetAction.heal:
        return Colors.green;
      case PetAction.sleep:
        return kcMediumGrey;
    }
  }

  Icon _getActionIcon() {
    switch (action) {
      case PetAction.feed:
        return const Icon(Icons.restaurant);
      case PetAction.play:
        return const Icon(Icons.sports_esports);
      case PetAction.clean:
        return const Icon(Icons.cleaning_services);
      case PetAction.heal:
        return const Icon(Icons.healing);
      case PetAction.sleep:
        return const Icon(Icons.bedtime);
    }
  }
}
