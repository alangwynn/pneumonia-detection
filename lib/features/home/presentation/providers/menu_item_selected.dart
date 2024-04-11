import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_item_selected.g.dart';

@Riverpod(keepAlive: true)
class MenuItemState extends _$MenuItemState {

  @override
  int build() {
    return 0;
  }

  void setValue(int value) {
    state = value;
  }

}
