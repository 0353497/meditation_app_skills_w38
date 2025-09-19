import 'package:flutter/material.dart';
import 'package:meditation_app/models/mediations.dart';
import 'package:meditation_app/pages/meditate/mediate_music_page.dart';
import 'package:meditation_app/pages/sleep/sleep_play_music_page.dart';

class MeditateHighlitePage extends StatefulWidget {
  const MeditateHighlitePage({super.key, required this.mediation});
  final Mediations mediation;
  @override
  State<MeditateHighlitePage> createState() => _MeditateHighlitePageState();
}

class _MeditateHighlitePageState extends State<MeditateHighlitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: IconButton(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Color(0xff3F414E)),
          backgroundColor: WidgetStatePropertyAll(Color(0xffE6E7F2))
        ),
      onPressed: () => Navigator.pop(context),
      icon:Icon(Icons.arrow_back),
      ),
      body: Stack(
        children: [
          Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Image.asset("assets/images/meditate/happy_morning.png", fit: BoxFit.cover, width: MediaQuery.of(context).size.width,),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: [
                        Text(widget.mediation.title, 
                        style: TextStyle(
                          color: Color(0xff3F414E),
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                        ),
                        Text("COURSE", 
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                          ),
                        ),

                        Text("Ease the mind into a restful night's sleep with these deep, amblent tones.",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                spacing: 10,
                                children: [
                                  Icon(Icons.favorite, color: Colors.redAccent,),
                                  Text("24.234 Favorites",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                    ),
                                  )
                                ],
                              ),
                               Row(
                                spacing: 10,
                                children: [
                                  Icon(Icons.headphones, color: Colors.lightBlueAccent,),
                                  Text("34.234 Listening",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      const Text("Pick a narrator", 
                          style: TextStyle(
                            color: Color(0xff3F414E),
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                        Expanded(
                          child: DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: TabBar(tabs: [
                                    Tab(text: "MALE VOICE",),
                                    Tab(text: "FEMALE VOICE",)
                                  ]),
                                ),
                                Expanded(
                                  child: TabBarView(children: 
                                  [
                                    ListView(
                                      padding: EdgeInsets.only(top: 20),
                                      children: [
                                        PlayListTile(backgroundColor: Color(0xff8E97FD), foregroundColor: Color(0xffF6F1FB), title: "Focus Attention", label: "10 MIN"),
                                        PlayListTile(title: "Body Scan", label: "5 MIN"),
                                        PlayListTile(title: "Makin Happiness", label: "3 MIN"),
                                        PlayListTile(title: "Focus Attention", label: "10 MIN"),
                                        PlayListTile(title: "Focus Attention", label: "10 MIN"),
                                        PlayListTile(title: "Focus Attention", label: "10 MIN"),
                                      ],
                                    ),
                                    ListView(
                                      padding: EdgeInsets.only(top: 20),
                                      children: [
                                        PlayListTile(backgroundColor: Color(0xff8E97FD), foregroundColor: Color(0xffF6F1FB), title: "Focus Attention", label: "10 MIN"),
                                        PlayListTile(title: "Body Scan", label: "5 MIN"),
                                        PlayListTile(title: "Makin Happiness", label: "3 MIN"),
                                        PlayListTile(title: "Focus Attention", label: "10 MIN"),
                                        PlayListTile(title: "Focus Attention", label: "10 MIN"),
                                        PlayListTile(title: "Focus Attention", label: "10 MIN"),
                                      ],
                                    ),
                                  ]
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Align(
            alignment: Alignment(.9, -.86),
            child: TopRightStackButtons()
            )
        ],
      ),
    );
  }
}

class PlayListTile extends StatelessWidget {
  const PlayListTile({
    super.key,  this.foregroundColor = Colors.grey, this.backgroundColor = Colors.white, required this.title, required this.label,
  });
  final Color foregroundColor;
  final Color backgroundColor;
  final String title;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: title))),
      shape: Border(bottom: BorderSide(
        color: Colors.grey.withAlpha(100),
        width: 1
      )),
      title: Text(title),
      subtitle: Text(label),
      leading: IconButton.outlined(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(foregroundColor),
          backgroundColor: WidgetStatePropertyAll(backgroundColor)
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => MeditateMusicPage(title: title)));
        },
      tooltip: "10 MIN",
      icon: Icon(Icons.play_arrow)
      ),
    );
  }
}