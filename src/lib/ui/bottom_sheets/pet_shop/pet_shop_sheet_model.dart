import 'package:stacked/stacked.dart';
import 'package:tamagochi_d/app/app.locator.dart';
import 'package:tamagochi_d/models/pet_actions.dart';
import 'package:tamagochi_d/models/pet_state.dart';
import 'package:tamagochi_d/services/pet_service.dart';

class PetShopSheetModel extends BaseViewModel {
  final _petService = locator<PetService>();
  String? _modelError;

  String? get modelError => _modelError;
  Stream<PetState> get petStream => _petService.petStateStream;

  bool canPurchase(PetAction action) {
    final currentPet = _petService.currentPet;
    if (currentPet == null) {
      _modelError = 'No pet available to make purchases';
      return false;
    }
    return action.canAfford(currentPet.coins);
  }

  Future<void> purchaseItem(PetAction action) async {
    try {
      await _petService.performAction(action);
      _modelError = null;
    } catch (e) {
      _modelError =
          'Unable to purchase item. Please check if you have enough coins.';
      notifyListeners();
    }
  }
}