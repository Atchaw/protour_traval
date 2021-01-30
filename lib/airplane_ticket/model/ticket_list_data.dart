class TecketListData {
  TecketListData({
    this.imagePath = '',
    this.timeDept = '',
    this.timeArr = '',
    this.timeTrip = '',
    this.prix = 120,
    this.airportDep = '',
    this.airportArr = '',
    this.voleType = 'One way',
    this.voleClass = 'Ecomomic',
    this.voleStop = 'NoStop',
    this.airportStop = '',
  });
  String imagePath;
  String timeDept;
  String timeArr;
  String timeTrip;
  int prix;
  String airportDep;
  String airportArr;
  String voleType;
  String voleClass;
  String voleStop;
  String airportStop;

  static List<TecketListData> hotelList = <TecketListData>[
    TecketListData(
      imagePath: 'assets/vole/alitalia.png',
      timeDept: '10:00',
      timeArr: '15:00',
      timeTrip: '5',
      prix: 120,
      airportDep: 'CDG',
      airportArr: 'LND',
      voleType: 'One way',
      voleClass: 'Ecomomic',
      voleStop: 'NoStop',
      airportStop: '',
    ),
    TecketListData(
      imagePath: 'assets/vole/british.png',
      timeDept: '10:00',
      timeArr: '15:00',
      timeTrip: '5',
      prix: 120,
      airportDep: 'CDG',
      airportArr: 'LND',
      voleType: 'One way',
      voleClass: 'Ecomomic',
      voleStop: 'NoStop',
      airportStop: '',
    ),
    TecketListData(
      imagePath: 'assets/vole/qatar.png',
      timeDept: '10:00',
      timeArr: '15:00',
      timeTrip: '5',
      prix: 120,
      airportDep: 'CDG',
      airportArr: 'LND',
      voleType: 'One way',
      voleClass: 'Ecomomic',
      voleStop: 'NoStop',
      airportStop: '',
    ),
    TecketListData(
      imagePath: 'assets/vole/etihad.png',
      timeDept: '10:00',
      timeArr: '15:00',
      timeTrip: '5',
      prix: 120,
      airportDep: 'CDG',
      airportArr: 'LND',
      voleType: 'One way',
      voleClass: 'Ecomomic',
      voleStop: 'NoStop',
      airportStop: '',
    ),
    TecketListData(
      imagePath: 'assets/vole/lufthansa.png',
      timeDept: '10:00',
      timeArr: '15:00',
      timeTrip: '5',
      prix: 120,
      airportDep: 'CDG',
      airportArr: 'LND',
      voleType: 'One way',
      voleClass: 'Ecomomic',
      voleStop: 'NoStop',
      airportStop: '',
    ),
    TecketListData(
      imagePath: 'assets/vole/norwegian.png',
      timeDept: '10:00',
      timeArr: '15:00',
      timeTrip: '5',
      prix: 120,
      airportDep: 'CDG',
      airportArr: 'LND',
      voleType: 'One way',
      voleClass: 'Ecomomic',
      voleStop: 'NoStop',
      airportStop: '',
    ),
  ];
}
