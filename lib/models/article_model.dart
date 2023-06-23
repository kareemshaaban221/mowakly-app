class ArticleModel {
  final String label;
  final String paragraph;
  final String imageUrl;
  final String author;
  final DateTime date;

  ArticleModel(
      {required this.label,
      required this.paragraph,
      required this.imageUrl,
      required this.author,
      required this.date});
}
