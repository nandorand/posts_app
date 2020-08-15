import 'package:flutter/material.dart';
import 'package:posts_app/core/business_logic/view_models/base_view_model.dart';
import 'package:posts_app/core/business_logic/view_models/favorites_screen.dart';
import 'package:posts_app/core/services/service_locator.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  FavoriteScreenViewModel model = serviceLocator<FavoriteScreenViewModel>();

  @override
  void initState() {
    model.loadData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteScreenViewModel>(
      create: (context) => model,
      child: Consumer<FavoriteScreenViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Favorite Posts"),
          ),
          body: model.state == ViewState.completed
              ? _buildFavoritePosts(model)
              : Align(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  Widget _buildFavoritePosts(FavoriteScreenViewModel model) {
    print(model.favoritePosts.length);
    return ListView.builder(
        itemCount: model.favoritePosts.length,
        itemBuilder: (context, index) {
          FavoritePostsPresentation post = model.favoritePosts[index];
          print(model.favoritePosts.length);
          return Card(
            child: ListTile(
              title: Text(post.title),
              trailing: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  model.removeFromFavorite(post.postId);
                },
              ),
            ),
          );
        });
  }
}
