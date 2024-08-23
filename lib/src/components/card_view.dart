import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:joola/src/utils/utils.dart';

class CardView extends StatelessWidget {
  final String image;
  final String title;
  final String name;
  final double widthPercent;
  final String rating;
  final IconData icon;
  final String text;
  final Function()? onTap;

  const CardView({
    super.key,
    required this.image,
    required this.title,
    required this.name,
    required this.widthPercent,
    required this.rating,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: AssetImage(image),
                  height: Utils.percentWidth(context, 0.45),
                  width: Utils.percentWidth(context, widthPercent),
                  fit: BoxFit.cover
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  height: Utils.percentWidth(context, 0.45),
                  width: Utils.percentWidth(context, widthPercent),
                  color: const Color.fromARGB(32, 0, 0, 0),
                ),
              ),
              Positioned(
                bottom: Utils.percentWidth(context, 0.019),
                left: Utils.percentWidth(context, 0.03),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Utils.percentWidth(context, 0.02), vertical: Utils.percentWidth(context, 0.01)),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Color.fromARGB(153, 0, 0, 0)
                  ),
                  child: Row(
                    children: [
                      Text(
                        // '4.1',
                        rating,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: Utils.percentWidth(context, 0.035)
                        )
                      ),
                      Icon(
                        Icons.bolt_sharp,
                        color: const Color(0xffffd600),
                        size: Utils.percentWidth(context, 0.045)
                      )
                    ]
                  ),
                )
              ),
              Positioned(
                bottom: Utils.percentWidth(context, 0.019),
                right: Utils.percentWidth(context, 0.03),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Utils.percentWidth(context, 0.02), vertical: Utils.percentWidth(context, 0.01)),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Color.fromARGB(153, 0, 0, 0)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        // Icons.menu_book_rounded,
                        icon,
                        color: Colors.white,
                        size: Utils.percentWidth(context, 0.045)
                      ),
                      SizedBox(
                        width: Utils.percentWidth(context, 0.02)
                      ),
                      Text(
                        // '30 Classes',
                        text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Utils.percentWidth(context, 0.035),
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    ],
                  ),
                )
              ),
              Positioned(
                top: -Utils.percentWidth(context, 0.022),
                right: Utils.percentWidth(context, 0.03),
                child: Icon(
                  Icons.bookmark_outline_rounded,
                  color: Colors.white,
                  size: Utils.percentWidth(context, 0.1),
                )
              )
            ]
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Utils.percentWidth(context, 0.045),
                ),
              ),
            ),
          ),
          SizedBox(
            child: Text(
              name,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: Utils.percentWidth(context, 0.04),
                color: Colors.grey.shade700
              ),
            ),
          )
        ],
      )
    );
  }
}