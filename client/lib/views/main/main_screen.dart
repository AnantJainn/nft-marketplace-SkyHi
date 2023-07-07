import 'package:animate_icons/animate_icons.dart';
import 'package:camera/camera.dart';
import 'package:client/controllers/main_screen_controller.dart';
import 'package:client/controllers/nft_controller.dart';
import 'package:client/controllers/wallet_controller.dart';
import 'package:client/controllers/welcome_controller.dart';
import 'package:client/themes/app_colors.dart';
import 'package:client/utils/size_config.dart';
import 'package:client/views/main/discover_page.dart';
// import 'package:client/views/main/favorite_page.dart';
// import 'package:client/views/main/profile_page.dart';
// import 'package:client/views/main/search_page.dart';
import 'package:client/views/welcome/welcome_page.dart';
// import 'package:client/widgets/bottom_bar.dart';
import 'package:client/widgets/custom_glassmorphic_container.dart';
import 'package:client/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends GetView<MainScreenController> {
  MainScreen({Key? key}) : super(key: key);
  // String selectedImageUrl = '';


  final pages = <Widget>[
    DiscoverPage(),
    // if (selectedImageUrl != null) ProfilePage(imageUrl: selectedImageUrl),
    // // ProfilePage(imageUrl: '',),
    // ProfilePage(
    //     imageUrl:
    //         ''), // Provide a valid URL

    // ProfilePage(user: Get.arguments),
  ];
  
  static get selectedImageUrl => null;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(
      () => (WelcomeController.to.account != '' ||
              WalletController.to.publicAdr != '')
          ? Scaffold(
              extendBody: true,
              backgroundColor: Color.fromARGB(0, 220, 19, 19),
              body: Stack(
                children: [
                  pages[controller.tabIndex],
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Visibility(
                        visible: controller.openModal,
                        child: CustomGlassmorphicContainer(
                          height: SizeConfig.safeVertical! * 0.3,
                          width: SizeConfig.safeHorizontal! * 0.9,
                          widget: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // bottomNavigationBar: BottomBar(
              //   index: controller.tabIndex,
              //   onChangedTab: controller.changeTabIndex,
              // ),
              
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            )
          : const WelcomePage(),
    );
  }
}
