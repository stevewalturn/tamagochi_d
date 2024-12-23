import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tamagochi_d/ui/common/ui_helpers.dart';
import 'package:tamagochi_d/ui/views/pet_statistics/pet_statistics_viewmodel.dart';

class PetStatisticsView extends StackedView<PetStatisticsViewModel> {
  const PetStatisticsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PetStatisticsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Statistics'),
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : viewModel.pet == null
              ? const Center(child: Text('No pet data available'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatCard(
                        'Last Fed',
                        viewModel.getLastFedTime(),
                        Icons.restaurant,
                      ),
                      verticalSpaceMedium,
                      _buildStatCard(
                        'Last Cleaned',
                        viewModel.getLastCleanedTime(),
                        Icons.cleaning_services,
                      ),
                      verticalSpaceMedium,
                      _buildStatCard(
                        'Last Played',
                        viewModel.getLastPlayedTime(),
                        Icons.sports_esports,
                      ),
                      verticalSpaceMedium,
                      _buildStatCard(
                        'Total Coins Earned',
                        viewModel.pet!.coins.toString(),
                        Icons.monetization_on,
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 32),
            horizontalSpaceMedium,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceSmall,
                Text(
                  value,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  PetStatisticsViewModel viewModelBuilder(BuildContext context) =>
      PetStatisticsViewModel();
}
