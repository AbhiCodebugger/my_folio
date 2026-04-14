import 'package:flutter/material.dart';
import 'package:myfolio_flutter/providers/user_provider.dart';
import 'package:myfolio_flutter/screens/desktop_layout.dart';
import 'package:myfolio_flutter/screens/mobile_layout.dart';
import 'package:myfolio_flutter/screens/tablet_layout.dart';
import 'package:myfolio_flutter/utils/responsive.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: Consumer<UserProvider>(
          builder: (context, vM, child) {
            final user = vM.user;
            final roles = vM.roles;
            final skills = vM.skills;
            final educations = vM.educations;
            final experiences = vM.experiences;
            return ResponsiveBuilder(
              mobile: MobileLayout(
                user: user,
                roles: roles,
                skills: skills,
                educations: educations,
                experiences: experiences,
              ),
              tablet: TabletLayout(
                user: user,
                roles: roles,
                skills: skills,
                educations: educations,
                experiences: experiences,
              ),
              desktop: DesktopLayout(
                user: user,
                roles: roles,
                skills: skills,
                educations: educations,
                experiences: experiences,
              ),
            );
          },
        ),
      ),
    );
  }
}
