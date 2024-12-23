import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tamagochi_d/app/app.bottomsheets.dart';
import 'package:tamagochi_d/app/app.dialogs.dart';
import 'package:tamagochi_d/app/app.locator.dart';
import 'package:tamagochi_d/models/enums/flavor.dart';
import 'package:tamagochi_d/utils/flavors/flavors.dart';

Future<void> bootstrap({
  required FutureOr<Widget> Function() builder,
  required Flavor flavor,
}) async {
  await runZonedGuarded(
    () async {
      Flavors.flavor = flavor;
      WidgetsFlutterBinding.ensureInitialized();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      await setupLocator();
      setupDialogUi();
      setupBottomSheetUi();

      runApp(
        await builder(),
      );
    },
    (exception, stackTrace) async {},
  );
}
