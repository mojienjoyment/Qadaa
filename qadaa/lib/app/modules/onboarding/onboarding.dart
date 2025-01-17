import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qadaa/app/modules/onboarding/onboarding_controller.dart';
import 'package:qadaa/app/shared/widgets/round_button.dart';
import 'package:qadaa/app/shared/widgets/scroll_glow_custom.dart';
import 'package:qadaa/generated/l10n.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  static Container buildDot(int index, int currentPageIndex) {
    return Container(
      height: 10,
      width: currentPageIndex == index ? 25 : 10,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.pink,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
      init: OnBoardingController(),
      builder: (controller) {
        return Scaffold(
          body: ScrollGlowCustom(
            axisDirection: AxisDirection.left,
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: controller.pageList.length,
              itemBuilder: (context, index) {
                return controller.pageList[index];
              },
              onPageChanged: (index) {
                controller.currentPageIndex = index;
                controller.update();
              },
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.pageList.length,
                        (index) => buildDot(
                          index,
                          controller.currentPageIndex,
                        ),
                      ),
                    ),
                  ),
                  if (controller.isFinalPage)
                    RoundButton(
                      radius: 10,
                      text: Text(
                        S.of(context).start,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        controller.goToDashboard();
                      },
                    )
                  else
                    !controller.showSkipBtn
                        ? const SizedBox()
                        : RoundButton(
                            radius: 10,
                            isTransparent: true,
                            text: Text(
                              S.of(context).skip,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              controller.goToDashboard();
                            },
                          ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
