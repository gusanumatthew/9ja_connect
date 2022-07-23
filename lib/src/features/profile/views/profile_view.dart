import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';
import 'package:ninja_connect/src/core/utilities/validation_extension.dart';
import 'package:ninja_connect/src/features/authentication/models/app_user.dart';
import 'package:ninja_connect/src/features/profile/notifiers/profile_notifier.dart';
import 'package:ninja_connect/src/features/profile/views/about_view.dart';
import 'package:ninja_connect/src/features/profile/views/editprofile_view.dart';
import 'package:ninja_connect/src/widgets/profile_tile.dart';
import 'package:ninja_connect/src/widgets/spacing.dart';

class ProfileView extends StatefulHookConsumerWidget {
  final AppUser user;
  const ProfileView({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends ConsumerState<ProfileView> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     updateUser();
  //   });

  //   super.initState();
  // }

  void _editProfileBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) => EditProfileView(
        user: widget.user,
      ),
    );
  }

  // late AppUser user;
  // void updateUser() async {
  //   user = widget.user;
  // }

  void _aboutBeNotifiedScreen(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) => const AboutView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    ///final user = ref.watch(profileProvider.notifier).user;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_outlined),
          color: AppColors.dark,
        ),
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: colorScheme.onBackground),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Spacing.largeHeight(),
            CircleAvatar(
              backgroundColor: Colors.blueGrey.shade100,
              radius: 48,
              child: Text(
                widget.user.userName[0].capitalize(),
                style: textTheme.headline1,
              ),
            ),
            const Spacing.bigHeight(),
            Text(
              widget.user.userName.capitalize(),
              style: textTheme.headline1?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacing.smallHeight(),
            Text(widget.user.email),
            const Spacing.largeHeight(),
            ProfileTile(
              leading: Icons.person_outline,
              onPressed: () => _editProfileBottomSheet(context),
              title: 'Edit Profile',
            ),
            const Spacing.bigHeight(),
            ProfileTile(
              leading: Icons.person_outline,
              onPressed: () => _aboutBeNotifiedScreen(context),
              title: 'About 9jaConnect',
            ),
            const Spacing.bigHeight(),
            ProfileTile(
              leading: Icons.logout,
              onPressed: () async {
                await ref.read(profileProvider.notifier).logoutUser();
              },
              title: 'Logout',
            ),
            const Spacing.bigHeight(),
          ],
        ),
      ),
    );
  }
}
