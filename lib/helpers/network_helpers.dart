import 'package:url_launcher/url_launcher.dart';

class NetworkHelpers {
  static launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // TODO(json469): Doesn't seem to work on iOS?
  static sendEmail(String address) async {
    if (await canLaunch('mailto:$address')) {
      await launch('mailto:$address');
    } else {
      throw 'Could not launch mailto:$address';
    }
  }
}
