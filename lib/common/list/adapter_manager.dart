import 'package:flutter/widgets.dart';

class AdapterManager {
  var datas = [];
  List<Delegate> delegates = [];

  size() => datas.length;

  edit() => new Editor(datas);

  Widget buildListItem(BuildContext context, int position) {
    var item = datas[position];

    Delegate selectDelegate;

    // 判断类型
    delegates.forEach((Delegate delegate) {
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
    delegates.add(delegate);
  }
}

class Editor {
  List data;

  Editor(this.data);

  add(dynamic item) {
    data.add(item);
  }

  addAll(List list) {
    data.addAll(list);
  }

  clear() {
    data.clear();
  }

  commit() {
//    setState
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
