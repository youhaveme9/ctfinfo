import 'dart:convert';

import 'package:ctfinfo/features/resources/widgets/resource_card.dart';
import 'package:ctfinfo/widgets/custom_heading.dart';
import 'package:ctfinfo/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResourcesScreen extends StatefulWidget {
  static const String id = "/resources-screen";
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  List _resourceData = [];
  Future<void> _loadData(String path, List items) async {
    final String data = await rootBundle.loadString(path);
    final jsonData = jsonDecode(data);

    setState(() {
      _resourceData = jsonData;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData("assets/data/resources.json", _resourceData);
  }

  @override
  Widget build(BuildContext context) {
    return _resourceData.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : _buildUI();
  }

  CustomScaffold _buildUI() {
    return CustomScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeading(title: "Resources"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _resourceData.length,
                  itemBuilder: (context, index) {
                    return ResourceCard(
                      title: _resourceData[index]["name"],
                      description: _resourceData[index]["description"],
                      url: _resourceData[index]["url"],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
