abstract class Routes {
  static const String home = "";
  static const String partner = "partner";
  static const String test = "partner/test";

  void goToHome() {}

  void goToPartner({Map<String, String>? params}) {}

  void goToTest({Map<String, String>? params}) {}
}
