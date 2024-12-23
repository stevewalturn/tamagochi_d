import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tamagochi_d/ui/common/app_colors.dart';
import 'package:tamagochi_d/ui/common/ui_helpers.dart';
import 'package:tamagochi_d/ui/views/home/home_viewmodel.dart';
import 'package:tamagochi_d/ui/widgets/pet_avatar/pet_avatar.dart';
import 'package:tamagochi_d/ui/widgets/pet_mood_indicator/pet_mood_indicator.dart';
import 'package:tamagochi_d/ui/widgets/pet_stats_bar/pet_stats_bar.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tamagotchi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: viewModel.showShop,
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : viewModel.pet == null
              ? _buildNoPetView(viewModel)
              : _buildPetView(viewModel),
    );
  }

  Widget _buildNoPetView(HomeViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Welcome to Tamagotchi!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          verticalSpaceMedium,
          ElevatedButton(
            onPressed: viewModel.createNewPet,
            child: const Text('Create New Pet'),
          ),
          if (viewModel.modelError != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                viewModel.modelError!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPetView(HomeViewModel viewModel) {
    final pet = viewModel.pet!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pet.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${pet.coins} coins',
                style: const TextStyle(
                  fontSize: 18,
                  color: kcPrimaryColor,
                ),
              ),
            ],
          ),
          verticalSpaceMedium,
          PetAvatar(mood: pet.mood),
          verticalSpaceMedium,
          PetMoodIndicator(mood: pet.mood),
          verticalSpaceMedium,
          PetStatsBar(
            label: 'Hunger',
            value: pet.stats.hunger,
            color: Colors.orange,
          ),
          verticalSpaceSmall,
          PetStatsBar(
            label: 'Happiness',
            value: pet.stats.happiness,
            color: Colors.pink,
          ),
          verticalSpaceSmall,
          PetStatsBar(
            label: 'Health',
            value: pet.stats.health,
            color: Colors.green,
          ),
          verticalSpaceSmall,
          PetStatsBar(
            label: 'Energy',
            value: pet.stats.energy,
            color: Colors.blue,
          ),
          verticalSpaceSmall,
          PetStatsBar(
            label: 'Hygiene',
            value: pet.stats.hygiene,
            color: Colors.purple,
          ),
          verticalSpaceLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.restaurant),
                onPressed: viewModel.feedPet,
                tooltip: 'Feed',
              ),
              IconButton(
                icon: const Icon(Icons.sports_esports),
                onPressed: viewModel.playWithPet,
                tooltip: 'Play',
              ),
              IconButton(
                icon: const Icon(Icons.healing),
                onPressed: viewModel.healPet,
                tooltip: 'Heal',
              ),
              IconButton(
                icon: const Icon(Icons.bathtub),
                onPressed: viewModel.cleanPet,
                tooltip: 'Clean',
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialize();
}
