import 'dart:async';
import 'package:stacked/stacked_annotations.dart';
import 'package:tamagochi_d/app/app.locator.dart';
import 'package:tamagochi_d/models/pet_actions.dart';
import 'package:tamagochi_d/models/pet_state.dart';
import 'package:tamagochi_d/models/pet_stats.dart';
import 'package:tamagochi_d/repository/pet_repository.dart';

class PetService implements InitializableDependency {
  final _repository = locator<PetRepository>();
  PetState? _currentPet;
  Timer? _decayTimer;
  final _petStateController = StreamController<PetState>.broadcast();

  Stream<PetState> get petStateStream => _petStateController.stream;
  PetState? get currentPet => _currentPet;

  PetService();

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

  void _startDecayTimer() {
    _decayTimer?.cancel();
    _decayTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _decayPetStats();
    });
  }

  Future<void> createPet(String name) async {
    final newPet = PetState.initial(name);
    await _repository.savePet(newPet);
    _currentPet = newPet;
    _petStateController.add(newPet);
    _startDecayTimer();
  }

  Future<void> performAction(PetAction action) async {
    if (_currentPet == null) {
      throw Exception('No pet available to perform action');
    }

    if (!action.canAfford(_currentPet!.coins)) {
      throw Exception('Not enough coins to perform this action');
    }

    final updatedPet = _currentPet!.copyWith(
      stats: _calculateNewStats(action),
      coins: _currentPet!.coins - action.cost,
    );

    await _repository.savePet(updatedPet);
    _currentPet = updatedPet;
    _petStateController.add(updatedPet);
  }

  void _decayPetStats() {
    if (_currentPet == null) return;

    final updatedStats = _currentPet!.stats.copyWith(
      hunger: _currentPet!.stats.hunger - 5,
      happiness: _currentPet!.stats.happiness - 3,
      energy: _currentPet!.stats.energy - 2,
      hygiene: _currentPet!.stats.hygiene - 4,
    );

    final updatedPet = _currentPet!.copyWith(
      stats: updatedStats,
      mood: _calculateMood(updatedStats),
    );

    _repository.savePet(updatedPet);
    _currentPet = updatedPet;
    _petStateController.add(updatedPet);
  }

  PetStats _calculateNewStats(PetAction action) {
    switch (action) {
      case PetAction.feed:
        return _currentPet!.stats.copyWith(
          hunger: _currentPet!.stats.hunger + 30,
          energy: _currentPet!.stats.energy + 10,
        );
      case PetAction.play:
        return _currentPet!.stats.copyWith(
          happiness: _currentPet!.stats.happiness + 25,
          energy: _currentPet!.stats.energy - 15,
        );
      case PetAction.clean:
        return _currentPet!.stats.copyWith(
          hygiene: _currentPet!.stats.hygiene + 40,
          happiness: _currentPet!.stats.happiness + 5,
        );
      case PetAction.heal:
        return _currentPet!.stats.copyWith(
          health: _currentPet!.stats.health + 50,
          energy: _currentPet!.stats.energy - 10,
        );
      case PetAction.sleep:
        return _currentPet!.stats.copyWith(
          energy: _currentPet!.stats.energy + 60,
          hunger: _currentPet!.stats.hunger - 10,
        );
    }
  }

  PetMood _calculateMood(PetStats stats) {
    if (stats.isDead) return PetMood.sad;
    if (_currentPet!.isSleeping) return PetMood.sleeping;
    if (stats.health < 30) return PetMood.sick;
    if (stats.happiness < 30 || stats.hunger < 30) return PetMood.sad;
    if (stats.happiness > 70 && stats.hunger > 70) return PetMood.happy;
    return PetMood.neutral;
  }
}
