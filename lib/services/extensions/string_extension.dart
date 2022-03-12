extension StringExt on String {
  Map<String, String>? paramsFromUrl() {
    if (!contains('?')) return null;
    Map<String, String>? ret = {};
    List<String> pairs = substring(indexOf('?') + 1).split('&');
    for (String x in pairs) {
      List<String> temp = x.split('=');
      ret[temp[0]] = temp[1];
    }
    return ret;
  }

  String removeParams() {
    if (!contains('?')) return this;
    return substring(0, indexOf('?'));
  }
}
