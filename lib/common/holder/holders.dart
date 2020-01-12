import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ledger/common/list/adapter_manager.dart';

class TextHolder extends ViewHolder<String> {
  @override
  Widget build(BuildContext context, String data, int position) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.access_time,color: Colors.white,),
        backgroundColor: Colors.red,
      ),
      title: Text("Position $position $data"),
    );
  }
}
