import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class AudioState {
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final String? currentTrack;

  AudioState({
    required this.isPlaying,
    required this.position,
    required this.duration,
    this.currentTrack,
  });
}

class AudioService extends ChangeNotifier {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  AudioPlayer? _audioPlayer;
  BehaviorSubject<AudioState>? _audioStateSubject;
  StreamSubscription? _streamSubscription;
  String? _currentTrack;
  
  AudioPlayer get audioPlayer {
    _audioPlayer ??= AudioPlayer();
    return _audioPlayer!;
  }

  Stream<AudioState> get audioStateStream {
    if (_audioStateSubject == null || _audioStateSubject!.isClosed) {
      _setupAudioStream();
    }
    return _audioStateSubject!.stream;
  }

  String? get currentTrack => _currentTrack;

  Future<void> loadTrack(String assetPath, {String? trackTitle}) async {
    try {
      if (_currentTrack == assetPath && _audioPlayer != null && !_audioStateSubject!.isClosed) {
        return;
      }

      await _disposeAudioPlayer();
      _audioPlayer = AudioPlayer();
      
      await audioPlayer.setAsset(assetPath);
      _currentTrack = assetPath;
      
      _setupAudioStream();
      
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading audio: $e");
    }
  }

  Future<void> _disposeAudioPlayer() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
    
    _audioStateSubject?.close();
    _audioStateSubject = null;
    
    await _audioPlayer?.dispose();
    _audioPlayer = null;
    notifyListeners();
  }

  void _setupAudioStream() {
    _streamSubscription?.cancel();
    
    _audioStateSubject = BehaviorSubject<AudioState>.seeded(
      AudioState(
        isPlaying: false,
        position: Duration.zero,
        duration: Duration.zero,
        currentTrack: _currentTrack,
      ),
    );
    
    final combinedStream = CombineLatestStream.combine3(
      audioPlayer.playerStateStream.map((state) => state.playing),
      audioPlayer.positionStream,
      audioPlayer.durationStream.map((duration) => duration ?? Duration.zero),
      (bool isPlaying, Duration position, Duration duration) => AudioState(
        isPlaying: isPlaying,
        position: position,
        duration: duration,
        currentTrack: _currentTrack,
      ),
    );
    
    _streamSubscription = combinedStream.listen(
      (audioState) {
        final subject = _audioStateSubject;
        if (subject != null && !subject.isClosed) {
          subject.add(audioState);
        }
      },
      onError: (error) {
        debugPrint("Audio stream error: $error");
      },
    );
  }

  Future<void> togglePlayPause() async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }
  }

  Future<void> pause() async {
    await audioPlayer.pause();
  }

  Future<void> play() async {
    await audioPlayer.play();
  }

  Future<void> seek(Duration position) async {
    await audioPlayer.seek(position);
  }

  void seekBackward({int seconds = 15}) {
    final currentPosition = audioPlayer.position;
    final newPosition = currentPosition - Duration(seconds: seconds);
    audioPlayer.seek(newPosition < Duration.zero ? Duration.zero : newPosition);
  }

  void seekForward({int seconds = 15}) {
    final currentPosition = audioPlayer.position;
    final duration = audioPlayer.duration ?? Duration.zero;
    final newPosition = currentPosition + Duration(seconds: seconds);
    audioPlayer.seek(newPosition > duration ? duration : newPosition);
  }

  Future<void> stop() async {
    await audioPlayer.stop();
    await audioPlayer.clearAudioSources();
    _currentTrack = null;
    
    _audioStateSubject?.close();
    _audioStateSubject = null;
    
    notifyListeners();
  }

  Future<void> switchTrack(String assetPath, {String? trackTitle}) async {
    await loadTrack(assetPath, trackTitle: trackTitle);
  }

  @override
  void dispose() {
    _audioStateSubject?.close();
    _audioPlayer?.dispose();
    super.dispose();
  }
}