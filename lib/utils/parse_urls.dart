mixin ParseUrls {
  static List<String> getLinksList(String value) {
    final _urlRegex = RegExp(
      r'^((?:.|\n)*?)((?:https?):\/\/[^\s/$.?#].[^\s]*)',
      caseSensitive: false,
    );
    final urlMatches = _urlRegex.allMatches(value);
    final List<String> urls = urlMatches
        .map((urlMatch) => value.substring(urlMatch.start, urlMatch.end))
        .toList();
    return urls;
  }
}
