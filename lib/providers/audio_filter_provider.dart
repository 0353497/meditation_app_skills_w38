import 'package:flutter/material.dart';
import 'package:meditation_app/models/audio.dart';
import 'package:meditation_app/providers/audio_data_provider.dart';

enum FilterType { all, favorites, anxious, sleep, kids }

class AudioFilterProvider extends ChangeNotifier {
  FilterType _currentFilter = FilterType.all;
  final AudioDataProvider _audioDataProvider = AudioDataProvider();

  FilterType get currentFilter => _currentFilter;

  void setFilter(FilterType filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  List<Audio> getFilteredAudios() {
    switch (_currentFilter) {
      case FilterType.all:
        return _audioDataProvider.audioList;
      case FilterType.favorites:
        return _audioDataProvider.favoriteAudios;
      case FilterType.anxious:
        return _audioDataProvider.getAudiosByCategory(Category.anxious);
      case FilterType.sleep:
        return _audioDataProvider.getAudiosByCategory(Category.sleep);
      case FilterType.kids:
        return _audioDataProvider.getAudiosByCategory(Category.kids);
    }
  }

  List<Audio> getFilteredMeditateAudios() {
    final baseAudios = _audioDataProvider.audioList
        .where((audio) => audio.id.startsWith('meditate_'))
        .toList();
    
    switch (_currentFilter) {
      case FilterType.all:
        return baseAudios;
      case FilterType.favorites:
        return baseAudios.where((audio) => audio.isFavorite).toList();
      case FilterType.anxious:
        return baseAudios.where((audio) => audio.category == Category.anxious).toList();
      case FilterType.sleep:
        return baseAudios.where((audio) => audio.category == Category.sleep).toList();
      case FilterType.kids:
        return baseAudios.where((audio) => audio.category == Category.kids).toList();
    }
  }
}