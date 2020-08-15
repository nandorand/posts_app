import 'package:get_it/get_it.dart';
import 'package:posts_app/core/business_logic/view_models/all_posts_screen.dart';
import 'package:posts_app/core/business_logic/view_models/favorites_screen.dart';
import 'package:posts_app/core/business_logic/view_models/post_detail_screen.dart';
import 'package:posts_app/core/services/posts/posts_service.dart';
import 'package:posts_app/core/services/posts/posts_service_impl.dart';
import 'package:posts_app/core/services/web/web_api.dart';
import 'package:posts_app/core/services/web/web_api_impl.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<WebApi>(() => WebApiImpl());
  serviceLocator.registerLazySingleton<PostsService>(() => PostsServiceImpl());

  // register views models as factory...this will instatiate new ones when called
  serviceLocator.registerFactory<AllPostsScreenViewModel>(
      () => AllPostsScreenViewModel());

  serviceLocator.registerFactory<PostDetailScreenViewModel>(
      () => PostDetailScreenViewModel());

  serviceLocator.registerFactory<FavoriteScreenViewModel>(
      () => FavoriteScreenViewModel());
}
