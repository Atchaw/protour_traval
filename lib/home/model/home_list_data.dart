class HomeListData {
  HomeListData({
    this.imagePath = '',
  });

  String imagePath;

  static List<HomeListData> homeList = <HomeListData>[
    HomeListData(
      imagePath: 'assets/adds/ads_4.jpg',
    ),
    HomeListData(
      imagePath: 'assets/adds/ads_5.jpeg',
    ),
    HomeListData(
      imagePath: 'assets/adds/ads_3.jpeg',
    ),
    HomeListData(
      imagePath: 'assets/adds/ads_1.jpeg',
    ),
    HomeListData(
      imagePath: 'assets/adds/ads_2.jpeg',
    ),
  ];
}
