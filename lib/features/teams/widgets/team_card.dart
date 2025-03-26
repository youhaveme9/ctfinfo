import 'package:ctfinfo/constants/string_constants.dart';
import 'package:ctfinfo/features/teams/screens/team_details_screen.dart';
import 'package:ctfinfo/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class TeamCard extends StatelessWidget {
  final String teamName;
  final String teamPoints;
  final String teamId;
  const TeamCard({
    super.key,
    required this.teamName,
    required this.teamPoints,
    required this.teamId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            TeamDetailsScreen.id,
            arguments: teamId,
          );
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
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  radius: 35,
                  child: CustomText(
                    txtTitle: teamName.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      txtTitle: teamName.substring(
                          0, teamName.length > 20 ? 20 : teamName.length),
                      style: Theme.of(context).textTheme.headlineSmall,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        CustomText(
                          txtTitle: "${StringConstants.teamId} :",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 3),
                        CustomText(
                          txtTitle: teamId,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        CustomText(
                          txtTitle: "${StringConstants.points} :",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(width: 3),
                        CustomText(
                          txtTitle: teamPoints,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
