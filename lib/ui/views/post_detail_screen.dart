import 'package:flutter/material.dart';
import 'package:posts_app/core/business_logic/view_models/post_detail_screen.dart';
import 'package:posts_app/core/services/service_locator.dart';
import 'package:provider/provider.dart';

class PostDetailScreen extends StatefulWidget {
  final int postId;

  PostDetailScreen({this.postId});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  PostDetailScreenViewModel model = serviceLocator<PostDetailScreenViewModel>();

  @override
  void initState() {
    model.loadData(widget.postId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return ChangeNotifierProvider<PostDetailScreenViewModel>(
      create: (context) => model,
      child: Consumer<PostDetailScreenViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Post App"),
            actions: [IconButton(icon: Icon(Icons.favorite), onPressed: () {})],
          ),
          body: Column(
            children: [
              model.postState == PostDetailViewState.completed
                  ? buildPostTitle(model)
                  : Align(
                      child: CircularProgressIndicator(),
                    ),
              model.postState == PostDetailViewState.completed
                  ? buildUserInfo(model)
                  : Align(
                      child: CircularProgressIndicator(),
                    ),
              model.commentState == PostDetailViewState.completed
                  ? buildComments(model)
                  : Align(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPostTitle(PostDetailScreenViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        model.post.postTitle,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildUserInfo(PostDetailScreenViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "Posted by user : ${model.post.userId.toString()}",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget buildComments(PostDetailScreenViewModel model) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(model.comments[index].name),
            subtitle: Text(model.comments[index].body),
          );
        },
        itemCount: model.comments.length,
      ),
    );
  }
}
