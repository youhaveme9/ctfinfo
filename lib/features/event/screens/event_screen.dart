import 'package:ctfinfo/constants/image_constants.dart';
import 'package:ctfinfo/features/event/provider/event_provider.dart';
import 'package:ctfinfo/features/event/widgets/event_card.dart';
import 'package:ctfinfo/widgets/custom_scaffold.dart';
import 'package:ctfinfo/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatefulWidget {
  static const String id = "/event-screen";
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final _eventProvider = EventProvider();
  @override
  void initState() {
    super.initState();
    _eventProvider.getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ChangeNotifierProvider(
        create: (context) => _eventProvider,
        child: Consumer<EventProvider>(
          builder: (context, eventProvider, child) {
            if (eventProvider.events.isEmpty) {
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: CustomText(
                txtTitle: 'All CTFs',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(ImageConstants.lines),
            const SizedBox(height: 10),
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: value.events.length,
              itemBuilder: (context, index) => EventCard(
                eventName: value.events[index].title ?? 'Event Name',
                imageUrl: (value.events[index].logo) ?? "",
                averageWeight: value.events[index].weight.toString(),
                startDate: value.events[index].start ?? '',
                endDate: value.events[index].finish ?? '',
                eventId: value.events[index].id.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
