import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:joola/src/pages/home.dart';
import 'package:joola/src/pages/profile.dart';
import 'package:joola/src/pages/services.dart';
import 'package:joola/src/pages/train.dart';
import 'package:joola/src/pages/wellness.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:joola/src/utils/utils.dart';

class FloatingNavigationPage extends StatefulWidget {
  const FloatingNavigationPage({super.key});

  @override
  State<FloatingNavigationPage> createState() => _FloatingNavigationPageState();
}

class _FloatingNavigationPageState extends State<FloatingNavigationPage>
    with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser;
  final List<Widget> pages = [
    const HomePage(),
    const TrainPage(),
    const WellnessPage(),
    const ServicesPage(),
    const ProfilePage()
  ];

  late TabController tabController;

  int pageIndex = 0;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    pageIndex = 0;
    tabController = TabController(length: pages.length, vsync: this);
    tabController.animation?.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != pageIndex && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      pageIndex = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BottomBar(
      body: (context, controller) => TabBarView(
        controller: tabController,
        physics: const BouncingScrollPhysics(),
        children: pages,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      width: Utils.percentWidth(context, 0.86),
      barAlignment: Alignment.bottomCenter,
      showIcon: false,
      offset: Utils.percentHeight(context, 0.03),
      child: TabBar(
          isScrollable: false,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          controller: tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontSize: 12),
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          labelPadding: const EdgeInsets.all(0.0),
          tabs: [
            Tab(text: "Home", icon: Icon(size: Utils.percentWidth(context, 0.06),
                pageIndex == 0? Icons.home : Icons.home_outlined,
                color: pageIndex == 0 ? Colors.white : Colors.grey,
              ),
            ),
            Tab(
              text: "Train", icon: Icon(size: Utils.percentWidth(context, 0.06),
                pageIndex == 1 ? Icons.sports_tennis : Icons.sports_tennis_outlined,
                color: pageIndex == 1 ? Colors.white : Colors.grey,
              ),
            ),
            Tab(
              text: "Wellness", icon: Icon(size: Utils.percentWidth(context, 0.06),
                pageIndex == 2 ? Icons.favorite : Icons.favorite_border_outlined,
                color: pageIndex == 2 ? Colors.white : Colors.grey,
              ),
            ),
            Tab(
                text: "Services",
                icon: Icon(size: Utils.percentWidth(context, 0.06), pageIndex == 3 ? Icons.feed : Icons.feed_outlined,
                    color: pageIndex == 3 ? Colors.white : Colors.grey)),
            Tab(
              text: "Profile",
              icon: Icon(size: Utils.percentWidth(context, 0.06), pageIndex == 4 ? Icons.account_circle : Icons.account_circle_outlined,
                color: pageIndex == 4 ? Colors.white : Colors.grey,
              ),
            ),
          ]),
    ));
  }
}
