import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';
import 'package:ninja_connect/src/core/constants/dimensions.dart';
import 'package:ninja_connect/src/core/utilities/validation_extension.dart';
import 'package:ninja_connect/src/features/forum/models/forum_model.dart';
import 'package:ninja_connect/src/widgets/spacing.dart';

class ForumTile extends StatelessWidget {
  const ForumTile({Key? key, required this.model}) : super(key: key);
  final Forum model;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    final date = DateTime.parse(model.timestamp.toDate().toString());
    final dateCreated = DateFormat('y MMMM d hh:mm a').format(date);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 400,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: AppColors.light,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: const BorderSide(
                width: 0.4,
                color: Color(0xFFBECADA),
              )),
          child: Column(
            children: [
              Image.network(
                model.imageUrl,
                fit: BoxFit.cover,
                height: 200,
                width: width,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.medium,
                    horizontal: Dimensions.big,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          model.forumName,
                          style: textTheme.headline4,
                        ),
                      ),
                      const Spacing.mediumHeight(),
                      Text(
                        model.summary,
                        style: textTheme.headline6,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacing.bigHeight(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: AppColors.icon,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(Dimensions.small),
                            child: Text(
                              'Created by ${model.creatorName.capitalize()}  ${dateCreated.toString()}',
                              style: textTheme.headline6,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
