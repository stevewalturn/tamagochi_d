import 'package:equatable/equatable.dart';
import 'package:tamagochi_d/models/pet_stats.dart';

enum PetMood { happy, neutral, sad, sick, sleeping }

class PetState extends Equatable {
  final String name;
  final PetStats stats;
  final PetMood mood;
  final DateTime lastFed;
  final DateTime lastCleaned;
  final DateTime lastPlayed;
  final bool isSleeping;
  final int coins;

  const PetState({
    required this.name,
    required this.stats,
    required this.mood,
    required this.lastFed,
    required this.lastCleaned,
    required this.lastPlayed,
    required this.isSleeping,
    required this.coins,
  });

  factory PetState.initial(String name) {
    final now = DateTime.now();
    return PetState(
      name: name,
      stats: PetStats.initial(),
      mood: PetMood.happy,
      lastFed: now,
      lastCleaned: now,
      lastPlayed: now,
      isSleeping: false,
      coins: 100,
    );
  }

  PetState copyWith({
    String? name,
    PetStats? stats,
    PetMood? mood,
    DateTime? lastFed,
    DateTime? lastCleaned,
    DateTime? lastPlayed,
    bool? isSleeping,
    int? coins,
  }) {
    return PetState(
      name: name ?? this.name,
      stats: stats ?? this.stats,
      mood: mood ?? this.mood,
      lastFed: lastFed ?? this.lastFed,
      lastCleaned: lastCleaned ?? this.lastCleaned,
      lastPlayed: lastPlayed ?? this.lastPlayed,
      isSleeping: isSleeping ?? this.isSleeping,
      coins: coins ?? this.coins,
    );
  }

  @override
  List<Object?> get props => [
        name,
        stats,
        mood,
        lastFed,
        lastCleaned,
        lastPlayed,
        isSleeping,
        coins,
      ];
}
