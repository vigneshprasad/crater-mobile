/// Returns a [String] which will be the unicode of a Flag Emoji,
/// from a country [countryCode] passed as a parameter.
String generateFlagEmojiUnicode(String countryCode) {
  const base = 127397;

  return countryCode.codeUnits
      .map((e) => String.fromCharCode(base + e))
      .toList()
      .reduce((value, element) => value + element)
      .toString();
}
