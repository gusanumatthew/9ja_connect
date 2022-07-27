import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';
import 'package:ninja_connect/src/core/constants/strings.dart';
import 'package:ninja_connect/src/core/routes.dart';
import 'package:ninja_connect/src/core/utilities/validation_extension.dart';
import 'package:ninja_connect/src/features/authentication/notifiers/register_notifier.dart';
import 'package:ninja_connect/src/widgets/app_buttons.dart';
import 'package:ninja_connect/src/widgets/app_text_field.dart';
import 'package:ninja_connect/src/widgets/spacing.dart';
import 'package:ninja_connect/src/widgets/two_colored_text.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(registerProvider);
    final notifier = ref.read(registerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: colorScheme.onBackground),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Hero(
                  tag: "logo",
                  child: TwoColoredText(
                    first: '9ja',
                    second: 'Connect',
                    fontSize: 28,
                  ),
                ),
                const Spacing.largeHeight(),
                const Spacing.largeHeight(),
                Text(
                  'Sign up',
                  style: textTheme.headline3,
                ),
                const Spacing.largeHeight(),
                AppTextField(
                  labelText: 'Username',
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  hintText: 'DeveloperMatt',
                  validator: (value) =>
                      context.validateFieldNotEmpty(value, context),
                  controller: name,
                ),
                const Spacing.bigHeight(),
                AppTextField(
                  labelText: AppStrings.email,
                  hintText: '@example.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      context.validateEmailAddress(value, context),
                  controller: email,
                ),
                const Spacing.bigHeight(),
                AppTextField(
                  labelText: 'Password',
                  hintText: '*******',
                  obscureText: state.obscureText,
                  validator: (value) =>
                      context.validatePassword(value, context),
                  controller: password,
                  suffixIcon: IconButton(
                    color: AppColors.deep,
                    icon: Icon(
                      state.obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () => notifier.passwordVisibility(),
                  ),
                ),
                const Spacing.largeHeight(),
                AppButton(
                    label: 'Sign up',
                    isLoading: state.isLoading,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        await notifier.registerUser(
                            email: email.text,
                            password: password.text,
                            displayName: name.text);
                      }
                    }),
                const Spacing.bigHeight(),
                Text.rich(
                  TextSpan(
                    text: AppStrings.alreadyAccount,
                    children: [
                      TextSpan(
                        text: 'Sign in',
                        style: TextStyle(color: colorScheme.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                                context, Routes.login);
                          },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
