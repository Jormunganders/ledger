import 'package:flutter/cupertino.dart';

class LokiListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LokiState(PageState.CONTENT);
  }
}

class _LokiState extends State<LokiListView> {
  PageState currentState;

  _LokiState(this.currentState);

  @override
  Widget build(BuildContext context) {
    switch (currentState) {
      case PageState.CONTENT:
        return ListView();
      case PageState.EMPTY:
        return Text("empty");
      case PageState.LOADING:
        return Text("loading");
      case PageState.ERROR:
        return Text("error");
      case PageState.NO_NET:
        return Text("no_net");
    }
  }
}

enum PageState {
  CONTENT,
  EMPTY,
  LOADING,
  ERROR,
  NO_NET,
}
