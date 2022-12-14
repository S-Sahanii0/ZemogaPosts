import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posts_api_client/posts_api_client.dart';
import 'package:posts_repository/posts_repository.dart';
import 'package:zemoga_posts/features/posts/cubit/post_cubit.dart';
import 'package:zemoga_posts/features/posts/view/pages/home_page.dart';
import 'package:zemoga_posts/features/posts/view/widgets/tab_view.dart';

import '../../../helpers/helpers.dart';

class MockPostCubit extends Mock implements PostCubit {}

class MockPostRepository extends Mock implements PostsRepository {}

final posts = List.generate(
  2,
  (index) => Post(
    userId: index,
    id: index,
    title: 'Test Title',
    body: 'Test description of the post',
  ),
);

void main() {
  group('PostsListPage', () {
    late MockPostRepository _postRepository;
    late MockPostCubit _postCubit;

    setUp(() {
      _postRepository = MockPostRepository();
      _postCubit = MockPostCubit();
      when(() => _postRepository.getAllPosts())
          .thenAnswer((_) async => const Result.success([]));
      when(() => _postRepository.getAllFavoritePosts())
          .thenAnswer((_) => const Result.success([]));
      when(() => _postCubit.getAllPosts()).thenAnswer(
        (_) async => PostState.success(posts: posts, favoritePosts: posts),
      );
      when(() => _postCubit.getAllFavoritePosts()).thenAnswer(
        (_) => PostState.success(posts: posts, favoritePosts: posts),
      );
    });

    testWidgets('renders app tab view', (tester) async {
      when(() => _postCubit.stream).thenAnswer(
        (_) => Stream.fromIterable(
          [PostState.success(posts: posts, favoritePosts: posts)],
        ),
      );
      when(() => _postCubit.state).thenAnswer(
        (_) => PostState.success(posts: posts, favoritePosts: posts),
      );
      await tester.pumpAppWithDependencies(
        const HomePage(),
        cubit: _postCubit,
        repository: _postRepository,
      );

      expect(find.byType(AppTabView), findsOneWidget);
    });
  });
}
