import 'package:flutter/widgets.dart';
import 'package:ledger/common/list/adapter_manager.dart';

class TextHolder extends ViewHolder<String> {
  @override
  Widget build(BuildContext context, String data, int position) {
    return Text("Position $position $data");
  }
}
