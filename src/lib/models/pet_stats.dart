import 'package:equatable/equatable.dart';

class PetStats extends Equatable {
  final int hunger;
  final int happiness;
  final int health;
  final int energy;
  final int hygiene;

  const PetStats({
    required this.hunger,
    required this.happiness,
    required this.health,
    required this.energy,
    required this.hygiene,
  });

  factory PetStats.initial() {
    return const PetStats(
      hunger: 100,
      happiness: 100,
      health: 100,
      energy: 100,
      hygiene: 100,
    );
  }

  PetStats copyWith({
    int? hunger,
    int? happiness,
    int? health,
    int? energy,
    int? hygiene,
  }) {
    return PetStats(
      hunger: hunger ?? this.hunger,
      happiness: happiness ?? this.happiness,
      health: health ?? this.health,
      energy: energy ?? this.energy,
      hygiene: hygiene ?? this.hygiene,
    );
  }

  bool get isDead =>
      hunger <= 0 ||
      happiness <= 0 ||
      health <= 0 ||
      energy <= 0 ||
      hygiene <= 0;

  @override
  List<Object?> get props => [hunger, happiness, health, energy, hygiene];
}
