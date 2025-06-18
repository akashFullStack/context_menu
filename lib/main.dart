import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:smart_context_menu/app/modules/home/view/home_view.dart';
import 'package:universal_html/html.dart' as html;

void main() {
  if (kIsWeb) {
    html.document.onContextMenu.listen((event) => event.preventDefault());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomeView());
  }
}






