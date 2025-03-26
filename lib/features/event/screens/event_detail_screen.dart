import 'package:ctfinfo/constants/image_constants.dart';
import 'package:ctfinfo/constants/string_constants.dart';
import 'package:ctfinfo/features/event/provider/event_provider.dart';
import 'package:ctfinfo/style/pallet.dart';
import 'package:ctfinfo/utils/date_time_utils.dart';
import 'package:ctfinfo/widgets/custom_button.dart';
import 'package:ctfinfo/widgets/custom_scaffold.dart';
import 'package:ctfinfo/widgets/custom_text.dart';
import 'package:ctfinfo/widgets/information_field.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailScreen extends StatefulWidget {
  static const String id = "/event_detail_screen";
  final String eventId;
  const EventDetailScreen({super.key, required this.eventId});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final _eventProvider = EventProvider();

  @override
  void initState() {
    super.initState();
    _eventProvider.getEventDetail(widget.eventId);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ChangeNotifierProvider(
        create: (context) => _eventProvider,
        child: Consumer<EventProvider>(
          builder: (context, eventProvider, child) {
            if (eventProvider.eventDetail.id == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return _buildUI(eventProvider);
          },
        ),
      ),
    );
  }

  SafeArea _buildUI(EventProvider value) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(width: 15.0),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Pallet.greenColour,
                  ),
                ),
                const SizedBox(width: 10),
                CustomText(
                  txtTitle: "CTF Detail",
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
                        ImageConstants.avatarBorder,
                        height: 360.0,
                        fit: BoxFit.cover,
                      ),
                      CircleAvatar(
                        backgroundImage: value.eventDetail.logo!.isNotEmpty
                            ? NetworkImage(
                                value.eventDetail.logo!,
                              )
                            : NetworkImage(ImageConstants.defaultLogo),
                        radius: 80.0,
                      ),
                    ],
                  ),
                  //event name
                  CustomText(
                    txtTitle: value.eventDetail.title ?? "Event Name",
                    textOverflow: TextOverflow.visible,
                    style: Theme.of(context).textTheme.headlineMedium,
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  //start
                  InformationField(
                      value:
                          "${DateTimeUtils.getFormattedDate(value.eventDetail.start.toString())} - ${DateTimeUtils.getFormattedTime(value.eventDetail.start.toString())} UTC"),
                  const SizedBox(height: 15.0),
                  //end
                  InformationField(
                      value:
                          "${DateTimeUtils.getFormattedDate(value.eventDetail.finish.toString())} - ${DateTimeUtils.getFormattedTime(value.eventDetail.finish.toString())} UTC"),
                  const SizedBox(height: 15.0),
                  //average weight
                  InformationField(value: value.eventDetail.weight.toString()),
                  const SizedBox(height: 15.0),
                  //participants
                  InformationField(
                      value: value.eventDetail.participants.toString()),
                  const SizedBox(height: 15.0),
                  //format
                  InformationField(value: value.eventDetail.format ?? "Format"),
                  const SizedBox(height: 15.0),
                  //mode
                  InformationField(
                      value: value.eventDetail.onsite == true
                          ? "Onsite"
                          : "Online"),
                  const SizedBox(height: 15.0),
                  //location
                  value.eventDetail.location != ""
                      ? InformationField(
                          value: value.eventDetail.location.toString())
                      : SizedBox(),
                ],
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
            Footer(
              backgroundColor: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: StringConstants.openWebsite,
                    onPressed: () async {
                      if (!await launchUrl(
                          Uri.parse(value.eventDetail.url.toString()))) {
                        throw Exception('Could not launch');
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  CustomButton(
                    text: StringConstants.viewOnCtfTimes,
                    onPressed: () async {
                      if (!await launchUrl(
                          Uri.parse(value.eventDetail.ctftimeUrl.toString()))) {
                        throw Exception('Could not launch');
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
