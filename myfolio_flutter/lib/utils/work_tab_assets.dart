/// Project background images shown in [WorkTab] / [ProjectShowcase].
const Map<String, String> workTabProjectImageByTitle = {
  'Market Intelligence Platform': 'assets/images/news.webp',
  'Freight & Logistics Suite': 'assets/images/logistic.webp',
  'HealthVitals Tracker': 'assets/images/health.webp',
  'Social Engagement Platform': 'assets/images/social.webp',
  'E-Commerce Marketplace': 'assets/images/shopping.webp',
};

/// All WorkTab images to warm the Flutter image cache at startup.
const List<String> workTabProjectImages = [
  'assets/images/news.webp',
  'assets/images/logistic.webp',
  'assets/images/health.webp',
  'assets/images/social.webp',
  'assets/images/shopping.webp',
];

String workTabImageForTitle(String title) {
  return workTabProjectImageByTitle[title] ??
      'assets/images/${title.toLowerCase().replaceAll(' ', '_')}.webp';
}
