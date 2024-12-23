import 'package:stacked/stacked.dart';
import 'package:tamagochi_d/app/app.locator.dart';
import 'package:tamagochi_d/models/pet_actions.dart';
import 'package:tamagochi_d/models/pet_state.dart';
import 'package:tamagochi_d/services/pet_service.dart';

class PetActionsViewModel extends StreamViewModel<PetState> {
  final _petService = locator<PetService>();
  String? _modelError;

  String? get modelError => _modelError;
  int get availableCoins => data?.coins ?? 0;

  @override
  Stream<PetState> get stream => _petService.petStateStream;

  bool canPerformAction(PetAction action) {
    if (data == null) {
      _modelError = 'No pet available to perform actions';
      return false;
    }
    return action.canAfford(data!.coins);
  }

  Future<void> performAction(PetAction action) async {
    if (!canPerformAction(action)) {
      _modelError = 'Not enough coins to perform this action';
      notifyListeners();
      return;
    }

    setBusy(true);
    try {
      await _petService.performAction(action);
      _modelError = null;
    } catch (e) {
      _modelError = 'Unable to perform action. Please try again.';
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
