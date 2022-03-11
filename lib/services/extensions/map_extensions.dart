extension MapExt on Map<String, String>? {
  String toStringFromParams() {
    if (this == null) return '';
    List<String> ret = [];
    this!.forEach((key, value) => ret.add("$key=$value"));
    return '?' + ret.join('&');
  }
}
