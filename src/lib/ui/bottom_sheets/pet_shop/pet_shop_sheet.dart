import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagochi_d/models/pet_actions.dart';
import 'package:tamagochi_d/models/pet_state.dart';
import 'package:tamagochi_d/ui/bottom_sheets/pet_shop/pet_shop_sheet_model.dart';
import 'package:tamagochi_d/ui/common/app_colors.dart';
import 'package:tamagochi_d/ui/common/ui_helpers.dart';

class PetShopSheet extends StackedView<PetShopSheetModel> {
  final Function(SheetResponse)? completer;
  final SheetRequest request;

  const PetShopSheet({
    required this.completer,
    required this.request,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PetShopSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Pet Shop',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpaceMedium,
          StreamBuilder<PetState>(
            stream: viewModel.petStream,
            builder: (context, snapshot) {
              return Text(
                'Available Coins: ${snapshot.data?.coins ?? 0}',
                style: const TextStyle(
                  fontSize: 16,
                  color: kcPrimaryColor,
                ),
              );
            },
          ),
          verticalSpaceMedium,
          if (viewModel.modelError != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                viewModel.modelError!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ...PetAction.values.map(
            (action) => _ShopItem(
              action: action,
              onTap: () => viewModel.purchaseItem(action),
              isEnabled: viewModel.canPurchase(action),
            ),
          ),
          verticalSpaceMedium,
          TextButton(
            onPressed: () => completer?.call(SheetResponse()),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  PetShopSheetModel viewModelBuilder(BuildContext context) =>
      PetShopSheetModel();
}

class _ShopItem extends StatelessWidget {
  final PetAction action;
  final VoidCallback onTap;
  final bool isEnabled;

  const _ShopItem({
    required this.action,
    required this.onTap,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(action.description),
      trailing: Text('${action.cost} coins'),
      enabled: isEnabled,
      onTap: onTap,
    );
  }
}