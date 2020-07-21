import 'package:flutter/widgets.dart';

class ImageShowPage extends StatelessWidget {
  final String _url;

  ImageShowPage(this._url, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Image.network(
        _url,
        fit: BoxFit.contain,
      );
}
