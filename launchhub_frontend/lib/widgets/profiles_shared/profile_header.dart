import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launchhub_frontend/models/social_media_link.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    this.firstName,
    this.lastName,
    this.city,
    this.email,
    this.phoneNumber,
    this.socials,
    this.profilePicture,
    this.color = Colors.white,
  });

  final Color? color;
  final String? firstName;
  final String? lastName;
  final String? city;
  final String? email;
  final String? phoneNumber;
  final String? profilePicture;
  final List<SocialMediaLink>? socials;

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
            title: '${firstName!} ${lastName!}',
            textColor: color,
          ),
          SizedBox(
            width: 300,
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
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
                              Text(
                                email!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 13,
                                      color: color,
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
                              Text(
                                city!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 13,
                                      color: color,
                                    ),
                              ),
                            ],
                          ),
                          // const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (var social in socials!)
                                if (social.platform.toLowerCase().trim() ==
                                    'facebook')
                                  _buildSocialIcon(
                                      context,
                                      social.platform,
                                      color!,
                                      social.link,
                                      FontAwesomeIcons.facebook)
                                else if (social.platform.toLowerCase().trim() ==
                                    'instagram')
                                  _buildSocialIcon(
                                      context,
                                      social.platform,
                                      color!,
                                      social.link,
                                      FontAwesomeIcons.instagram)
                                else if (social.platform.toLowerCase().trim() ==
                                    'linkedin')
                                  _buildSocialIcon(
                                      context,
                                      social.platform,
                                      color!,
                                      social.link,
                                      FontAwesomeIcons.linkedin)
                            ],
                          )
                        ],
                      )),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&q=70&fm=webp'),
                      fit: BoxFit.cover,
                    ),
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

Widget _buildSocialIcon(
    context, String platform, Color color, String link, IconData icon) {
  Uri uriLink = Uri.parse(link);
  return IconButton(
    alignment: Alignment.centerLeft,
    icon: FaIcon(
      icon,
      color: color,
      size: 15,
    ),
    onPressed: () async {
      if (await canLaunchUrl(uriLink)) {
        await launchUrl(uriLink);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $platform'),
          ),
        );
      }
    },
  );
}
