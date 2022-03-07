class Configuration {
  final String? pathName;

  Configuration.home() : pathName = null;

  Configuration.otherPage(this.pathName);

  Configuration.unknown() : pathName = null;

  bool get isHomePage => pathName == null;
  bool get isOtherPage => pathName != null;
}
