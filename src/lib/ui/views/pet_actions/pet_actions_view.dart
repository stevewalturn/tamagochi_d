import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tamagochi_d/models/pet_actions.dart';
import 'package:tamagochi_d/ui/common/ui_helpers.dart';
import 'package:tamagochi_d/ui/views/pet_actions/pet_actions_viewmodel.dart';
import 'package:tamagochi_d/ui/widgets/pet_action_button/pet_action_button.dart';

class PetActionsView extends StackedView<PetActionsViewModel> {
  const PetActionsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PetActionsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Actions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (viewModel.modelError != null)
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.red.shade100,
                child: Text(
                  viewModel.modelError!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            verticalSpaceMedium,
            Text(
              'Available Coins: ${viewModel.availableCoins}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpaceLarge,
            Expanded(
              child: ListView.separated(
                itemCount: PetAction.values.length,
                separatorBuilder: (context, index) => verticalSpaceMedium,
                itemBuilder: (context, index) {
                  final action = PetAction.values[index];
                  return PetActionButton(
                    action: action,
                    onPressed: () => viewModel.performAction(action),
                    isEnabled: viewModel.canPerformAction(action),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  PetActionsViewModel viewModelBuilder(BuildContext context) =>
      PetActionsViewModel();
}
