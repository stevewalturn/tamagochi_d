import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagochi_d/app/app.bottomsheets.dart';
import 'package:tamagochi_d/app/app.dialogs.dart';
import 'package:tamagochi_d/app/app.locator.dart';
import 'package:tamagochi_d/models/pet_actions.dart';
import 'package:tamagochi_d/models/pet_state.dart';
import 'package:tamagochi_d/services/pet_service.dart';

class HomeViewModel extends StreamViewModel<PetState> {
  final _petService = locator<PetService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();

  String? _modelError;

  String? get modelError => _modelError;
  PetState? get pet => data;

  @override
  Stream<PetState> get stream => _petService.petStateStream;

  Future<void> initialize() async {
    await runBusyFuture(_checkPetStatus());
  }

  Future<void> _checkPetStatus() async {
    if (pet?.stats.isDead ?? false) {
      await _showPetDeathDialog();
    }
  }

  Future<void> createNewPet() async {
    final response = await _dialogService.showDialog(
      title: 'Name Your Pet',
      description: 'Enter a name for your new pet:',
      barrierDismissible: true,
    );

    if (response?.confirmed ?? false) {
      try {
        final name = response?.data?.toString() ?? 'My Pet';
        await _petService.createPet(name);
        _modelError = null;
      } catch (e) {
        _modelError = 'Failed to create pet. Please try again.';
        notifyListeners();
      }
    }
  }

  Future<void> showShop() async {
    await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'Pet Shop',
      description: 'Buy items for your pet',
    );
  }

  Future<void> feedPet() async {
    await _performAction(PetAction.feed);
  }

  Future<void> playWithPet() async {
    await _performAction(PetAction.play);
  }

  Future<void> cleanPet() async {
    await _performAction(PetAction.clean);
  }

  Future<void> healPet() async {
    await _performAction(PetAction.heal);
  }

  Future<void> _performAction(PetAction action) async {
    try {
      await _petService.performAction(action);
      _modelError = null;
    } catch (e) {
      _modelError = 'Unable to perform action: ${e.toString()}';
      notifyListeners();
    }
  }

  Future<void> _showPetDeathDialog() async {
    final response = await _dialogService.showDialog(
      title: 'Your Pet Has Passed Away',
      description: 'Would you like to start with a new pet?',
    );

    if (response?.confirmed ?? false) {
      await createNewPet();
    }
  }
}
