import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledger/common/list/adapter_manager.dart';
import 'package:provider/provider.dart';

import 'list_view.dart';

typedef void OnItemClickListener<T>(int index, T data);

typedef Widget OnBuildIndicatorItem(int index, bool isSelect);

const DEFAULT_INDICATOR_WIDTH = 8.0;
const DEFAULT_INDICATOR_HEIGHT = 8.0;

// 默认的指示器，小圆点
// ignore: non_constant_identifier_names
final OnBuildIndicatorItem DEFAULT_INDICATOR_BUILDER =
    (int index, bool isSelect) => Container(
          width: DEFAULT_INDICATOR_WIDTH,
          height: DEFAULT_INDICATOR_HEIGHT,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: isSelect ? Colors.red : Colors.blueAccent,
          ),
        );

// 默认的 Item 显示
// ignore: non_constant_identifier_names
final DEFAULT_ITEM_BUILDER = (int index, dynamic data) => Container(
      child: Image.asset(
        "graphics/image_error.png",
        fit: BoxFit.contain,
      ),
    );

class BannerView extends StatefulWidget {
  int duration; // 间隔时间
  final double height; // Banner 高度
  final bool reusable; // 指示器是否可复用

  final OnBuildIndicatorItem onBuildIndicatorItem;

  BannerView({
    Key key,
    this.onBuildIndicatorItem,
    this.height = 192.0,
    this.duration = 3000,
    this.reusable = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  PageController controller = PageController(); // ? 有什么作用
  Timer timer;
  int _index = 0; // 当前真实索引
  bool isEmpty;

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdapterManager>(
      builder: (context, adapter, _) {
        isEmpty = adapter.isEmpty();
        return SizedBox(
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildBanner(adapter),
              Align(
                alignment: Alignment.bottomCenter,
                child: _renderIndicator(adapter),
              )
            ],
          ),
        );
      },
    );
  }

  void resetTimer() {
    clearTimer();
    timer = new Timer.periodic(new Duration(milliseconds: widget.duration),
        (timer) {
      if (!isEmpty && controller != null && controller.page != null) {
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

  // 构建轮播图
  Widget _buildBanner(AdapterManager adapterManager) {
    return GestureDetector(
      onTapDown: (details) => clearTimer(),
      onTapUp: (details) => resetTimer(),
      onTapCancel: () => resetTimer(),
      child: adapterManager.isEmpty()
          ? DEFAULT_ITEM_BUILDER(-1, null)
          : _buildViewPager(adapterManager),
    );
  }

  Widget _buildViewPager(AdapterManager adapterManager) {
    return PageView.builder(
      itemBuilder: (context, index) {
        var position = index % adapterManager.size();
        return Center(
          child: adapterManager.buildListItem(context, position,
              defaultBuilder: DEFAULT_ITEM_BUILDER),
        );
      },
      controller: controller,
      physics: const PageScrollPhysics(parent: const ClampingScrollPhysics()),
      onPageChanged: (index) {
        setState(() {
          // 计算真实索引
          _index = index % adapterManager.size();
        });
      },
      itemCount: 0x7fffffff, // 保证无限循环
    );
  }

  // 自定义指示器
  Widget _renderIndicator(AdapterManager adapterManager) {
    return IndicatorWidget(
      size: adapterManager.size(),
      currentIndex: _index,
      onBuildIndicatorItem:
          widget.onBuildIndicatorItem ?? DEFAULT_INDICATOR_BUILDER,
      reusable: widget.reusable,
    );
  }
}

class IndicatorWidget extends StatelessWidget {
  final double indicatorMargin;
  final int size;
  final int currentIndex;
  final OnBuildIndicatorItem onBuildIndicatorItem;
  final bool reusable; // 指示器是否可复用

  IndicatorWidget({
    Key key,
    @required this.size,
    @required this.currentIndex,
    @required this.onBuildIndicatorItem,
    this.reusable = true,
    this.indicatorMargin = 5.0,
  })  : assert(indicatorMargin != null),
        assert(size >= 0),
        assert(currentIndex != null && currentIndex >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _renderIndicator(context);
  }

  Widget _renderIndicator(BuildContext context) {
    Widget smallContainer = new Container(
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: _renderIndicatorTag(),
      ),
    );
    return new Align(
      alignment: Alignment.bottomCenter,
      child: new Opacity(
        opacity: 0.5,
        child: new Container(
          height: 25,
          padding: new EdgeInsets.symmetric(horizontal: 16.0),
          alignment: Alignment.center,
          child: smallContainer,
        ),
      ),
    );
  }

  ///构建Banner指示器
  List<Widget> _renderIndicatorTag() {
    if (size == 0) {
      return [];
    }
    List<Widget> indicators = [];
    final int len = this.size;

    if (reusable) {
      Widget selected = onBuildIndicatorItem(-1, true);
      Widget normal = onBuildIndicatorItem(-1, false);

      for (var index = 0; index < len; index++) {
        indicators.add(index == this.currentIndex ? selected : normal);
        if (index != len - 1) {
          indicators.add(new SizedBox(
            width: this.indicatorMargin,
          ));
        }
      }
    } else {
      for (var index = 0; index < len; index++) {
        indicators.add(onBuildIndicatorItem(index, index == this.currentIndex));
        if (index != len - 1) {
          indicators.add(new SizedBox(
            width: this.indicatorMargin,
          ));
        }
      }
    }
    return indicators;
  }
}

abstract class BaseBannerState<T extends StatefulWidget> extends State<T> {
  String mKey;
  AdapterManager mAdapterManager;

  BaseBannerState(
    AdapterManagerClosure closure, {
    String key,
  }) {
    this.mKey = key;
    mAdapterManager = AdapterManager(key);
    closure(mAdapterManager);
  }

  // 修改布局重写这个方法
  Widget internalBuild(BuildContext context) {
    return buildBannerView();
  }

  buildBannerView() {
    return BannerView();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdapterManager>.value(
      value: mAdapterManager,
      child: internalBuild(context),
    );
  }
}
