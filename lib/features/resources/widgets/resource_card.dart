import 'package:ctfinfo/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceCard extends StatelessWidget {
  final String title;
  final String description;
  final String url;

  const ResourceCard({
    super.key,
    required this.title,
    required this.description,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      child: InkWell(
        onTap: () async {
          if (!await launchUrl(Uri.parse(url))) {
            throw Exception('Could not launch');
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        txtTitle: title.substring(
                            0, title.length > 20 ? 20 : title.length),
                        style: Theme.of(context).textTheme.headlineSmall,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      CustomText(
                        txtTitle: description,
                        style: Theme.of(context).textTheme.bodyLarge,
                        softWrap: true,
                        textOverflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  radius: 35,
                  child: Icon(
                    Icons.language,
                    size: 35,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
