import 'package:ctfinfo/constants/image_constants.dart';
import 'package:ctfinfo/constants/string_constants.dart';
import 'package:ctfinfo/features/teams/provider/team_provider.dart';
import 'package:ctfinfo/style/pallet.dart';
import 'package:ctfinfo/widgets/custom_scaffold.dart';
import 'package:ctfinfo/widgets/custom_text.dart';
import 'package:ctfinfo/widgets/information_field.dart';
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
      child: SingleChildScrollView(
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
              const SizedBox(
                height: 10.0,
              ),
              Image.asset(ImageConstants.lines),
              const SizedBox(height: 7.0),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          ImageConstants.fingerprint,
                          height: 360.0,
                          fit: BoxFit.cover,
                        ),
                        CircleAvatar(
                          backgroundImage: value.teamDetail.logo!.isNotEmpty
                              ? NetworkImage(value.teamDetail.logo!)
                              : NetworkImage(ImageConstants.defaultLogo),
                          radius: 80.0,
                        )
                      ],
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
                    InformationField(value: value.teamDetail.id.toString()),
                    //Country
                    const SizedBox(
                      height: 10.0,
                    ),
                    value.teamDetail.country == ""
                        ? InformationField(value: StringConstants.notAvailable)
                        : InformationField(
                            value: value.teamDetail.country.toString()),
                    //rating place
                    const SizedBox(
                      height: 10.0,
                    ),
                    rating2024['rating_place'] != null
                        ? InformationField(
                            value: rating2024['rating_place'].toString())
                        : InformationField(value: StringConstants.notAvailable),
                    //organizer points
                    const SizedBox(
                      height: 10.0,
                    ),
                    rating2024['organizer_points'] != null
                        ? InformationField(
                            value: rating2024['organizer_points'].toString())
                        : InformationField(value: StringConstants.notAvailable),
                    //rating points
                    const SizedBox(
                      height: 10.0,
                    ),
                    rating2024['rating_points'] != null
                        ? InformationField(
                            value: rating2024['rating_points'].toString())
                        : InformationField(value: StringConstants.notAvailable),
                    //country place
                    const SizedBox(
                      height: 10.0,
                    ),
                    rating2024['country_place'] != null
                        ? InformationField(
                            value: rating2024['country_place'].toString())
                        : InformationField(value: StringConstants.notAvailable),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
