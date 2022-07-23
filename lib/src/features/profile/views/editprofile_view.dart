import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/utilities/validation_extension.dart';
import 'package:ninja_connect/src/features/authentication/models/app_user.dart';
import 'package:ninja_connect/src/features/profile/notifiers/update_profile_notifier.dart';
import 'package:ninja_connect/src/widgets/app_buttons.dart';
import 'package:ninja_connect/src/widgets/app_text_field.dart';
import 'package:ninja_connect/src/widgets/spacing.dart';

class EditProfileView extends StatefulWidget {
  final AppUser user;
  const EditProfileView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  EditProfileViewState createState() => EditProfileViewState();
}

class EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  late final name = TextEditingController();

  @override
  void initState() {
    name.text = widget.user.userName;
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final state = ref.watch(updateProfileProvider);
    // final notifier = ref.read(updateProfileProvider.notifier);
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Wrap(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(32),
              children: <Widget>[
                Text(
                  'Edit Profile',
                  style: textTheme.headline2?.copyWith(
                    fontSize: 20,
                  ),
                ),
                const Divider(height: 32, color: Colors.black54),
                const Spacing.smallHeight(),
                AppTextField(
                  labelText: 'Full Name',
                  validator: (value) =>
                      context.validateFullName(value, context),
                  controller: name,
                ),
                const Spacing.bigHeight(),
                const SizedBox(
                  height: 24,
                ),
                Consumer(
                  builder: (_, ref, __) => AppButton(
                    isLoading: ref.watch(updateProfileProvider).isLoading,
                    label: 'Update Profile',
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      if (_formKey.currentState!.validate()) {
                        await ref
                            .read(updateProfileProvider.notifier)
                            .updateProfile(name.text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
