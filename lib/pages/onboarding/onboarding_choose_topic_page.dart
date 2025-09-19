import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meditation_app/models/topic.dart';
import 'package:meditation_app/pages/onboarding/onboarding_reminders_page.dart';
import 'package:meditation_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class OnboardingChooseTopicPage extends StatefulWidget {
  const OnboardingChooseTopicPage({super.key});

  @override
  State<OnboardingChooseTopicPage> createState() => _OnboardingChooseTopicPageState();
}

class _OnboardingChooseTopicPageState extends State<OnboardingChooseTopicPage> {
  final List<Topic> topics = [
    Topic(200, containerColor: Color(0xff808AFF), text: "Reduce Stress", image: "assets/images/topic/yoga_stress.png", isDarktext: false),
    Topic(160, containerColor: Color(0xffFEB18F), text: "Increase Happines", image: "assets/images/topic/emoji_happiness.png", isDarktext: true),
    Topic(200, containerColor: Color(0xff6CB28E), text: "Personal Growth", image: "assets/images/topic/mountain_growth.png", isDarktext: false),
    Topic(200, containerColor: Color(0xff808AFF), text: "Reduce Stress", image: "assets/images/topic/yoga_stress.png", isDarktext: false),
    Topic(180, containerColor: Color(0xffF05D48), text: "Improve Performance", image: "assets/images/topic/desk_preformance.png", isDarktext: false),
    Topic(220, containerColor: Color(0xffFFCF86), text: "Reduce Anxiety", image: "assets/images/topic/anxiety.png", isDarktext: true),
    Topic(160, containerColor: Color(0xff4E5567), text: "Better Sleep", image: "assets/images/topic/bed_sleep.png", isDarktext: false),
    Topic(220, containerColor: Color(0xffD9A5B5), text: "Reduce Stress", image: "assets/images/topic/desk_female.png", isDarktext: false),
  ];

  Set<int> selectedTopics = {};

  void toggleTopicSelection(int index) {
    setState(() {
      if (selectedTopics.contains(index)) {
        selectedTopics.remove(index);
      } else {
        selectedTopics.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        floatingActionButton: selectedTopics.isNotEmpty ? FloatingActionButton(
          backgroundColor: Color(0xff808AFF),
          foregroundColor: Colors.white,
          child: Icon(Icons.check),  
          onPressed: () {
      
            for (var index in selectedTopics) {
                final topic = topics[index];
                context.read<UserProvider>().addGoal(topic.text);
                }
      
            Navigator.push(context, MaterialPageRoute(builder: (_) => OnboardingRemindersPage()));
          }
        ) : null,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Align(
              alignment: Alignment(0, .8),
              child: Image.asset("assets/images/topic/topic_bg.png",color: Color(0xffF2F2F2),)),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text("What brings you", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 32),),
                        Text("To Focus Skills?", style: TextStyle(color: Colors.black, fontSize: 32),),
                        Text("chose a topic to focus on:", style: TextStyle(color: Colors.grey, fontSize: 20),),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: 1000,
                          child: Wrap(
                            direction: Axis.vertical,
                            spacing: 20,
                            runSpacing: 20,
                            children: List.generate(topics.length, (index) {
                              return SizedBox(
                                width: (MediaQuery.of(context).size.width - 80) / 2, 
                                child: TopicContainer(
                                  text: topics[index].text,
                                  height: topics[index].height,
                                  containerColor: topics[index].containerColor,
                                  image: topics[index].image,
                                  isDarktext: topics[index].isDarktext,
                                  isSelected: selectedTopics.contains(index),
                                  onTap: () => toggleTopicSelection(index),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopicContainer extends StatelessWidget {
  const TopicContainer({
    super.key, 
    required this.containerColor, 
    required this.image, 
    this.isDarktext = false, 
    this.height = 200, 
    required this.text,
    required this.isSelected,
    required this.onTap,
  });
  
  final Color containerColor;
  final String image;
  final bool isDarktext;
  final double height;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border: 
          isSelected ?
          Border.all(width: 5, color: Colors.black)
          : null,

          color: containerColor,
          gradient: 
          text == "Better Sleep" ?
          LinearGradient(
            transform: GradientRotation(pi /2),
            stops: [
              0.4,
              0.4,
              0.5
            ],
            colors: [
            Color(0xff4E5567),
            Color(0xff3F414E),
            Color(0xff3F414E)
          ]
          ) : null,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.scale(
                scale: text == "Better Sleep" ? 1.3 : 1,
                child: Image.asset(image,),
                ),
              Text(text, 
              style: TextStyle(
                color: 
                isDarktext ? Color(0xff3F414E) :  Color(0xffFEF9F3),
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}