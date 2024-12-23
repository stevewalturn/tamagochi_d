import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagochi_d/ui/common/ui_helpers.dart';
import 'package:tamagochi_d/ui/dialogs/pet_death_dialog/pet_death_dialog_model.dart';

class PetDeathDialog extends StackedView<PetDeathDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const PetDeathDialog({
    required this.request,
    required this.completer,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PetDeathDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.sentiment_very_dissatisfied,
              size: 48,
              color: Colors.red,
            ),
            verticalSpaceMedium,
            Text(
              request.title ?? 'Your Pet Has Passed Away',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpaceSmall,
            Text(
              request.description ??
                  'Would you like to start over with a new pet?',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            verticalSpaceMedium,
            if (viewModel.modelError != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  viewModel.modelError!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: const Text('Not Now'),
                ),
                ElevatedButton(
                  onPressed: () => completer(DialogResponse(confirmed: true)),
                  child: const Text('New Pet'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  PetDeathDialogModel viewModelBuilder(BuildContext context) =>
      PetDeathDialogModel();
}
