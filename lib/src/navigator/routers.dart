
import '../../app.dart';

class Routes {
static const String splash = '/splash';
static const String loginRoute = '/login';
static const String otpRoute = '/code_entry';
static const String qrRoute = '/qr_entry';
static const String homeRoute = '/addtochat';
static const String chatRoute = '/chatsceens';
static const String logoutRoute = '/logout';
  static const String initRoute = '/splash';
static const String checkLogin = '/checklogin';



}
class NavigationService {
  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }
}
