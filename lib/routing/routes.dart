abstract class Routes {
  static const String home = "";
  static const String dashboard = "dashboard";
  static const String space = "space";
  static const String login = "login";
  static const String register = "register";

  void goToHome() {}

  void goToDashboard({Map<String, String>? params}) {}

  void goToLogin({Map<String, String>? params}) {}

  void goToRegister({Map<String, String>? params}) {}

  void goToSpace({Map<String, String>? params = const {"id": "0"}}) {}
}
