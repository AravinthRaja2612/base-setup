

import 'package:auto_route/auto_route.dart';
import 'package:flutter_learn/application/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    CupertinoRoute(page: SplashRoute.page, path: '/',initial: true,keepHistory: true,),

    CupertinoRoute(page: LoginRoute.page, path: '/login_screen',keepHistory: true,),
    CupertinoRoute(page: ChatRoomRoute.page, path: '/chat_room_screen',keepHistory: true,),
    CupertinoRoute(page: DashboardRoute.page, path: '/dashboard_screen',keepHistory: true,
    children: [
      CupertinoRoute(page: HomeRoute.page, path: 'home_screen',keepHistory: true,initial: true),
      CupertinoRoute(page: ChatRoute.page, path: 'chat_screen',keepHistory: true,),
      CupertinoRoute(page: SettingRoute.page, path: 'setting_screen',keepHistory: true,),
    ]),


  ];
}