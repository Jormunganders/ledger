import 'package:ledger/common/delegate/delegates.dart';
import 'package:ledger/common/list/adapter_manager.dart';

class FeedAdapterManager extends AdapterManager {
  FeedAdapterManager() {
    registerDelegate(new TextDelegate());
  }
}
