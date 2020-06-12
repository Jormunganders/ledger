import 'dart:async';

import 'package:flutter/cupertino.dart';

typedef void OnItemClickListener<T>(int index, T data);

typedef Widget OnBuildView<T>(int index, T data);

class BannerView<T> extends StatefulWidget {
  int duration = 3000; // 间隔时间
  final List<T> data = [];

  final OnItemClickListener<T> onItemClickListener;
  final OnBuildView<T> onBuildView;

  BannerView({
    Key key,
    @required this.onBuildView,
    this.onItemClickListener,
    List<T> data,
    this.duration,
  }) : super(key: key) {
    if (data != null) {
      this.data.addAll(data);
    }
  }

  @override
  State<StatefulWidget> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  PageController controller = PageController(); // ? 有什么作用
  Timer timer;
  int index = 0; // 当前真实索引

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  @override
  Widget build(BuildContext context) {
    // todo 
  }

  void resetTimer() {
    clearTimer();
    timer = new Timer.periodic(new Duration(milliseconds: widget.duration),
        (timer) {
      if (widget.data.length > 0 &&
          controller != null &&
          controller.page != null) {
        int page = controller.page.toInt() + 1;
        controller.animateToPage(page,
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    });
  }

  void clearTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }
}
