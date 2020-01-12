import 'package:flutter/cupertino.dart';
import 'package:ledger/common/list/adapter_manager.dart';
import 'package:provider/provider.dart';

class LokiListView extends StatefulWidget {

  PageScene currentScene = PageScene.LIST;

  IndexedWidgetBuilder separatorBuilder;
  bool autoEmpty;

  LokiListView(
      {this.currentScene = PageScene.LIST,
      this.separatorBuilder,
      this.autoEmpty = true});

  @override
  State<StatefulWidget> createState() {
    return _LokiState(currentScene, separatorBuilder, autoEmpty);
  }
}

class _LokiState extends State<LokiListView> {
  // 要在这个时候创建 AdapterManager，因为 hot reload 的时候，只有 state 不会重新创建

  PageScene currentScene;
  IndexedWidgetBuilder separatorBuilder;
  bool autoEmpty;

  _LokiState(this.currentScene, this.separatorBuilder, this.autoEmpty);

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
    if (autoEmpty) {
      // 根据列表数据自动判断是否显示空页面
      if (adapterManager.isEmpty()) {
        return buildEmptyPage();
      }
    }

    switch (currentScene) {
      case PageScene.LIST:
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

  buildEmptyPage() => Text("empty");

  buildLoadingPage() => Text("Loading");

  buildErrorPage() => Text("Error");

  buildNoNetPage() => Text("No Net");

  buildList(AdapterManager adapterManager) => separatorBuilder == null
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
