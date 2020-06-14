import 'package:flutter/material.dart';
import 'package:ledger/common/holder/holders.dart';
import 'package:ledger/common/list/adapter_manager.dart';
import 'package:ledger/common/list/banner.dart';

// 测试用
class TextDelegate extends Delegate<String, TextHolder> {
  @override
  TextHolder getHolder() {
    return TextHolder();
  }
}

// 测试用
class IntDelegate extends DelegateHolder<int> {
  @override
  Widget build(BuildContext context, int data, int position) {
    return ListTile(
      leading: CircleAvatar(
        child: Text("$data"),
      ),
      title: Text("Position $position"),
      subtitle: Text("Hello World"),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
