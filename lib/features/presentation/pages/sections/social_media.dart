import 'package:flutter/material.dart';
import 'package:i_am_abhishek/core/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaSection extends StatelessWidget {
  const SocialMediaSection({super.key, this.onTapRocket});
  final void Function()? onTapRocket;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: double.infinity,
      color: const Color.fromARGB(255, 32, 32, 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          //social media
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              ConstValues.socialMediaLinks.length,
              (index) => InkWell(
                onTap: () async {
                  await _launchUrl(ConstValues.socialMediaLinks[index][1]);
                },
                child: Container(
                  margin: EdgeInsets.all(8),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    image: DecorationImage(
                      image: AssetImage(ConstValues.socialMediaLinks[index][0]),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //rocket
          InkWell(
            onTap: onTapRocket,
            child: SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(ConstValues.rocketIcon),
            ),
          ),
          //brand mark
          RichText(
            text: TextSpan(
              text: '©Abhishek B Ambady',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  Uri uri = Uri.parse(url);
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception('Could not launch url');
    }
  } catch (e) {
    print(e);
  }
}
