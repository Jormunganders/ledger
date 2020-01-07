import 'package:flutter/widgets.dart';

class AdapterManager {
  var datas = [];
  List<Delegate> delegates = [];

  size() => datas.length;

  edit() => new Editor(datas);

  Widget buildListItem(BuildContext context, int index) {
    var item = datas[index];
    // 判断类型
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

/**
 * D -> 数据类型
 * V -> ViewHolder 类型
 */
class Delegate<D, V> {
  isForType(D data, int position) => true;

  V getHolder() {
    return null;
  }

}

// 继承这个
class ViewHolder<T> {
  Widget build(T data, int position) {
    return null;
  }
}
