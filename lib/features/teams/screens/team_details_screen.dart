import 'package:ctfinfo/constants/string_constants.dart';
import 'package:ctfinfo/features/teams/provider/team_provider.dart';
import 'package:ctfinfo/style/pallet.dart';
import 'package:ctfinfo/widgets/custom_scaffold.dart';
import 'package:ctfinfo/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamDetailsScreen extends StatefulWidget {
  static const String id = "/team-details-screen";
  final String teamId;
  const TeamDetailsScreen({
    super.key,
    required this.teamId,
  });

  @override
  State<TeamDetailsScreen> createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends State<TeamDetailsScreen> {
  final _teamProvider = TeamProvider();

  @override
  void initState() {
    super.initState();
    _teamProvider.getTeamDetail(widget.teamId);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ChangeNotifierProvider(
        create: (context) => _teamProvider,
        child: Consumer<TeamProvider>(
          builder: (context, teamProvider, child) {
            if (teamProvider.teamDetail.id == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var rating2024 = teamProvider.data2024;
            if (rating2024 == null) {
              return Center(
                child: Text('No Rating Data for 2024 Available'),
              );
            }
            return _buildUI(teamProvider, rating2024);
          },
        ),
      ),
    );
  }

  SafeArea _buildUI(TeamProvider value, var rating2024) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Pallet.greenColour,
                  ),
                ),
                const SizedBox(width: 10.0),
                CustomText(
                  txtTitle: "Team Detail",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    //logo
                    backgroundImage: value.teamDetail.logo!.isNotEmpty
                        ? NetworkImage(value.teamDetail.logo!)
                        : NetworkImage(
                            "https://images.ctfassets.net/aoyx73g9h2pg/3H8sLBKCH7xIph1YZmjFvd/8292d73649a27a4eb65724fa1df629f7/10684-1024x575.jpg?w=3840&q=100"),
                    radius: 100.0,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //team name
                  CustomText(
                    txtTitle: value.teamDetail.name ?? "Team Name",
                    textOverflow: TextOverflow.visible,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  //teamId
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      CustomText(
                        txtTitle: "${StringConstants.teamId} :",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        txtTitle: value.teamDetail.id.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  //Country
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      CustomText(
                        txtTitle: "${StringConstants.country} :",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      value.teamDetail.country == ""
                          ? CustomText(
                              txtTitle: StringConstants.notAvailable,
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          : CustomText(
                              txtTitle: value.teamDetail.country,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                    ],
                  ),
                  //rating place
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      CustomText(
                        txtTitle: "${StringConstants.ratingPlace} :",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      rating2024['rating_place'] != null
                          ? CustomText(
                              txtTitle: rating2024['rating_place'].toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          : CustomText(
                              txtTitle: StringConstants.notAvailable,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                    ],
                  ),
                  //organizer points
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      CustomText(
                        txtTitle: "${StringConstants.organizerPoints} :",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      rating2024['organizer_points'] != null
                          ? CustomText(
                              txtTitle:
                                  rating2024['organizer_points'].toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          : CustomText(
                              txtTitle: StringConstants.notAvailable,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                    ],
                  ),
                  //rating points
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      CustomText(
                        txtTitle: "${StringConstants.ratingPoints} :",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      rating2024['rating_points'] != null
                          ? CustomText(
                              txtTitle: rating2024['rating_points'].toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          : CustomText(
                              txtTitle: StringConstants.notAvailable,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                    ],
                  ),
                  //country place
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      CustomText(
                        txtTitle: "${StringConstants.countryPlace} :",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      rating2024['country_place'] != null
                          ? CustomText(
                              txtTitle: rating2024['country_place'].toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          : CustomText(
                              txtTitle: StringConstants.notAvailable,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
