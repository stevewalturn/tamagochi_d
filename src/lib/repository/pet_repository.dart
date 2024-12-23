import 'package:tamagochi_d/models/pet_state.dart';

class PetRepository {
  PetState? _currentPet;

  Future<void> savePet(PetState pet) async {
    try {
      // TODO: Implement persistent storage
      _currentPet = pet;
    } catch (e) {
      throw Exception('Failed to save pet: Unable to store pet data');
    }
  }

  Future<PetState?> loadPet() async {
    try {
      // TODO: Implement persistent storage
      return _currentPet;
    } catch (e) {
      throw Exception('Failed to load pet: Unable to retrieve pet data');
    }
  }

  Future<void> deletePet() async {
    try {
      // TODO: Implement persistent storage
      _currentPet = null;
    } catch (e) {
      throw Exception('Failed to delete pet: Unable to remove pet data');
    }
  }
}
