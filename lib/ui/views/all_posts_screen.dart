import 'package:flutter/material.dart';
import 'package:posts_app/core/business_logic/view_models/all_posts_screen.dart';
import 'package:posts_app/core/services/service_locator.dart';
import 'package:provider/provider.dart';

class AllPostsScreen extends StatefulWidget {
  @override
  _AllPostsScreenState createState() => _AllPostsScreenState();
}

class _AllPostsScreenState extends State<AllPostsScreen> {
  AllPostsScreenViewModel model = serviceLocator<AllPostsScreenViewModel>();

  // if text editing controller is required...then instatiate it here

  @override
  void initState() {
    model.loadData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllPostsScreenViewModel>(
      create: (context) => model,
      child: Consumer<AllPostsScreenViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Post App"),
            actions: [IconButton(icon: Icon(Icons.favorite), onPressed: () {})],
          ),
          body: Column(
            children: [
              Text(
                "Hello, The posts for today..",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              model.state == ViewState.completed
                  ? postList(model)
                  : Align(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  Expanded postList(AllPostsScreenViewModel model) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(model.posts[index].title),
              onTap: () {},
              trailing: IconButton(
                  icon: Icon(Icons.favorite_border), onPressed: () {}),
            ),
          );
        },
        itemCount: model.posts.length,
      ),
    );
  }
}
