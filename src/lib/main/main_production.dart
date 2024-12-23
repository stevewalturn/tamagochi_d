import 'package:tamagochi_d/main/bootstrap.dart';
import 'package:tamagochi_d/models/enums/flavor.dart';
import 'package:tamagochi_d/ui/views/app/app_view.dart';

void main() {
  bootstrap(
    builder: () => const AppView(),
    flavor: Flavor.production,
  );
}
