import 'package:flutter/material.dart';
import 'package:ledger/common/holder/holders.dart';
import 'package:ledger/common/list/adapter_manager.dart';

class TextDelegate extends Delegate<String, TextHolder> {
  @override
  TextHolder getHolder() {
    return TextHolder();
  }
}

class IntDelegate extends DelegateHolder<int> {
  @override
  Widget build(BuildContext context, int data, int position) {
//    print("data: $data\t$position");
    return ListTile(
      leading: CircleAvatar(
        child: Text("$data"),
      ),
      title: Text("Position $position"),
      subtitle: Text("Hello World"),
    );
  }

  @override
  ViewHolder createCustomViewHolder() {
    return IntHolder();
  }
}
