
import 'package:flutter/material.dart';
import 'package:meditation_app/pages/views/home_page_view.dart';
import 'package:meditation_app/pages/views/meditate_view.dart';
import 'package:meditation_app/pages/views/player_view.dart';
import 'package:meditation_app/pages/views/profile_view.dart';
import 'package:meditation_app/pages/views/sleep_view.dart';
import 'package:meditation_app/providers/tab_bar_provider.dart';
import 'package:meditation_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: _tabController.index != 1 ? null : Color(0xff03174C),
        bottomNavigationBar: 
        context.watch<TabBarProvider>().showSnackbar ?
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: _tabController.index != 1 ? Colors.transparent : Color(0xff03174C),
            boxShadow: [
              BoxShadow(
                color: _tabController.index != 1 ? Colors.black12 : Color(0xff03174C),
                blurRadius: 15,
                blurStyle: BlurStyle.outer
              )
            ]
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: const Color(0xff8E97FD),
              borderRadius: BorderRadius.circular(16),
            ),
            indicatorPadding: EdgeInsetsGeometry.only(top: 10, bottom: 34, left: 0, right: 0),
            indicatorColor: Colors.white,
            labelColor: _tabController.index  != 1 ? const Color(0xff8E97FD) : Colors.white,
            unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(iconMargin: EdgeInsets.all(4), icon: Icon(Icons.house_outlined, color: _tabController.index == 0 ? Colors.white : null,), text: "Home",),
                Tab(iconMargin: EdgeInsets.all(4), icon: Icon(Icons.bedtime_outlined, color: _tabController.index == 1 ? Colors.white : null,), text: "Sleep",),
                Tab(iconMargin: EdgeInsets.all(4), icon: Image.asset("assets/images/home/meditate_icon.png", width: 24, color: _tabController.index == 2 ? Colors.white : null,), text: "Meditate",),
                Tab(iconMargin: EdgeInsets.all(4), icon: Image.asset("assets/images/home/music_notes_icon.png", width: 24, color: _tabController.index == 3 ? Colors.white : null,), text: "Music",),
                Tab(iconMargin: EdgeInsets.all(4), icon: Image.asset("assets/images/home/person_icon.png", width: 24, color: _tabController.index == 4 ? Colors.white : null,), text: context.watch<UserProvider>().username,),
              ],
          ),
        ) : null,
      body: SafeArea(
        top: _tabController.index == 0,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  HomePageView(),
                  SleepView(),
                  MeditateView(),
                  PlayerView(),
                  ProfileView()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
