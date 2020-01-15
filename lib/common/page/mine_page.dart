import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ledger/common/colors.dart';
import 'package:ledger/common/strings.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          me,
          style: TextStyle(color: common_606060),
        ),
        leading: Icon(
          Icons.edit,
          color: common_606060,
        ),
        centerTitle: true,
        actions: <Widget>[
          Icon(
            Icons.more_vert,
            color: common_606060,
          ),
        ],
        backgroundColor: common_fafafa,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          buildHeader(),
          Divider(color: common_606060),
        ],
      ),
    );
  }

  buildHeader() {
    return SizedBox(
      height: 240,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              radius: 48,
              child: Text("NAME"),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 16),
              child: Text(
                "Juhezi",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Juhezix@163.com",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down)
              ],
            )
          ],
        ),
      ),
    );
  }
}
