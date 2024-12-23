import 'dart:async';
import 'package:stacked/stacked_annotations.dart';
import 'package:tamagochi_d/models/pet_actions.dart';
import 'package:tamagochi_d/models/pet_state.dart';
import 'package:tamagochi_d/models/pet_stats.dart';
import 'package:tamagochi_d/repository/pet_repository.dart';

class PetService implements InitializableDependency {
  final PetRepository _repository;
  PetState? _currentPet;
  Timer? _decayTimer;
  final _petStateController = StreamController<PetState>.broadcast();

  Stream<PetState> get petStateStream => _petStateController.stream;

  PetService(this._repository);

  @override
  Future<void> init() async {
    try {
      _currentPet = await _repository.loadPet();
      if (_currentPet != null) {
        _startDecayTimer();
        _petStateController.add(_currentPet!);
      }
    } catch (e) {
      throw Exception('Failed to initialize pet service: ${e.toString()}');
    }
  }

  Future<void> createPet(String name) async {
    try {
      _currentPet = PetState.initial(name);
      await _repository.savePet(_currentPet!);
      _startDecayTimer();
      _petStateController.add(_currentPet!);
    } catch (e) {
      throw Exception('Failed to create pet: Unable to initialize new pet');
    }
  }

  Future<void> performAction(PetAction action) async {
    if (_currentPet == null) {
      throw Exception('No active pet found');
    }

    if (!action.canAfford(_currentPet!.coins)) {
      throw Exception('Not enough coins to perform this action');
    }

    try {
      final updatedStats = _calculateNewStats(action);
      final updatedPet = _currentPet!.copyWith(
        stats: updatedStats,
        coins: _currentPet!.coins - action.cost,
        mood: _calculateMood(updatedStats),
      );

      _currentPet = updatedPet;
      await _repository.savePet(updatedPet);
      _petStateController.add(updatedPet);
    } catch (e) {
      throw Exception('Failed to perform action: ${e.toString()}');
    }
  }

  PetStats _calculateNewStats(PetAction action) {
    final currentStats = _currentPet!.stats;
    switch (action) {
      case PetAction.feed:
        return currentStats.copyWith(
          hunger: _clamp(currentStats.hunger + 30),
          energy: _clamp(currentStats.energy + 10),
        );
      case PetAction.play:
        return currentStats.copyWith(
          happiness: _clamp(currentStats.happiness + 20),
          energy: _clamp(currentStats.energy - 10),
          hunger: _clamp(currentStats.hunger - 10),
        );
      case PetAction.clean:
        return currentStats.copyWith(
          hygiene: _clamp(currentStats.hygiene + 40),
          happiness: _clamp(currentStats.happiness + 10),
        );
      case PetAction.heal:
        return currentStats.copyWith(
          health: _clamp(currentStats.health + 50),
          energy: _clamp(currentStats.energy + 20),
        );
      case PetAction.sleep:
        return currentStats.copyWith(
          energy: _clamp(currentStats.energy + 40),
          health: _clamp(currentStats.health + 10),
        );
    }
  }

  int _clamp(int value) => value.clamp(0, 100);

  PetMood _calculateMood(PetStats stats) {
    if (stats.health < 30) return PetMood.sick;
    if (stats.happiness < 30) return PetMood.sad;
    if (stats.happiness > 70) return PetMood.happy;
    return PetMood.neutral;
  }

  void _startDecayTimer() {
    _decayTimer?.cancel();
    _decayTimer = Timer.periodic(
      const Duration(minutes: 1),
      (_) => _applyDecay(),
    );
  }

  Future<void> _applyDecay() async {
    if (_currentPet == null) return;

    try {
      final currentStats = _currentPet!.stats;
      final updatedStats = currentStats.copyWith(
        hunger: _clamp(currentStats.hunger - 2),
        happiness: _clamp(currentStats.happiness - 1),
        energy: _clamp(currentStats.energy - 1),
        hygiene: _clamp(currentStats.hygiene - 1),
      );

      final updatedPet = _currentPet!.copyWith(
        stats: updatedStats,
        mood: _calculateMood(updatedStats),
      );

      _currentPet = updatedPet;
      await _repository.savePet(updatedPet);
      _petStateController.add(updatedPet);
    } catch (e) {
      throw Exception('Failed to apply decay: ${e.toString()}');
    }
  }

  void dispose() {
    _decayTimer?.cancel();
    _petStateController.close();
  }
}
