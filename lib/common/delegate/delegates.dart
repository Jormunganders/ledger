import 'package:ledger/common/holder/holders.dart';
import 'package:ledger/common/list/adapter_manager.dart';

class TextDelegate extends Delegate<String, TextHolder> {
  @override
  TextHolder getHolder() {
    return TextHolder();
  }
}
