import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';
import 'package:ninja_connect/src/core/constants/dimensions.dart';
import 'package:ninja_connect/src/core/utilities/validation_extension.dart';
import 'package:ninja_connect/src/widgets/app_buttons.dart';
import 'package:ninja_connect/src/widgets/app_text_field.dart';
import 'package:ninja_connect/src/widgets/spacing.dart';

class AddForumView extends StatefulWidget {
  const AddForumView({Key? key}) : super(key: key);

  @override
  State<AddForumView> createState() => _AddForumViewState();
}

class _AddForumViewState extends State<AddForumView> {
  final ImagePicker _picker = ImagePicker();
  XFile? imageFile;
  final _formKey = GlobalKey<FormState>();
  final forum = TextEditingController();
  final summary = TextEditingController();
  final about = TextEditingController();

  void filePicker() async {
    final selectImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = selectImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.light,
        title: Text(
          'Add New Forum',
          style: textTheme.headline6,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.big),
        child: Form(
            key: _formKey,
            child: ListView(children: [
              AppTextField(
                hintText: 'Learning Flutter',
                labelText: 'Forum Name',
                validator: (value) =>
                    context.validateFieldNotEmpty(value, context),
              ),
              const Spacing.bigHeight(),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                height: 200,
                child: imageFile == null
                    ? GestureDetector(
                        onTap: () {
                          filePicker();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_upload_sharp,
                              color: colorScheme.onBackground,
                            ),
                            const Spacing.smallWidth(),
                            Text(
                              'Pick Image',
                              style: textTheme.headline6?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Image.file(
                        File(imageFile!.path),
                        fit: BoxFit.cover,
                        width: 370,
                      ),
              ),
              const Spacing.bigHeight(),
              AppTextField(
                hintText: 'Forum short description',
                labelText: 'Description',
                validator: (value) =>
                    context.validateFieldNotEmpty(value, context),
              ),
              const Spacing.bigHeight(),
              AppTextField(
                hintText:
                    'About the Forum full details, tell us what inspired you?',
                labelText: 'About',
                validator: (value) =>
                    context.validateFieldNotEmpty(value, context),
                maxLines: 4,
              ),
              const Spacing.bigHeight(),
              AppTextField(
                hintText:
                    'About the Forum full details, tell us what inspired you?',
                labelText: 'About',
                validator: (value) =>
                    context.validateFieldNotEmpty(value, context),
                maxLines: 6,
              ),
              const Spacing.largeHeight(),
              AppButton(label: 'Create Forum', onPressed: () {}),
            ])),
      ),
    );
  }
}
