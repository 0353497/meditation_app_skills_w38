import 'package:flutter/material.dart';
import 'package:meditation_app/models/audio.dart';

class AudioDataProvider extends ChangeNotifier {
  static final AudioDataProvider _instance = AudioDataProvider._internal();
  factory AudioDataProvider() => _instance;
  AudioDataProvider._internal();
  
  final List<Audio> _audioList = [
    Audio(
      id: "sleep_001",
      name: "Night Island",
      audioUrl: "assets/sounds/meditation-music.mp3",
      title: "Night Island",
      img: "assets/images/sleep/moon_clouds.png",
      textBeforeDot: "45 MIN",
      textAfterDot: "SLEEP MUSIC",
      category: Category.sleep,
    ),
    Audio(
      id: "sleep_002",
      name: "Sweet Sleep",
      audioUrl: "assets/sounds/meditation-music.mp3",
      title: "Sweet Sleep",
      img: "assets/images/sleep/sweet_sleep.png",
      textBeforeDot: "45 MIN",
      textAfterDot: "SLEEP MUSIC",
      category: Category.sleep,
    ),
    Audio(
      id: "sleep_003",
      name: "Good Night",
      audioUrl: "assets/sounds/meditation-music.mp3",
      title: "Good Night",
      img: "assets/images/sleep/good_sleep.png",
      textBeforeDot: "45 MIN",
      textAfterDot: "SLEEP MUSIC",
      category: Category.sleep,
    ),
    Audio(
      id: "sleep_004",
      name: "Cloud Pink Moon",
      audioUrl: "assets/sounds/meditation-music.mp3",
      title: "Cloud Pink Moon",
      img: "assets/images/sleep/cloud_pink_moon.png",
      textBeforeDot: "45 MIN",
      textAfterDot: "SLEEP MUSIC",
      category: Category.sleep,
    ),
    Audio(
      id: "meditate_001",
      name: "7 Days of Calm",
      audioUrl: "assets/sounds/meditation-music.mp3",
      title: "7 Days of Calm",
      img: "assets/images/meditate/7_days_calm_bg.png",
      textBeforeDot: "45 MIN",
      textAfterDot: "CALM MUSIC",
      category: Category.none,
    ),
    Audio(
      id: "meditate_002",
      name: "Relaxing Beach",
      audioUrl: "assets/sounds/meditation-music.mp3",
      title: "Relaxing Beach",
      img: "assets/images/meditate/surf_waves_bg.png",
      textBeforeDot: "45 MIN",
      textAfterDot: "CALM MUSIC",
      category: Category.none,
      mainColor: Color(0xffFFDA8C)
    ),
    Audio(
      id: "meditate_003",
      name: "Anxiety Release",
      audioUrl: "assets/sounds/meditation-music.mp3",
      title: "Anxiety Release",
      img: "assets/images/meditate/anxiet_releace_bg.png",
      textBeforeDot: "45 MIN",
      textAfterDot: "CALM MUSIC",
      category: Category.none,
      mainColor: Color(0xffFE9A4F)
    ),
    Audio(
      id: "meditate_004",
      name: "Natural Forrest",
      audioUrl: "assets/sounds/meditation-music.mp3",
      title: "Naturel Forrest",
      img: "assets/images/meditate/calm_bg.png",
      textBeforeDot: "45 MIN",
      textAfterDot: "CALM MUSIC",
      category: Category.none,
      mainColor: Color(0xffD3D265)
    ),
    Audio(
      id: "home_001",
      name: "Focus",
      audioUrl: "assets/sounds/meditation-music.mp3",
      title: "Focus",
      img: "assets/images/home/floating_meditate.png",
      textBeforeDot: "MEDITATION",
      textAfterDot: "3 - 10 MIN",
      category: Category.none,
    ),
    Audio(
      id: "home_002",
      name: "Happiness",
      audioUrl: "assets/sounds/meditation-music.mp3",
      title: "Happiness",
      img: "assets/images/home/floating_meditate_female.png",
      textBeforeDot: "MEDITATION",
      textAfterDot: "3 - 10 MIN",
      category: Category.none,
    ),
    Audio(
      id: "home_003",
      name: "Daily Thought",
      audioUrl: "assets/sounds/meditation-music.mp3",
      title: "Daily Thought",
      img: "assets/images/home/daily_thought_background.png",
      textBeforeDot: "MEDITATION",
      textAfterDot: "3-10 MIN",
      category: Category.none,
    ),
    Audio(
      id: "anxious_001",
      name: "Calm Anxiety",
      audioUrl: "assets/sounds/meditation-music.mp3",
      title: "Calm Anxiety",
      img: "assets/images/sleep/moon_clouds.png",
      textBeforeDot: "20 MIN",
      textAfterDot: "ANXIETY RELIEF",
      category: Category.anxious,
    ),
    Audio(
      id: "kids_001",
      name: "Bedtime Stories",
      audioUrl: "assets/sounds/meditation-music.mp3",
      title: "Bedtime Stories",
      img: "assets/images/sleep/sweet_sleep.png",
      textBeforeDot: "15 MIN",
      textAfterDot: "KIDS SLEEP",
      category: Category.kids,
    ),
  ];
  
  List<Audio> get audioList => _audioList;
  
  List<Audio> get favoriteAudios => _audioList.where((audio) => audio.isFavorite).toList();
  
  List<Audio> getAudiosByCategory(Category category) {
    if (category == Category.none) {
      return _audioList;
    }
    return _audioList.where((audio) => audio.category == category).toList();
  }
  
  Audio? getAudioById(String id) {
    try {
      return _audioList.firstWhere((audio) => audio.id == id);
    } catch (e) {
      return null;
    }
  }
  
  void toggleFavorite(String audioId) {
    final audio = getAudioById(audioId);
    if (audio != null) {
      audio.isFavorite = !audio.isFavorite;
      notifyListeners();
    }
  }
  
  void toggleDownload(String audioId) {
    final audio = getAudioById(audioId);
    if (audio != null) {
      audio.isDownloaded = !audio.isDownloaded;
      notifyListeners();
    }
  }
}