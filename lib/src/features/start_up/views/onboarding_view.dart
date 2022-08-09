import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';
import 'package:ninja_connect/src/core/constants/images.dart';
import 'package:ninja_connect/src/core/routes.dart';
import 'package:ninja_connect/src/core/utilities/hive_keys.dart';
import 'package:ninja_connect/src/features/start_up/models/onboarding_model.dart';
import 'package:ninja_connect/src/services/database_services.dart';
import 'package:ninja_connect/src/services/navigation_service.dart';
import 'package:ninja_connect/src/widgets/app_buttons.dart';
import 'package:ninja_connect/src/widgets/onboarding_tile.dart';
import 'package:ninja_connect/src/widgets/spacing.dart';
import 'package:ninja_connect/src/widgets/status_bar.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  OnboardingViewState createState() => OnboardingViewState();
}

class OnboardingViewState extends State<OnboardingView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(
        const Duration(seconds: 4),
        (Timer timer) {
          _currentPage < 2 ? _currentPage++ : _currentPage = 0;
          if (_pageController.hasClients) {
            _pageController.animateToPage(
              _currentPage,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) => setState(() => _currentPage = index);

  List<OnboardingModel> buildOnboardingList(BuildContext context) {
    final onboardingItems = [
      OnboardingModel(
        imageUrl: AppImages.onboardingimage1,
        title: 'Welcome!',
        desc:
            'It’s a pleasure to meet you. We are excited that you’re here so let’s get started!',
      ),
      OnboardingModel(
        imageUrl: AppImages.onboardingimage2,
        title: 'Get Connected',
        desc:
            'Create forum, connect and share it is all about 9ja make we connect joor. ',
      ),
      OnboardingModel(
        imageUrl: AppImages.onboardingimage3,
        title: '9ja Chat',
        desc: 'Chat and communicate easily with everyone on 9ja Connect',
      ),
    ];
    return onboardingItems;
  }

  @override
  Widget build(BuildContext context) {
    return Statusbar(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: buildOnboardingList(context).length,
                  itemBuilder: (ctx, index) => OnbaordingTile(
                    onboardingItem: buildOnboardingList(context)[index],
                  ),
                ),
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (int i = 0;
                        i < buildOnboardingList(context).length;
                        i++)
                      i == _currentPage
                          ? const PageViewIndicator(true)
                          : const PageViewIndicator(false)
                  ],
                ),
              ),
              const Spacing.largeHeight(),
              SizedBox(
                width: 365,
                child: Consumer(
                    builder: (_, ref, __) => AppButton(
                          label: 'Get Started',
                          onPressed: () async {
                            await ref
                                .read(hiveProvider)
                                .put(HiveKeys.viewed, true);
                            ref
                                .read(navigationService)
                                .navigateOffNamed(Routes.welcome);
                          },
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageViewIndicator extends StatelessWidget {
  final bool isActive;

  const PageViewIndicator(this.isActive, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 6 : 6,
      width: isActive ? 16 : 6,
      decoration: BoxDecoration(
        color: isActive ? AppColors.lightBlue : AppColors.icon,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
