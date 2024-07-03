import 'package:flutter/material.dart';
import 'package:joola/src/components/list_button.dart';
import 'package:joola/src/components/settings_popup.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({
    super.key
  });

  void updateName(TextEditingController controller) {

  }

  @override
  Widget build(BuildContext context) {
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
                      actions: [updateName]
                    );
                  }
                );
              },
              null,
              null
            ]
          ),
        )
      ],
    );
  }
}