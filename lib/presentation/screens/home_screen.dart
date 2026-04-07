import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/presentation/components/pose_card.dart';
import '/presentation/components/yoga_space.dart';
import '/presentation/cubit/user_status_cubit.dart';
import '/presentation/screens/sanskrit_screen.dart';
import '/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<UserStatusCubit, int>(
            builder: (context, stage) {
              return Column(
                children: [
                  YogaSpace(
                    stage: stage,
                    height: screenSize.height * 0.3,
                    width: screenSize.width,
                  ),
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            onTap: (_) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                            tabs: [
                              Tab(text: 'puzzle'.tr()),
                              Tab(text: 'sanskrit'.tr()),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                GridView.builder(
                                  padding: const EdgeInsets.all(16),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 12,
                                      ),
                                  itemCount: context.list.length,
                                  itemBuilder: (context, index) {
                                    final pose = context.list[index];
                                    return PoseCard(
                                      currentStage: stage,
                                      pose: pose,
                                    );
                                  },
                                ),
                                SanskritScreen(
                                  asanaList: context.list,
                                  sanskritList: context.sansList,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
