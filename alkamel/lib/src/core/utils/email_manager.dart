// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alkamel/generated/l10n.dart';
import 'package:alkamel/src/core/constants/constant.dart';
import 'package:alkamel/src/core/functions/open_url.dart';
import 'package:alkamel/src/core/models/email.dart';

class EmailManager {
  static void messageUS() {
    sendEmail(
      email: Email(
        subject: S.current.chat,
        body: '',
      ),
    );
  }

  static void sendMisspelled({
    required String title,
    required String zikrId,
    required String zikrBody,
  }) {
    sendEmail(
      email: Email(
        subject: S.current.misspelled,
        body: '''


''',
      ),
    );
  }

  static Future<void> sendEmail({
    required Email email,
  }) async {
    final emailToSend = email.copyWith(
      subject: "${S.current.appTitle} | ${email.subject} | v$kAppVersion",
    );

    final uri = emailToSend.getURI;

    openURL(uri);
  }
}
