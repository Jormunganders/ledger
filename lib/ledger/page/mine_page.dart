import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ledger/common/colors.dart';
import 'package:ledger/common/develop.dart';
import 'package:ledger/common/strings.dart';
import 'package:ledger/reader/page/reader_host_page.dart';

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
          _buildMorePopupMenuButton(context),
        ],
        backgroundColor: common_fafafa,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          _buildHeader(),
          Divider(color: common_606060),
        ],
      ),
    );
  }

  _buildHeader() {
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
            Container(
              height: 36,
              padding: EdgeInsets.only(left: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Juhezix@163.com",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: common_606060,
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: common_606060,
                      size: 18,
                    ),
                    margin: EdgeInsets.only(left: 8, right: 10),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: new Border.all(color: common_606060, width: 0.5),
                borderRadius: new BorderRadius.circular((18.0)),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 设置按钮
  _buildMorePopupMenuButton(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) {
        var result = [
          PopupMenuItem<String>(
            value: SETTINGS,
            child: Text('设置'),
          ),
          PopupMenuItem<String>(
            value: HELP,
            child: Text('帮助与反馈'),
          ),
        ];
        if (isFeatureEnable("feature_debug_mode")) {
          result
            ..add(PopupMenuItem<String>(
              value: DEVELOP,
              child: Text('调试'),
            ))
            ..add(PopupMenuItem<String>(
              value: DEMO,
              child: Text('Demo'),
            ));
        }
        return result;
      },
      onSelected: (String value) {
        switch (value) {
          case DEMO:
            Navigator.push(
              context,
              new MaterialPageRoute(builder: (context) => new ReaderHostPage()),
            );
            break;
        }
      },
      icon: Icon(
        Icons.more_vert,
        color: common_606060,
      ),
    );
  }
}

const SETTINGS = "settings";
const HELP = "help";
const DEVELOP = "develop";
const DEMO = "DEMO";
