enum Category { none, anxious, sleep, kids }

class Audio {
  final String id;
  bool isFavorite;
  bool isDownloaded;
  final String name;
  final String audioUrl;
  final String title;
  final String? img;
  final String? textBeforeDot;
  final String? textAfterDot;
  final Category category;

  Audio({
    required this.id,
    required this.name, 
    required this.audioUrl, 
    required this.title, 
    required this.img, 
    required this.textBeforeDot, 
    required this.textAfterDot, 
    required this.category,
    this.isDownloaded = false, 
    this.isFavorite = false
  });
}