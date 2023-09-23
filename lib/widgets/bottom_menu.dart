import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:fisioflex_mobile/core/notifications/notification_service.dart';
import 'package:fisioflex_mobile/features/home/pages/main_home_page.dart';
import 'package:fisioflex_mobile/features/profile/pages/main_profile_page.dart';
import 'package:fisioflex_mobile/features/task/pages/main_task_page.dart';
import 'package:flutter/material.dart';

class BottomMenu extends StatefulWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);
  //final NotificationService _notificationService = NotificationService();

  final List<Widget> pages = [
    const MainHomePage(),
    MainTaskPage(),
    MainProfilePage()
  ];

  @override
  void initState() {
    //_notificationService.getPermission();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: AnimatedNotchBottomBar(
          notchBottomBarController: _controller,
          removeMargins: false,
          bottomBarWidth: 500,
          notchColor: Theme.of(context).colorScheme.primary,
          color: Theme.of(context).colorScheme.background,
          durationInMilliSeconds: 300,
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: Icon(Icons.home,
                  color: Theme.of(context).colorScheme.secondary),
              activeItem: Icon(
                Icons.home_outlined,
                color: Theme.of(context).colorScheme.background,
              ),
              itemLabel: 'Inicio',
            ),
            BottomBarItem(
              inActiveItem: Icon(Icons.add_box,
                  color: Theme.of(context).colorScheme.secondary),
              activeItem: Icon(
                Icons.add_box_outlined,
                color: Theme.of(context).colorScheme.background,
              ),
              itemLabel: 'Tareas',
            ),
            BottomBarItem(
              inActiveItem: Icon(Icons.person,
                  color: Theme.of(context).colorScheme.secondary),
              activeItem: Icon(
                Icons.person_outline,
                color: Theme.of(context).colorScheme.background,
              ),
              itemLabel: 'Perfil',
            ),
          ],
          onTap: (int value) {
            _pageController.animateToPage(value,
                duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          },
        ),
        extendBody: true,
        body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              pages.length,
              (index) => pages[index],
            )));
  }
}
