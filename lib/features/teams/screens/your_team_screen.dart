import 'package:ctfinfo/constants/image_constants.dart';
import 'package:ctfinfo/constants/string_constants.dart';
import 'package:ctfinfo/features/teams/provider/team_provider.dart';
import 'package:ctfinfo/style/pallet.dart';
import 'package:ctfinfo/utils/shared_preferences.dart';
import 'package:ctfinfo/utils/toast_utils.dart';
import 'package:ctfinfo/utils/validator.dart';
import 'package:ctfinfo/widgets/custom_button.dart';
import 'package:ctfinfo/widgets/custom_scaffold.dart';
import 'package:ctfinfo/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourTeamScreen extends StatefulWidget {
  static const String id = "/your_team_screen";
  const YourTeamScreen({super.key});

  @override
  State<YourTeamScreen> createState() => _YourTeamScreenState();
}

class _YourTeamScreenState extends State<YourTeamScreen> {
  String? teamId;
  late TeamProvider _teamProvider;
  final TextEditingController _teamIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _teamProvider = Provider.of<TeamProvider>(context, listen: false);
    _loadTeamDetails();
    _initializeTeamId();
  }

  Future<void> _initializeTeamId() async {
    await SharedPreferencesUtils.init();
    String savedTeamId =
        SharedPreferencesUtils.getString(SharedPreferencesUtils.teamId);
    if (savedTeamId.isNotEmpty) {
      setState(() {
        teamId = savedTeamId;
      });
    }
  }

  Future<void> _saveTeamId() async {
    setState(() {
      _isLoading = true; // Set loading to true before fetching data
    });
    ToastUtil.showInfoToast("Loading team details");
    String enteredTeamId = _teamIdController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('teamId', enteredTeamId);
    setState(() {
      teamId = enteredTeamId;
    });

    try {
      await _teamProvider.getTeamDetail(enteredTeamId);
      ToastUtil.showSuccessToast("Team details loaded successfully");
    } catch (e) {
      ToastUtil.showErrorToast("Failed to load team details");
    }
    setState(() {
      _isLoading = false; // Set loading to false after data is fetched
    });
  }

  Future<void> _loadTeamDetails() async {
    setState(() {
      _isLoading = true; // Set loading to true before fetching data
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedTeamId = prefs.getString('teamId');

    if (storedTeamId != null) {
      await _teamProvider.getTeamDetail(storedTeamId);
    }
    setState(() {
      _isLoading = false; // Set loading to false after data is fetched
    });
  }

  Future<void> _clearTeamId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('teamId');
    setState(() {
      teamId = null;
    });
    ToastUtil.showSuccessToast("Team details cleared");
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Consumer<TeamProvider>(
        builder: (context, teamProvider, child) {
          return _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildUI(teamProvider);
        },
      ),
    );
  }

  SafeArea _buildUI(TeamProvider value) {
    var rating2024 = value.data2024;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomText(
                txtTitle: 'Your Team',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    //logo
                    backgroundImage: (teamId != null &&
                            value.teamDetail.logo != null)
                        ? NetworkImage(value.teamDetail.logo!)
                        : const NetworkImage(
                            "https://images.ctfassets.net/aoyx73g9h2pg/3H8sLBKCH7xIph1YZmjFvd/8292d73649a27a4eb65724fa1df629f7/10684-1024x575.jpg?w=3840&q=100"),
                    radius: 100.0,
                  ),
                  const SizedBox(height: 20.0),
                  CustomText(
                    txtTitle: (teamId != null && value.teamDetail.name != null)
                        ? value.teamDetail.name!
                        : "Team Name",
                    textOverflow: TextOverflow.visible,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20.0),
                  //teamId
                  Row(
                    children: [
                      CustomText(
                        txtTitle: "${StringConstants.teamId} :",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        txtTitle: teamId ?? StringConstants.notAvailable,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  //country
                  Row(
                    children: [
                      CustomText(
                        txtTitle: "${StringConstants.country} :",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        txtTitle: (teamId != null &&
                                value.teamDetail.country != null &&
                                value.teamDetail.country != "")
                            ? value.teamDetail.country!
                            : StringConstants.notAvailable,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  //rating place
                  Row(
                    children: [
                      CustomText(
                        txtTitle: "${StringConstants.ratingPlace} :",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        txtTitle: (teamId != null &&
                                rating2024 != null &&
                                rating2024['rating_place'] != null)
                            ? rating2024['rating_place'].toString()
                            : StringConstants.notAvailable,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  //organizer points
                  Row(
                    children: [
                      CustomText(
                        txtTitle: "${StringConstants.organizerPoints} :",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        txtTitle: (teamId != null &&
                                rating2024 != null &&
                                rating2024['organizer_points'] != null)
                            ? rating2024['organizer_points'].toString()
                            : StringConstants.notAvailable,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  //rating points
                  Row(
                    children: [
                      CustomText(
                        txtTitle: "${StringConstants.ratingPoints} :",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        txtTitle: (teamId != null &&
                                rating2024 != null &&
                                rating2024['rating_points'] != null)
                            ? rating2024['rating_points'].toString()
                            : StringConstants.notAvailable,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  //country place
                  Row(
                    children: [
                      CustomText(
                        txtTitle: "${StringConstants.countryPlace} :",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        txtTitle: (teamId != null &&
                                rating2024 != null &&
                                rating2024['country_place'] != null)
                            ? rating2024['country_place'].toString()
                            : StringConstants.notAvailable,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Footer(
              backgroundColor: Colors.transparent,
              child: Center(
                child: _buttons(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buttons() {
    if (teamId != null) {
      return CustomButton(text: 'Clear Data', onPressed: _clearTeamId);
    } else {
      return CustomButton(text: 'Add Team', onPressed: _showSettingsPanel);
    }
  }

  void _showSettingsPanel() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.bgPrimary),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                CustomText(
                  txtTitle: 'Enter Your Team ID',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: _teamIdController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Pallet.greenColour, width: 2.0),
                    ),
                  ).copyWith(
                    hintText: 'Enter Your CTF TeamID',
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: Pallet.greenColour,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your CTF team ID';
                    } else if (!Validator.isDigit(teamId: value)) {
                      return 'Please enter your valid CTF team ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: 'Save',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _saveTeamId();
                          Navigator.pop(context);
                        }
                      },
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    CustomButton(
                      text: 'Cancel',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
