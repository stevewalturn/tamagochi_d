import 'package:stacked/stacked.dart';
import 'package:tamagochi_d/app/app.locator.dart';
import 'package:tamagochi_d/services/pet_service.dart';

class PetDeathDialogModel extends BaseViewModel {
  final _petService = locator<PetService>();
  String? _modelError;

  String? get modelError => _modelError;

  Future<void> startNewPet(String name) async {
    setBusy(true);
    try {
      await _petService.createPet(name);
      _modelError = null;
    } catch (e) {
      _modelError = 'Unable to create a new pet. Please try again.';
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }
}
