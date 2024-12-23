import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:tamagochi_d/app/app.locator.dart';
import 'package:tamagochi_d/models/pet_state.dart';
import 'package:tamagochi_d/services/pet_service.dart';

class PetStatisticsViewModel extends StreamViewModel<PetState> {
  final _petService = locator<PetService>();
  final _dateFormat = DateFormat('MMM dd, yyyy hh:mm a');

  PetState? get pet => data;

  @override
  Stream<PetState> get stream => _petService.petStateStream;

  String getLastFedTime() {
    if (pet == null) return 'N/A';
    return _dateFormat.format(pet!.lastFed);
  }

  String getLastCleanedTime() {
    if (pet == null) return 'N/A';
    return _dateFormat.format(pet!.lastCleaned);
  }

  String getLastPlayedTime() {
    if (pet == null) return 'N/A';
    return _dateFormat.format(pet!.lastPlayed);
  }

  Duration getTimeSinceLastFed() {
    if (pet == null) return Duration.zero;
    return DateTime.now().difference(pet!.lastFed);
  }

  Duration getTimeSinceLastCleaned() {
    if (pet == null) return Duration.zero;
    return DateTime.now().difference(pet!.lastCleaned);
  }

  Duration getTimeSinceLastPlayed() {
    if (pet == null) return Duration.zero;
    return DateTime.now().difference(pet!.lastPlayed);
  }
}
