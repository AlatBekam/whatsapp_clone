import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/loading_controller.dart';
import 'package:whatsapp_clone/controllers/status_controller.dart';
import 'package:whatsapp_clone/pages/status/add_status_image.dart';
import 'package:whatsapp_clone/pages/status/add_status_text.dart';

enum StatusType { video, image, text, audio, noType }

class addStatus extends StatefulWidget {
  const addStatus({super.key});

  @override
  _addStatusState createState() => _addStatusState();
}

class _addStatusState extends State<addStatus>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  StatusType _statusType = StatusType.noType; // default;

  late TabController _tabController;
  int _selectedModeIndex = 2;

  final List<Map<String, dynamic>> _modes = [
    {'name': 'Video'},
    {'name': 'Gambar'},
    {'name': 'Text'},
    {'name': 'Audio'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _modes.length,
      vsync: this,
      initialIndex: _selectedModeIndex,
    );
    _tabController.addListener(() {
      setState(() {
        _selectedModeIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: TabBarView(
                  controller: _tabController,
                  physics: _statusType == StatusType.noType
                      ? null
                      : const NeverScrollableScrollPhysics(),
                  children: [
                    // UI untuk Video
                    Center(
                      child: Text(
                        "Video UI",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    // UI untuk Gambar
                    addStatusImage(context, _imageController, (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          _statusType = StatusType.image;
                        } else {
                          _statusType = StatusType.noType;
                        }
                      });
                    }),
                    // UI untuk Text
                    addStatusText(context, _textController, (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          _statusType = StatusType.text;
                        } else {
                          _statusType = StatusType.noType;
                        }
                      });
                    }),
                    // UI untuk Audio
                    Center(
                      child: Text(
                        "Audio UI",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 300,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: switch (_statusType) {
                      StatusType.noType => Container(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        height: 60,
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabAlignment: TabAlignment.center,
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width / 2 - 30,
                          ),
                          labelPadding: EdgeInsets.zero,
                          indicator: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          unselectedLabelColor: Theme.of(
                            context,
                          ).colorScheme.onSecondary,
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          unselectedLabelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          tabs: List.generate(_modes.length, (index) {
                            final item = _modes[index];
                            return AnimatedBuilder(
                              animation: _tabController,
                              builder: (context, child) {
                                return Tab(
                                  height: 30,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 6,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(item['name'] as String),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ),
                      StatusType.text => Container(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        height: 60,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      spacing: 5,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/logopembaruan.svg',
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                          width: 20,
                                          height: 20,
                                        ),

                                        Text(
                                          'Status (10 Excluded)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Obx(() {
                                switch (loadingController.dataState(
                                  Keys.dataFeatureStatusState,
                                )) {
                                  case DataState.loading:
                                    return Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                        ),
                                      ),
                                    );
                                  case DataState.empty:
                                    return Center(child: Text("EMPTY"));
                                  case DataState.error:
                                    return Center(child: Text("ERROR"));
                                  case DataState.success:
                                    return GestureDetector(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          bool success = await controllerStatus
                                              .addStatus(_textController.text);

                                          if (success) {
                                            Get.back(result: true);
                                          }
                                        }
                                      },

                                      child: Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            'assets/svg/paper-plane-right.svg',
                                            width: 20,
                                            height: 20,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSecondary,
                                          ),
                                        ),
                                      ),
                                    );
                                }
                              }),
                            ],
                          ),
                        ),
                      ),
                      // TODO: Handle this case.
                      StatusType.video => throw UnimplementedError(),
                      // TODO: Handle this case.
                      StatusType.image => Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 50,
                            padding: EdgeInsets.only(bottom: 5),
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: _imageController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  hintText: 'Add a caption...',
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer,
                              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                          borderRadius: BorderRadius.circular(
                                            35,
                                          ),
                                        ),
                                        padding: EdgeInsets.fromLTRB(
                                          10,
                                          0,
                                          10,
                                          0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          spacing: 5,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/logopembaruan.svg',
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSecondary,
                                              width: 20,
                                              height: 20,
                                            ),

                                            Text(
                                              'Status (10 Excluded)',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    color: Colors.white,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  Obx(() {
                                    switch (loadingController.dataState(
                                      Keys.dataFeatureStatusState,
                                    )) {
                                      case DataState.loading:
                                        return Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.secondary,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSecondary,
                                            ),
                                          ),
                                        );
                                      case DataState.empty:
                                        return Center(child: Text("EMPTY"));
                                      case DataState.error:
                                        return Center(child: Text("ERROR"));
                                      case DataState.success:
                                        return GestureDetector(
                                          onTap: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              bool success =
                                                  await controllerStatus
                                                      .addStatus(
                                                        _imageController.text,
                                                        controllerStatus.image,
                                                      );

                                              if (success) {
                                                Get.back(result: true);
                                              }
                                            }
                                          },

                                          child: Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                'assets/svg/paper-plane-right.svg',
                                                width: 20,
                                                height: 20,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSecondary,
                                              ),
                                            ),
                                          ),
                                        );
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // TODO: Handle this case.
                      StatusType.audio => throw UnimplementedError(),
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
