import 'package:flutter/material.dart';
import 'package:posts_app/core/business_logic/view_models/all_posts_screen.dart';
import 'package:posts_app/core/services/service_locator.dart';
import 'package:posts_app/ui/views/favorites_screen.dart';
import 'package:posts_app/ui/views/post_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:posts_app/core/business_logic/view_models/base_view_model.dart';

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
    print("built all posts screen");
    return ChangeNotifierProvider<AllPostsScreenViewModel>(
      create: (context) => model,
      child: Consumer<AllPostsScreenViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Post App"),
            actions: [
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritesScreen(),
                    ),
                  );
                },
              )
            ],
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
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostDetailScreen(
                            postId: model.posts[index].postId)));
              },
              trailing: IconButton(
                  icon: Icon(model.posts[index].isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () async {
                    await model.toggleFavorites(model.posts[index].postId);
                  }),
            ),
          );
        },
        itemCount: model.posts.length,
      ),
    );
  }
}
