import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/helpers/open_link.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    this.firstName,
    this.lastName,
    this.companyName,
    this.city,
    this.email,
    this.phoneNumber,
    this.socials = const [],
    this.profilePicture,
    this.color = Colors.white,
  });

  final Color? color;
  final String? firstName;
  final String? lastName;
  final String? companyName;
  final String? city;
  final String? email;
  final String? phoneNumber;
  final String? profilePicture;
  final List socials;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(37),
          bottomRight: Radius.circular(37),
        ),
        image: color == Colors.white
            ? const DecorationImage(
                image: AssetImage('assets/backgrounds/header.png'),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use minimal space for the Column
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBar(
            title: companyName != null
                ? '$companyName'
                : '${firstName!} ${lastName!}',
            textColor: color,
          ),
          Container(
            // width: 320,
            padding: const EdgeInsets.only(left: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        "${baseUrl}assets/images/profile_pics/$profilePicture",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.phone_enabled_outlined,
                                    color: color,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      phoneNumber!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 13,
                                            color: color,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.email_outlined,
                                    color: color,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 12),
                                  Flexible(
                                    child: Text(
                                      email!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 13,
                                            color: color,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: color,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 12),
                                  Flexible(
                                    child: Text(
                                      city!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 13,
                                            color: color,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              // const SizedBox(height: 10),
                            ],
                          )),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for (var social in socials)
                            if (social.platform.toLowerCase().trim() ==
                                'facebook')
                              IconButton(
                                alignment: Alignment.centerLeft,
                                icon: Icon(
                                  FontAwesomeIcons.facebook,
                                  color: color,
                                  size: 15,
                                ),
                                onPressed: () async {
                                  openLink(context, social.link);
                                },
                              )
                            else if (social.platform.toLowerCase().trim() ==
                                'instagram')
                              IconButton(
                                alignment: Alignment.centerLeft,
                                icon: Icon(
                                  FontAwesomeIcons.instagram,
                                  color: color,
                                  size: 15,
                                ),
                                onPressed: () async {
                                  openLink(context, social.link);
                                },
                              )
                            else if (social.platform.toLowerCase().trim() ==
                                'linkedin')
                              IconButton(
                                alignment: Alignment.centerLeft,
                                icon: Icon(
                                  FontAwesomeIcons.linkedin,
                                  color: color,
                                  size: 15,
                                ),
                                onPressed: () async {
                                  openLink(context, social.link);
                                },
                              )
                        ],
                      )
                    ],
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
