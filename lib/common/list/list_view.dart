import 'package:flutter/cupertino.dart';
import 'package:ledger/common/list/adapter_manager.dart';

class LokiListView extends StatefulWidget {
  PageScene currentScene = PageScene.LIST;
  AdapterManager adapterManager;
  IndexedWidgetBuilder separatorBuilder;
  bool autoEmpty;

  LokiListView(this.adapterManager,
      {this.currentScene = PageScene.LIST,
      this.separatorBuilder,
      this.autoEmpty = true});

  @override
  State<StatefulWidget> createState() {
    return _LokiState(
        adapterManager, currentScene, separatorBuilder, autoEmpty);
  }
}

class _LokiState extends State<LokiListView> {
  PageScene currentScene;
  AdapterManager adapterManager;
  IndexedWidgetBuilder separatorBuilder;
  bool autoEmpty;

  _LokiState(this.adapterManager, this.currentScene, this.separatorBuilder,
      this.autoEmpty) {
    adapterManager.state = this;
  }

  set scene(PageScene scene) {
    currentScene = scene;
  }

  @override
  Widget build(BuildContext context) {
    if (autoEmpty) {
      // 根据列表数据自动判断是否显示空页面
      if (adapterManager.isEmpty()) {
        return buildEmptyPage();
      }
    }

    switch (currentScene) {
      case PageScene.LIST:
        return buildList();
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

  buildEmptyPage() => Text("empty");

  buildLoadingPage() => Text("Loading");

  buildErrorPage() => Text("Error");

  buildNoNetPage() => Text("No Net");

  buildList() => separatorBuilder == null
      ? ListView.builder(
          itemBuilder: adapterManager.buildListItem,
          itemCount: adapterManager.size(),
        )
      : ListView.separated(
          itemBuilder: adapterManager.buildListItem,
          separatorBuilder: separatorBuilder,
          itemCount: adapterManager.size());
}

enum PageScene {
  LIST,
  EMPTY,
  LOADING,
  ERROR,
  NO_NET,
}
