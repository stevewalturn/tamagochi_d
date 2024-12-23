import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tamagochi_d/repository/pet_repository.dart';
import 'package:tamagochi_d/services/analytic_service.dart';
import 'package:tamagochi_d/services/pet_service.dart';
import 'package:tamagochi_d/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:tamagochi_d/ui/bottom_sheets/pet_shop/pet_shop_sheet.dart';
import 'package:tamagochi_d/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:tamagochi_d/ui/dialogs/pet_death_dialog/pet_death_dialog.dart';
import 'package:tamagochi_d/ui/views/home/home_view.dart';
import 'package:tamagochi_d/ui/views/pet_actions/pet_actions_view.dart';
import 'package:tamagochi_d/ui/views/pet_statistics/pet_statistics_view.dart';
import 'package:tamagochi_d/ui/views/pet_status/pet_status_view.dart';
import 'package:tamagochi_d/ui/views/startup/startup_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: PetStatusView),
    MaterialRoute(page: PetActionsView),
    MaterialRoute(page: PetStatisticsView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    InitializableSingleton(classType: AnalyticService),
    LazySingleton(classType: PetRepository),
    InitializableSingleton(classType: PetService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: PetShopSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: PetDeathDialog),
  ],
)
class App {}
