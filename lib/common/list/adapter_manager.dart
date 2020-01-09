import 'package:flutter/widgets.dart';

class AdapterManager {
  var _dataList = [];
  List<Delegate> _delegates = [];

  State _state;

  set state(State state) {
    this._state = state;
  }

  size() => _dataList.length;

  isEmpty() => _dataList.isEmpty;

  edit() => new Editor(_dataList, _state);

  Widget buildListItem(BuildContext context, int position) {
    var item = _dataList[position];

    Delegate selectDelegate;

    // 判断类型
    _delegates.forEach((Delegate delegate) {
      if (item.runtimeType == delegate.getType()) {
        if (delegate.isForType(item, position)) {
          selectDelegate = delegate;
        }
      }
    });

    if (selectDelegate == null) {
      throw new Exception("没有找到对应的 Delegate");
    }

    return selectDelegate.getHolder().build(context, item, position);
  }

  registerDelegate(Delegate delegate) {
    _delegates.add(delegate);
  }
}

class Editor {
  List data;

  State state;

  Editor(this.data, this.state);

  Editor add(dynamic item) {
    data.add(item);
    return this;
  }

  Editor addAll(List list) {
    data.addAll(list);
    return this;
  }

  Editor clear() {
    data.clear();
    return this;
  }

  commit() {
    // ignore: invalid_use_of_protected_member
    state.setState(() {});
  }
}

abstract class Delegate<D, V extends ViewHolder<D>> {
  isForType(D data, int position) => true;

  Type getType() {
    return D;
  }

  V getHolder();
}

abstract class ViewHolder<T> {
  Widget build(BuildContext context, T data, int position);
}
