import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';
import 'package:ninja_connect/src/core/constants/dimensions.dart';
import 'package:ninja_connect/src/core/routes.dart';
import 'package:ninja_connect/src/core/utilities/validation_extension.dart';
import 'package:ninja_connect/src/features/authentication/models/app_user.dart';
import 'package:ninja_connect/src/features/forum/views/forum_tiile_view.dart';
import 'package:ninja_connect/src/repositories/forum_repository.dart';
import 'package:ninja_connect/src/services/navigation_service.dart';
import 'package:ninja_connect/src/widgets/empty_message.dart';

class HomeView extends ConsumerWidget {
  final AppUser user;
  const HomeView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final forums = ref.watch(forumsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.light,
        iconTheme: IconThemeData(color: colorScheme.onBackground),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_outlined),
          color: AppColors.dark,
        ),
        title: Text(
          'Connect Asap no dulling 😉',
          style: textTheme.headline2?.copyWith(
            color: AppColors.dark,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Dimensions.small),
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey.shade100,
              child: Text(
                user.userName[0].capitalize(),
              ),
            ),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(Dimensions.big),
          child: forums.when(
            data: ((data) => data.isEmpty
                ? const EmptyList(
                    text: 'No Forum yet, be the first to create a forum')
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) => ForumTile(
                      forum: data[index],
                    ),
                  )),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (_, __) => const ErrorList(),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(navigationService).navigateToNamed(Routes.add);
        },
        heroTag: null,
        child: const Icon(
          Icons.add,
          color: AppColors.icon,
        ),
      ),
    );
  }
}
