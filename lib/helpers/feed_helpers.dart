import 'package:intl/intl.dart';

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

  static bool isExpired(String rawExpDate) {
    if (rawExpDate == null) return false;
    DateTime expDate = _parseExpiryDate(rawExpDate);
    if (expDate.difference(DateTime.now()).inDays < 0) return true;
    return false;
  }

  static String getExpiryDaysLeft(String rawExpDate) {
    DateTime _expDate = _parseExpiryDate(rawExpDate);
    int _daysDifference = _expDate.difference(DateTime.now()).inDays;

    if (_daysDifference > 1)
      return 'EXPIRES IN ${_daysDifference.toString()} DAYS';
    if (_daysDifference > 0)
      return 'EXPIRES TOMORROW';
    return 'EXPIRES TODAY';
  }

  static String getFeedPageDate(String rawDate) {
    DateTime _date = _parseDate(rawDate);
    return DateFormat('dd MMMM y').format(_date).toString();
  }

  static String getFeedItemDate(String rawDate) {
    DateTime _date = _parseDate(rawDate);
    int _dayDifference = _date.difference(DateTime.now()).inDays;
    if (_dayDifference == -1) return 'Yesterday';
    if (_dayDifference < -1)
      return '${_dayDifference.abs().toString()} Days ago';
    return DateFormat('jm').format(_date).toString();
  }

  static DateTime _parseExpiryDate(String rawExpDate) {
    // Given date fromat is "2019-08-19T00:00:00+12:00"
    final String rawExpDateSubstring = rawExpDate.substring(0, 10);
    return DateTime.parse(rawExpDateSubstring);
  }

  static DateTime _parseDate(String rawDate) {
    String dateString = '';
    // Given date fromat is "Sun, 18 Aug 2019 13:53:11 +1200"
    final List<String> rawDateSplit = rawDate.split(' ');
    dateString = rawDateSplit[3] +
        '-' +
        _getNumeralMonthFromString(rawDateSplit[2]) +
        '-' +
        rawDateSplit[1] +
        ' ' +
        rawDateSplit[4];
    return DateTime.parse(dateString);
  }

  static String _getNumeralMonthFromString(String month) {
    switch (month) {
      case 'Jan':
        return '01';
      case 'Feb':
        return '02';
      case 'Mar':
        return '03';
      case 'Apr':
        return '04';
      case 'May':
        return '05';
      case 'Jun':
        return '06';
      case 'Jul':
        return '07';
      case 'Aug':
        return '08';
      case 'Sep':
        return '09';
      case 'Oct':
        return '10';
      case 'Nov':
        return '11';
      default:
        return '12';
    }
  }
}
