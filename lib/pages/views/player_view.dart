import 'package:flutter/material.dart';
import 'package:meditation_app/pages/meditate/mediate_music_page.dart';
import 'package:meditation_app/pages/sleep/sleep_play_music_page.dart';
import 'package:meditation_app/pages/views/home_page_view.dart';
import 'package:meditation_app/providers/tab_bar_provider.dart';
import 'package:provider/provider.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/meditate/play_meditate_bg.png"), fit: BoxFit.contain)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Music",
                      style: TextStyle(
                        color: Color(0xff3F414E),
                        fontWeight: FontWeight.bold,
                        fontSize: 28
                      ),
                    ),
                    Text("A wide Gallery of calming music.",
                    textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff3F414E),
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
              SleepIconButtonsRow(highlightLabelColor: Color(0xff3F414E), backgroundColor: Color.fromARGB(255, 243, 225, 192),),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(image: AssetImage("assets/images/sleep/image.png",), fit: BoxFit.cover, colorFilter: ColorFilter.mode(Color.fromARGB(255, 247, 178, 50), BlendMode.lighten))
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("The Good Rest",
                        style: TextStyle(
                          color: Color(0xffF9F0E3),
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                      ),
          
                      Text("Non-stop 8-hour mixes of our \n most popular sleep audio",
                      textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffF9F0E3),
                          fontSize: 16
                        ),
                      ),
          
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Color(0xffEBEAEC)),
                          foregroundColor: WidgetStatePropertyAll(Color(0xff3F414E))
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SleepPlayMusicPage(title: "The Ocean Moon", label: "Non-stop 8-hour mixes of our \n most popular sleep audio",)));
                        },
                        child: Text("START"),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1000,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: [
                    RecommendCard(
                      title: "High Mountains", 
                      color: Color(0xff3F414E), 
                      image: "assets/images/meditate/7_days_calm_bg.png", 
                      titleColor: Color(0xff3F414E), 
                      subtitleColor: Color(0xff3F414E), 
                      textBeforeDot: "45 MIN", 
                      textAfterDot: "CALMP MUSIC",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: "High Mountains"))),
                    ),
                    RecommendCard(
                      title: "Resting Art", 
                      color: Color(0xffF9F0E3), 
                      image: "assets/images/meditate/daily_calm_bg.png", 
                      titleColor: Color(0xff3F414E), 
                      subtitleColor: Color(0xff3F414E), 
                      textBeforeDot: "45 MIN", 
                      textAfterDot: "CALMP MUSIC",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: "Resting Art"))),
                    ),
                    RecommendCard(
                      title: "Good Night", 
                      color: Color(0xff3F414E), 
                      image: "assets/images/meditate/happy_morning.png", 
                      titleColor: Color(0xff3F414E), 
                      subtitleColor: Color(0xff3F414E), 
                      textBeforeDot: "45 MIN", 
                      textAfterDot: "CALMP MUSIC",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: "Good Night"))),
                    ),
                    RecommendCard(
                      title: "Relaxing Beach", 
                      color: Color(0xff3F414E), 
                      image: "assets/images/meditate/surf_waves_bg.png", 
                      titleColor: Color(0xff3F414E), 
                      subtitleColor: Color(0xff3F414E), 
                      textBeforeDot: "45 MIN", 
                      textAfterDot: "CALMP MUSIC",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: "Relaxing Beach"))),
                    ),
                    RecommendCard(
                      title: "High Mountains", 
                      color: Color(0xff3F414E), 
                      image: "assets/images/meditate/7_days_calm_bg.png", 
                      titleColor: Color(0xff3F414E), 
                      subtitleColor: Color(0xff3F414E), 
                      textBeforeDot: "45 MIN", 
                      textAfterDot: "CALMP MUSIC",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: "High Mountains"))),
                    ),
                    RecommendCard(
                      title: "Resting Art", 
                      color: Color(0xffF9F0E3), 
                      image: "assets/images/meditate/daily_calm_bg.png", 
                      titleColor: Color(0xff3F414E), 
                      subtitleColor: Color(0xff3F414E), 
                      textBeforeDot: "45 MIN", 
                      textAfterDot: "CALMP MUSIC",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: "Resting Art"))),
                    ),
                    RecommendCard(
                      title: "Good Night", 
                      color: Color(0xff3F414E), 
                      image: "assets/images/meditate/happy_morning.png", 
                      titleColor: Color(0xff3F414E), 
                      subtitleColor: Color(0xff3F414E), 
                      textBeforeDot: "45 MIN", 
                      textAfterDot: "CALMP MUSIC",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: "Good Night"))),
                    ),
                    RecommendCard(
                      title: "Relaxing Beach", 
                      color: Color(0xff3F414E), 
                      image: "assets/images/meditate/surf_waves_bg.png", 
                      titleColor: Color(0xff3F414E), 
                      subtitleColor: Color(0xff3F414E), 
                      textBeforeDot: "45 MIN", 
                      textAfterDot: "CALMP MUSIC",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: "Relaxing Beach"))),
                    ),
                    RecommendCard(
                      title: "High Mountains", 
                      color: Color(0xff3F414E), 
                      image: "assets/images/meditate/7_days_calm_bg.png", 
                      titleColor: Color(0xff3F414E), 
                      subtitleColor: Color(0xff3F414E), 
                      textBeforeDot: "45 MIN", 
                      textAfterDot: "CALMP MUSIC",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: "High Mountains"))),
                    ),
                    RecommendCard(
                      title: "Resting Art", 
                      color: Color(0xffF9F0E3), 
                      image: "assets/images/meditate/daily_calm_bg.png", 
                      titleColor: Color(0xff3F414E), 
                      subtitleColor: Color(0xff3F414E), 
                      textBeforeDot: "45 MIN", 
                      textAfterDot: "CALMP MUSIC",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: "Resting Art"))),
                    ),
                    RecommendCard(
                      title: "Good Night", 
                      color: Color(0xff3F414E), 
                      image: "assets/images/meditate/happy_morning.png", 
                      titleColor: Color(0xff3F414E), 
                      subtitleColor: Color(0xff3F414E), 
                      textBeforeDot: "45 MIN", 
                      textAfterDot: "CALMP MUSIC",
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: "Good Night"))),
                    ),
                  ],            
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SleepIconButtonsRow extends StatefulWidget {
  const SleepIconButtonsRow({
    super.key, this.backgroundColor = const Color(0xff586894), this.highlightLabelColor = const Color(0xffffffff)
  });
  final Color backgroundColor;
  final Color highlightLabelColor;

  @override
  State<SleepIconButtonsRow> createState() => _SleepIconButtonsRowState();
}

