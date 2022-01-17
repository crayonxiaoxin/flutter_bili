import 'package:flutter_bili/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> topProviders = [
  Provider(create: (_) {
    return ThemeProvider();
  })
];
