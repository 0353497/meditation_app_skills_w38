import 'package:flutter/material.dart';
import 'package:meditation_app/pages/sign_in_page.dart';
import 'package:meditation_app/pages/sleep/sleep_play_music_page.dart';
import 'package:meditation_app/pages/views/home_page_view.dart';

class SleepHighlightPage extends StatefulWidget {
  const SleepHighlightPage({super.key, required this.image, required this.title, required this.textBeforeDot, required this.textAfterDot});
  final String image;
  final String title;
  final String textBeforeDot;
  final String textAfterDot;
  @override
  State<SleepHighlightPage> createState() => _SleepHighlightPageState();
}

class _SleepHighlightPageState extends State<SleepHighlightPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      backgroundColor: Color(0xff03174C),
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
          TopRightStackButtons(),
          Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Image.asset(widget.image, fit: BoxFit.cover, width: MediaQuery.of(context).size.width,),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: [
                        Text(widget.title, 
                        style: TextStyle(
                          color: Color(0xffE6E7F2),
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                        ),
                        Text.rich(
                          TextSpan(text: "${widget.textBeforeDot}  ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 11
                          ),
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey
                              ),
                            )
                            ),
                            TextSpan(
                              text: " ${widget.textAfterDot}",
                              style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500
                              )
                            )
                          ]
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
                                  Icon(Icons.favorite, color: Colors.white,),
                                  Text("24.234 Favorites",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                    ),
                                  )
                                ],
                              ),
                               Row(
                                spacing: 10,
                                children: [
                                  Icon(Icons.headphones, color: Colors.white,),
                                  Text("34.234 Listening",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Color(0xff98A1BD),
                        ),
                      const Text("Related", 
                          style: TextStyle(
                            color: Color(0xffE6E7F2),
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RecommendCard(title: "Moon Clouds", color: Color(0xff3F414E), image: "assets/images/sleep/good_sleep.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                            RecommendCard(title: "Sweet Sleep", color: Color(0xff3F414E), image: "assets/images/sleep/sweet_sleep.png", titleColor: Color(0xffE6E7F2), subtitleColor: Color(0xffE6E7F2), textBeforeDot: "45 MIN", textAfterDot: "SLEEP MUISIC",),
                          ],
                        ),
                        OwnTextButton(
                          text: "play",
                          callback: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SleepPlayMusicPage(title: widget.title, label: widget.textAfterDot,))) ,
                          backgroundColor: Color(0XFF8E97FD),)
                      ],
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}