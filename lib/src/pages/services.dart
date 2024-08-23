import 'package:flutter/material.dart';
import 'package:joola/src/components/page_title.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: const [
            PageTitle(
              text: 'Services',
            ),
            SizedBox(height: 30),
          ]
        ),
      )
    );
  }
}