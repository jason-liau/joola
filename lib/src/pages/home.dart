import 'package:flutter/material.dart';
import 'package:joola/src/components/home_header.dart';
import 'package:joola/src/components/horizontal_scroll.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 64, 64, 162),
      body: Stack(
        children: [
          FractionallySizedBox(
            heightFactor: 0.42,
            widthFactor: 1,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 64, 64, 162),
                    Color.fromARGB(255, 111, 98, 192),
                  ],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 50
                ),
                child: Text(
                    'Welcome!',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              )
            ),
          ),
          DraggableScrollableSheet(
            snap: true,
            initialChildSize: 0.60,
            minChildSize: 0.60,
            maxChildSize: 1,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)
                  ),
                  color: Colors.white
                ),
                child: ListView(
                  controller: scrollController,
                  children: const [
                    HomeHeader(
                      text: 'In Progress'
                    ),
                    HorizontalScroll(),
                    HomeHeader(
                      text: 'Recommended for You'
                    ),
                    HorizontalScroll(),
                    HomeHeader(
                      text: 'Train'
                    ),
                    HorizontalScroll(),
                    HomeHeader(
                      text: 'Trending Categories'
                    ),
                    HorizontalScroll(),
                    HomeHeader(
                      text: 'Upcoming Events'
                    ),
                    HorizontalScroll(),
                    Padding(padding: EdgeInsets.only(bottom: 30))
                  ]
                )
              );
            }
          )
        ]
      )
    );
  }
}