import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';
import 'package:ninja_connect/src/core/constants/images.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const AppBottomNavBar(
      {required this.currentIndex, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List> icons = [
      [
        currentIndex == 0
            ? SvgPicture.asset(
                AppImages.home,
                color: AppColors.lightBlue,
              )
            : SvgPicture.asset(
                AppImages.home,
                color: Colors.grey,
              ),
        "Home"
      ],
      [
        currentIndex == 1
            ? SvgPicture.asset(
                AppImages.chat,
                color: AppColors.lightBlue,
              )
            : SvgPicture.asset(
                AppImages.chat,
                color: Colors.grey,
              ),
        "Chat"
      ],
      [
        currentIndex == 2
            ? SvgPicture.asset(
                AppImages.profile,
                color: AppColors.lightBlue,
              )
            : SvgPicture.asset(
                AppImages.profile,
                color: Colors.grey,
              ),
        "Profile"
      ],
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.lightBlue,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.lightBlue),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      items: icons
          .asMap()
          .map((i, e) => MapEntry(
                i,
                BottomNavigationBarItem(
                  icon: e[0],
                  label: e[1],
                ),
              ))
          .values
          .toList(),
    );
  }
}
