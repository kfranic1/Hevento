import 'package:hevento/services/extensions/string_extension.dart';

class Configuration {
  final String? pathName;
  final Map<String, String>? pathParams;

  Configuration.home()
      : pathName = null,
        pathParams = null;

  Configuration.otherPage(this.pathName) : pathParams = pathName!.paramsFromUrl();

  bool get isHomePage => pathName == null;
  bool get isOtherPage => pathName != null;

  @override
  String toString() {
    return (pathName ?? '') + '__' + (pathParams.toString());
  }
}
