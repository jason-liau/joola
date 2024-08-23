import 'package:flutter/material.dart';
import 'package:joola/src/utils/utils.dart';

class PageTitle extends StatelessWidget {
  final String text;

  const PageTitle({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: Utils.percentWidth(context, 0.07),
            )
          ),
          Row(
            children: [
              Icon(
                Icons.search_rounded,
                size: Utils.percentWidth(context, 0.07),
              ),
              SizedBox(width: Utils.percentWidth(context, 0.02)),
              Icon(
                Icons.notifications_none_rounded,
                size: Utils.percentWidth(context, 0.07)
              ),
              SizedBox(width: Utils.percentWidth(context, 0.02)),
              Icon(
                Icons.bookmark_outline_rounded,
                size: Utils.percentWidth(context, 0.07)
              )
            ]
          )
        ],
      ),
    );
  }
}