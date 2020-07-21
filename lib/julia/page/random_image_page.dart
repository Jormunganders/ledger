import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ledger/common/page/image_show_page.dart';
import 'package:ledger/julia/net/net_constant.dart';

class RandomImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomImageState();
}

class _RandomImageState extends State<RandomImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          tooltip: "刷新",
          onPressed: () => setState(() {
            print("刷新");
          }),
        ),
        body: Center(child: ImageShowPage(RANDOM_TAOBAO_IMAGE_URL)));
  }
}
