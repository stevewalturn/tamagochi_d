import 'package:tamagochi_d/models/pet_state.dart';

class PetRepository {
  PetState? _currentPet;

  Future<void> savePet(PetState pet) async {
    _currentPet = pet;
  }

  Future<PetState?> loadPet() async {
    return _currentPet;
  }

  Future<void> deletePet() async {
    _currentPet = null;
  }
}