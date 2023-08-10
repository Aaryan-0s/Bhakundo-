import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/favourite/presentation/view/Favourite.dart';
import 'package:nba_hub/features/games/presentation/view/home.dart';
import 'package:nba_hub/features/profile/presentation/view/profile_screen.dart';
import 'package:nba_hub/features/standing/presentation/view/standings.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  int selectIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    List<Widget> lstBottomScreen = [
      const Home(),
      const Standings(),
      const Favourite(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: lstBottomScreen[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            isTablet ? Colors.grey[900] : const Color.fromARGB(255, 9, 8, 8),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon/ball.png',
                width: isTablet ? 48.0 : 32.0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon/stats.png',
                width: isTablet ? 48.0 : 32.0),
            label: 'Standings',
          ),
          BottomNavigationBarItem(
            // icon: Image.asset('assets/icon/heart.png',
            //     width: isTablet ? 48.0 : 32.0),
            icon: SizedBox(
                width: isTablet ? 48.0 : 32.0,
                child: const Icon(
                  CupertinoIcons.star,
                  color: Colors.grey,
                )),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon/user.png',
                width: isTablet ? 48.0 : 32.0),
            label: 'Settings',
          ),
        ],
        currentIndex: selectIndex,
        onTap: (index) {
          setState(
            () {
              selectIndex = index;
            },
          );
        },
      ),
    );
  }
}
