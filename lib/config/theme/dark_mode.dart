
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dark_mode.g.dart';

@riverpod
class DarkModeTheme extends _$DarkModeTheme {

  @override
  bool build() {
    return false;
  }

  void changeMode() {
    state = !state;
  }

}
