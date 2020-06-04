import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledger/common/list/adapter_manager.dart';
import 'package:ledger/common/page/common_page.dart';
import 'package:provider/provider.dart';

class LokiListView extends StatefulWidget {
  PageScene currentScene;
  IndexedWidgetBuilder separatorBuilder;
  bool autoEmpty;
  bool autoCrossAxisCount; // 自动计算网格布局的列数
  int crossAxisCount; // 网格布局的列数
  bool gridLayout; // 使用网格布局

  LokiListView(
      {this.currentScene = PageScene.LIST,
      this.separatorBuilder,
      this.autoEmpty = true,
      this.autoCrossAxisCount = false,
      this.crossAxisCount = 2,
      this.gridLayout = false});

  @override
  State<StatefulWidget> createState() {
    return _LokiState(currentScene, separatorBuilder, autoEmpty,
        autoCrossAxisCount, crossAxisCount, gridLayout);
  }
}

class _LokiState extends State<LokiListView> {
  // 要在这个时候创建 AdapterManager，因为 hot reload 的时候，只有 state 不会重新创建

  PageScene currentScene;
  IndexedWidgetBuilder separatorBuilder;
  bool autoEmpty;
  bool autoCrossAxisCount;
  int crossAxisCount;
  bool gridLayout;

  _LokiState(this.currentScene, this.separatorBuilder, this.autoEmpty,
      this.autoCrossAxisCount, this.crossAxisCount, this.gridLayout);

  set scene(PageScene scene) {
    currentScene = scene;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdapterManager>(
      builder: (context, adapterManager, _) =>
          internalBuild(context, adapterManager),
    );
  }

  Widget internalBuild(BuildContext context, AdapterManager adapterManager) {
    switch (currentScene) {
      case PageScene.LIST:
        if (autoEmpty) {
          // 根据列表数据自动判断是否显示空页面
          if (adapterManager.isEmpty()) {
            return buildEmptyPage();
          }
        }
        return buildList(adapterManager);
      case PageScene.EMPTY:
        return buildEmptyPage();
      case PageScene.LOADING:
        return buildLoadingPage();
      case PageScene.ERROR:
        return buildErrorPage();
      case PageScene.NO_NET:
        return buildNoNetPage();
    }
    return buildErrorPage();
  }

  buildEmptyPage() => EmptyPage();

  buildLoadingPage() =>
      SpinKitRotatingPlain(color: Theme.of(context).accentColor);

  // todo
  buildErrorPage() => ErrorPage(
        onPress: () => print("重新加载"),
      );

  // todo
  buildNoNetPage() => NoNetPage(
        onPress: () => print("刷新"),
      );

  int _crossAxisCount() {
    return crossAxisCount;
  }

  buildList(AdapterManager adapterManager) {
    if (gridLayout) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
        itemBuilder: adapterManager.buildListItem,
        itemCount: adapterManager.size(),
      );
    } else {
      if (separatorBuilder == null) {
        return ListView.builder(
          itemBuilder: adapterManager.buildListItem,
          itemCount: adapterManager.size(),
        );
      } else {
        return ListView.separated(
            itemBuilder: adapterManager.buildListItem,
            separatorBuilder: separatorBuilder,
            itemCount: adapterManager.size());
      }
    }
  }
}

enum PageScene {
  LIST,
  EMPTY,
  LOADING,
  ERROR,
  NO_NET,
}

abstract class BaseLokiListState<T extends StatefulWidget> extends State<T> {
  String mKey;
  AdapterManager mAdapterManager;

  BaseLokiListState(
    AdapterManagerClosure closure, {
    String key,
  }) {
    this.mKey = key;
    mAdapterManager = AdapterManager(key);
    closure(mAdapterManager);
  }

  // 修改布局重写这个方法
  Widget internalBuild(BuildContext context) {
    return buildLokiListView();
  }

  buildLokiListView() {
    return LokiListView(
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdapterManager>.value(
      value: mAdapterManager,
      child: internalBuild(context),
    );
  }
}

typedef AdapterManagerClosure = void Function(AdapterManager adapterManager);
