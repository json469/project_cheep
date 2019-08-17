class FeedHelpers {
  static String getDescription(String html) {
    final RegExp _htmlTagRegExp = RegExp('<[^>]*>');
    return html.replaceAll(_htmlTagRegExp, '');
  }

  static String getTitle(String title) {
    // Given most of the store names are written after the @ symbol...
    final RegExp _atSymbolRegExp = RegExp('[@]');
    if (_atSymbolRegExp.hasMatch(title))
      return title.substring(title.indexOf(_atSymbolRegExp) + 1);
    return 'Cheep Deal';
  }
}
