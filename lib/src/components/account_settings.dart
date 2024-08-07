import 'package:cloud_firestore/cloud_firestore.dart';
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
      String uuid = FirebaseAuth.instance.currentUser!.uid;
      final db = FirebaseFirestore.instance;
      final docRef = db.collection('Users').doc(uuid);
      final firstName = controllers.first.text;
      final lastName = controllers.last.text;
      docRef.set({'first_name': firstName, 'last_name': lastName}, SetOptions(merge: true));
      Navigator.pop(context);
      Utils.showErrorMessage(context, 'Updated name');
    } catch (e) {
      Utils.showErrorMessage(context, e.toString());
    }
  }

  Future<void> updateEmail(BuildContext context, List<TextEditingController> controllers) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: controllers.first.text);
      await user.reauthenticateWithCredential(credential);
      await user.verifyBeforeUpdateEmail(controllers.last.text);
      Navigator.pop(context);
      Utils.showErrorMessage(context, 'Sent email verification link');
    } on FirebaseAuthException catch (e) {
      Utils.showErrorMessage(context, e.code);
    }
  }

  Future<void> updatePassword(BuildContext context, List<TextEditingController> controllers) async {
    try {
      if (controllers[1].text != controllers.last.text) {
        Utils.showErrorMessage(context, 'New passwords do not match');
        return;
      }

      User user = FirebaseAuth.instance.currentUser!;
      AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: controllers.first.text);
      await user.reauthenticateWithCredential(credential);
      await FirebaseAuth.instance.currentUser!.updatePassword(controllers.last.text);
      Navigator.pop(context);
      Utils.showErrorMessage(context, 'Updated password');
    } on FirebaseAuthException catch (e) {
      Utils.showErrorMessage(context, e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> titles = ['Edit Profile', 'Update Email', 'Update Password'];
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
            texts: titles,
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
                      title: titles[0],
                      texts: const ['First Name', 'Last Name'],
                      obscures: const [false, false],
                      keyboardTypes: const [TextInputType.text, TextInputType.text],
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
                      title: titles[1],
                      texts: const ['Password', 'Email'],
                      obscures: const [true, false],
                      keyboardTypes: const [TextInputType.text, TextInputType.emailAddress],
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
                      title: titles[2],
                      texts: const ['Old Password', 'New Password', 'Confirm New Password'],
                      obscures: const [true, true, true],
                      keyboardTypes: const [TextInputType.text, TextInputType.text, TextInputType.text],
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