import 'package:flutter/material.dart';
import 'package:ninja_connect/src/features/authentication/models/app_user.dart';
import 'package:ninja_connect/src/features/home/views/home_view.dart';
import 'package:ninja_connect/src/features/profile/views/profile_view.dart';
import 'package:ninja_connect/src/widgets/app_bottomnav.dart';

class DashboardView extends StatefulWidget {
  final AppUser user;
  const DashboardView({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  DashboardViewState createState() => DashboardViewState();
}

class DashboardViewState extends State<DashboardView> {
  int currentIndex = 0;

  final PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  pageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          HomeView(user: widget.user),
          HomeView(user: widget.user),
          ProfileView(
            user: widget.user,
          ),
        ],
      ),
    );
  }
}
