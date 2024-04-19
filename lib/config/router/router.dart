
import 'package:go_router/go_router.dart';
import 'package:pneumonia_detection/features/home/presentation/screens/screens.dart';
import 'package:pneumonia_detection/features/login/presentation/screens/screens.dart';
import 'package:pneumonia_detection/features/pneumonia/presentation/screens/screens.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {

  return GoRouter(
    initialLocation: LoginScreen.routeName,
    routes: [
      GoRoute(
        path: LoginScreen.routeName,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: HomeScreen.routeName,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: UploadRadiographyScreen.routeName,
        builder: (context, state) => const UploadRadiographyScreen(),
      ),
      GoRoute(
        path: PneumoniaDetecionDetailsScreen.routeName,
        builder: (context, state) => const PneumoniaDetecionDetailsScreen(),
      ),
      GoRoute(
        path: SignUpScreen.routeName,
        builder: (context, state) => SignUpScreen(),
      ),
    ]
  );
}