class _SleepIconButtonsRowState extends State<SleepIconButtonsRow> {
  int selectedIndex = 0;

  _changeBackgroundColorOfButton(int index) {
    setState(() {
      selectedIndex = index;
    });

    context.read<TabBarProvider>().changeCurrentSleepView(2);
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 100,
        child: Row(
          spacing: 20,
          children: [
            SizedBox(width: 20,),
            SleepIconButton(backgroundColor: selectedIndex == 0 ? Color(0xff8E97FD) : widget.backgroundColor, text: "All", icon: "assets/images/icons/all_sleep.png", onTap: (value) => _changeBackgroundColorOfButton(0), isSelected: selectedIndex == 0, index: 0, highlightLabelColor: widget.highlightLabelColor,),
            SleepIconButton(backgroundColor: selectedIndex == 1 ? Color(0xff8E97FD) : widget.backgroundColor, text: "My", icon: "assets/images/icons/love_sleep.png", onTap: (value) => _changeBackgroundColorOfButton(1), isSelected: selectedIndex == 1, index: 1, highlightLabelColor: widget.highlightLabelColor,),
            SleepIconButton(backgroundColor: selectedIndex == 2 ? Color(0xff8E97FD) : widget.backgroundColor, text: "Anxious", icon: "assets/images/icons/anxious_sleep.png", onTap: (value) => _changeBackgroundColorOfButton(2), isSelected: selectedIndex == 2, index: 2, highlightLabelColor: widget.highlightLabelColor,),
            SleepIconButton(backgroundColor: selectedIndex == 3 ? Color(0xff8E97FD) : widget.backgroundColor, text: "Sleep", icon: "assets/images/icons/moon_sleep.png", onTap: (value) => _changeBackgroundColorOfButton(3), isSelected: selectedIndex == 3, index: 3, highlightLabelColor: widget.highlightLabelColor,),
            SleepIconButton(backgroundColor: selectedIndex == 4 ? Color(0xff8E97FD) : widget.backgroundColor, text: "Kids", icon: "assets/images/icons/kids_sleep.png", onTap: (value) => _changeBackgroundColorOfButton(4), isSelected: selectedIndex == 4, index: 4, highlightLabelColor: widget.highlightLabelColor,),
          ],
        ),
      ),
    );
  }
}

class SleepIconButton extends StatelessWidget {
  const SleepIconButton({
    super.key, required this.backgroundColor, required this.icon, required this.text, required this.onTap, required this.isSelected, required this.index, this.highlightLabelColor = const Color(0xffffffff),
  });
  final Color backgroundColor;
  final String icon;
  final String text;
  final Function(int) onTap;
  final bool isSelected;
  final int index;
  final Color highlightLabelColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          AnimatedContainer(
            duration: Duration(microseconds: 200),
            width: 60,
            height: 60,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: backgroundColor
            ),
            child: Image.asset(icon, color: Colors.white, width: 24,),
          ),
          Text(text,
          style: TextStyle(
            color: isSelected ? highlightLabelColor : Colors.grey
          ),
          )
        ],
      ),
    );
  }
}