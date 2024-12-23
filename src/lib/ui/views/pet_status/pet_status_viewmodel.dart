import 'dart:async';
import 'package:stacked/stacked.dart';
import 'package:tamagochi_d/app/app.locator.dart';
import 'package:tamagochi_d/models/pet_state.dart';
import 'package:tamagochi_d/services/pet_service.dart';

class PetStatusViewModel extends StreamViewModel<PetState> {
  final _petService = locator<PetService>();
  String? _modelError;

  String? get modelError => _modelError;
  PetState? get currentPet => data;

  @override
  Stream<PetState> get stream => _petService.petStateStream;

  Future<void> createNewPet(String name) async {
    setBusy(true);
    try {
      await _petService.createPet(name);
      _modelError = null;
    } catch (e) {
      _modelError = 'Unable to create your pet. Please try again.';
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  void clearError() {
    _modelError = null;
    notifyListeners();
  }
}
