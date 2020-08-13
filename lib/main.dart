import 'package:flutter/material.dart';
import 'package:posts_app/core/services/service_locator.dart';
import 'package:posts_app/ui/views/all_posts_screen.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: AllPostsScreen(),
    );
  }
}
