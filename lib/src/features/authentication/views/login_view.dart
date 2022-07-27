import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';
import 'package:ninja_connect/src/core/constants/strings.dart';
import 'package:ninja_connect/src/core/routes.dart';
import 'package:ninja_connect/src/core/utilities/validation_extension.dart';
import 'package:ninja_connect/src/features/authentication/notifiers/login_notifier.dart';
import 'package:ninja_connect/src/widgets/app_buttons.dart';
import 'package:ninja_connect/src/widgets/app_text_field.dart';
import 'package:ninja_connect/src/widgets/spacing.dart';
import 'package:ninja_connect/src/widgets/two_colored_text.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(loginProvider);
    final notifier = ref.read(loginProvider.notifier);
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
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
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
                  'Sign in',
                  style: textTheme.headline3,
                ),
                const Spacing.largeHeight(),
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
                  labelText: AppStrings.password,
                  hintText: '*******',
                  keyboardType: TextInputType.visiblePassword,
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
                  label: 'Sign in',
                  isLoading: state.isLoading,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      notifier.loginUser(
                          email: email.text, password: password.text);
                      // Navigator.pushNamed(context, Routes.naija);
                    }
                  },
                ),
                const Spacing.bigHeight(),
                Text.rich(
                  TextSpan(
                    text: AppStrings.dont,
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: TextStyle(color: colorScheme.primary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                                context, Routes.register);
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
