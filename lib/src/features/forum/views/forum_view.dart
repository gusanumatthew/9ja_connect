import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ninja_connect/src/core/constants/colors.dart';
import 'package:ninja_connect/src/core/utilities/validation_extension.dart';
import 'package:ninja_connect/src/features/forum/models/forum_model.dart';
import 'package:ninja_connect/src/widgets/spacing.dart';

class ForumView extends StatelessWidget {
  final Forum forum;
  const ForumView({Key? key, required this.forum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(forum.timestamp.toDate().toString());
    final dateCreated = DateFormat('y MMMM d').format(date);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.light,
          title: Text(
            forum.forumName,
            style: textTheme.headline5,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          color: AppColors.dark,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Image.network(
                            forum.imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        bottom: 12,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 27,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.light,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Created by ${forum.creatorName.capitalize()}, $dateCreated',
                                style: GoogleFonts.mulish(
                                  textStyle: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.deep,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  const Spacing.mediumHeight(),
                  TabBar(
                    indicatorColor: Colors.transparent,
                    labelColor: colorScheme.onBackground,
                    unselectedLabelStyle: textTheme.headline6,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: textTheme.bodyText2,
                    tabs: const [
                      Tab(text: 'Discuss'),
                      Tab(text: 'About Forum'),
                    ],
                  ),
                  SizedBox(
                    height: height,
                    child: TabBarView(
                      children: [
                        const Text('ok'),
                        Text(
                          forum.about,
                          style: textTheme.subtitle1,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
