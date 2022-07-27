import 'package:flutter/material.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';
import 'package:ninja_connect/src/features/forum/models/forum_model.dart';

class ForumTile extends StatelessWidget {
  const ForumTile({Key? key, required this.model}) : super(key: key);
  final ForumModel model;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 400,
        child: Card(
          color: AppColors.light,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: const BorderSide(
                width: 0.4,
                color: Color(0xFFBECADA),
              )),
          child: Column(
            children: [
              Image.asset(model.image!),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 22,
                    bottom: 22,
                    left: 17,
                  ),
                  child: ListTile(
                    //leading: Image.asset(model.image!),
                    title: Text(
                      model.forumName!,
                      style: textTheme.headline4,
                    ),
                    subtitle: Text(
                      model.summary!,
                      style: textTheme.headline6,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Container(
                      decoration: const BoxDecoration(
                          color: AppColors.light,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '27-02-2006',
                          style: textTheme.headline6,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
