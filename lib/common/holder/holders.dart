import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ledger/common/list/adapter_manager.dart';

class TextHolder extends ViewHolder<String> {
  @override
  Widget build(BuildContext context, String data, int position) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.access_time),
      ),
      title: Text("Position $position $data"),
    );
  }
}

class IntHolder extends ViewHolder<int> {
  @override
  Widget build(BuildContext context, int data, int position) {
    print("data: $data\t$position");
    return ListTile(
      leading: CircleAvatar(
        child: Text("$data"),
      ),
      title: Text("Position $position"),
      subtitle: Text("Hello World"),
    );
  }
}
