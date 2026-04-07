import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailSenderHelper {
  Future<void> sendEmail(String subj) async {
    final Email email = Email(
      subject: subj,
      recipients: ['donnajun1214@gmail.com'],
    );
    await FlutterEmailSender.send(email);
  }
}
