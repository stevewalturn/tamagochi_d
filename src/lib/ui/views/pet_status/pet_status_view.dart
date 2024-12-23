import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tamagochi_d/ui/common/ui_helpers.dart';
import 'package:tamagochi_d/ui/views/pet_status/pet_status_viewmodel.dart';
import 'package:tamagochi_d/ui/widgets/pet_avatar/pet_avatar.dart';
import 'package:tamagochi_d/ui/widgets/pet_mood_indicator/pet_mood_indicator.dart';
import 'package:tamagochi_d/ui/widgets/pet_stats_bar/pet_stats_bar.dart';

class PetStatusView extends StackedView<PetStatusViewModel> {
  const PetStatusView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PetStatusViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Status'),
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : viewModel.currentPet == null
              ? _buildNoPetView(viewModel)
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (viewModel.modelError != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            viewModel.modelError!,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      Text(
                        viewModel.currentPet!.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpaceMedium,
                      PetAvatar(mood: viewModel.currentPet!.mood),
                      verticalSpaceMedium,
                      PetMoodIndicator(mood: viewModel.currentPet!.mood),
                      verticalSpaceLarge,
                      PetStatsBar(
                        label: 'Hunger',
                        value: viewModel.currentPet!.stats.hunger,
                      ),
                      verticalSpaceSmall,
                      PetStatsBar(
                        label: 'Happiness',
                        value: viewModel.currentPet!.stats.happiness,
                      ),
                      verticalSpaceSmall,
                      PetStatsBar(
                        label: 'Health',
                        value: viewModel.currentPet!.stats.health,
                      ),
                      verticalSpaceSmall,
                      PetStatsBar(
                        label: 'Energy',
                        value: viewModel.currentPet!.stats.energy,
                      ),
                      verticalSpaceSmall,
                      PetStatsBar(
                        label: 'Hygiene',
                        value: viewModel.currentPet!.stats.hygiene,
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildNoPetView(PetStatusViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No Pet Found',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpaceMedium,
          ElevatedButton(
            onPressed: () => viewModel.createNewPet('My Pet'),
            child: const Text('Create New Pet'),
          ),
        ],
      ),
    );
  }

  @override
  PetStatusViewModel viewModelBuilder(BuildContext context) =>
      PetStatusViewModel();
}
