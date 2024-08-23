import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:joola/src/utils/utils.dart';

class CardView extends StatelessWidget {
  final String image;
  final String title;
  final String name;
  final double widthPercent;
  final Function()? onTap;

  const CardView({
    super.key,
    required this.image,
    required this.title,
    required this.name,
    required this.widthPercent,
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
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    blendMode: BlendMode.srcIn,
                    child: Container(
                      height: Utils.percentWidth(context, 0.1),
                      color: Colors.transparent,
                    )
                  ),
                ),
              ),
              Positioned(
                bottom: Utils.percentWidth(context, 0.019),
                left: Utils.percentWidth(context, 0.03),
                child: Row(
                  children: [
                    Text(
                      '4.1',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: Utils.percentWidth(context, 0.04)
                      )
                    ),
                    Icon(
                      Icons.bolt_sharp,
                      color: const Color(0xffffd600),
                      size: Utils.percentWidth(context, 0.05)
                    )
                  ]
                )
              ),
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