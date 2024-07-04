import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joola/src/components/list_button.dart';
import 'package:joola/src/components/settings_popup.dart';
import 'package:joola/src/utils/utils.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({
    super.key
  });

  Future<void> updateName(BuildContext context, List<TextEditingController> controllers) async {
    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(controllers.last.text);
      Navigator.pop(context);
      Utils.showErrorMessage(context, 'Updated name');
    } on FirebaseAuthException catch (e) {
      Utils.showErrorMessage(context, e.code);
    }
  }

  Future<void> updateEmail(BuildContext context, List<TextEditingController> controllers) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: controllers.first.text);
      await user.reauthenticateWithCredential(credential);
      await user.verifyBeforeUpdateEmail(controllers.last.text);
      Navigator.pop(context);
      Utils.showErrorMessage(context, 'Send email verification link');
    } on FirebaseAuthException catch (e) {
      Utils.showErrorMessage(context, e.code);
    }
  }

  Future<void> updatePassword(BuildContext context, List<TextEditingController> controllers) async {
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(controllers.last.text);
      Navigator.pop(context);
      Utils.showErrorMessage(context, 'Updated password');
    } on FirebaseAuthException catch (e) {
      Utils.showErrorMessage(context, e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(Utils.weekStamp(DateTime.now()));
    print(Utils.weekDate(Utils.weekStamp(DateTime.now())));
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Account',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ListButton(
            texts: const [
              'Edit Profile',
              'Update Email',
              'Update Password'
            ],
            icons: const [
              Icon(Icons.manage_accounts_rounded, color: Color.fromARGB(255, 250, 150, 258), size: 35),
              Icon(Icons.email, color: Color(0xFFDC729D), size: 35),
              Icon(Icons.key_rounded, color: Color(0xFF20AD6E), size: 35)
            ],
            actions: [
              () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SettingsPopup(
                      texts: const ['Name'],
                      obscures: const [false],
                      action: updateName
                    );
                  }
                );
              },
              () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SettingsPopup(
                      texts: const ['Password', 'Email'],
                      obscures: const [true, false],
                      action: updateEmail
                    );
                  }
                );
              },
              () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SettingsPopup(
                      texts: const ['Old Password', 'New Password', 'Confirm New Password'],
                      obscures: const [true, true, true],
                      action: updatePassword
                    );
                  }
                );
              },
            ]
          ),
        )
      ],
    );
  }
}