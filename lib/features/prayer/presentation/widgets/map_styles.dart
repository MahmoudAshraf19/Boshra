/// Google Maps JSON styles matching the app: warm paper land, soft green parks, teal water,
/// white roads, calm labels, mosques kept visible and business clutter hidden.
const String kLightMapStyle = '''
[
 {"elementType":"geometry","stylers":[{"color":"#f5f1e6"}]},
 {"elementType":"labels.text.fill","stylers":[{"color":"#5b5a4e"}]},
 {"elementType":"labels.text.stroke","stylers":[{"color":"#f5f1e6"}]},
 {"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#c9b99a"}]},
 {"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#e9efd8"}]},
 {"featureType":"poi","stylers":[{"visibility":"off"}]},
 {"featureType":"poi.park","stylers":[{"visibility":"on"}]},
 {"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#cfe3b8"}]},
 {"featureType":"poi.place_of_worship","stylers":[{"visibility":"on"}]},
 {"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},
 {"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},
 {"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#f3d9a3"}]},
 {"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#e0c27c"}]},
 {"featureType":"transit","stylers":[{"visibility":"off"}]},
 {"featureType":"water","elementType":"geometry","stylers":[{"color":"#9ccfd8"}]},
 {"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3b7f8a"}]}
]
''';

const String kDarkMapStyle = '''
[
 {"elementType":"geometry","stylers":[{"color":"#16231d"}]},
 {"elementType":"labels.text.fill","stylers":[{"color":"#a9bdb0"}]},
 {"elementType":"labels.text.stroke","stylers":[{"color":"#16231d"}]},
 {"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#3a5246"}]},
 {"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#1c2d25"}]},
 {"featureType":"poi","stylers":[{"visibility":"off"}]},
 {"featureType":"poi.park","stylers":[{"visibility":"on"}]},
 {"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#21402f"}]},
 {"featureType":"poi.place_of_worship","stylers":[{"visibility":"on"}]},
 {"featureType":"road","elementType":"geometry","stylers":[{"color":"#2b3d34"}]},
 {"featureType":"road","elementType":"labels.icon","stylers":[{"visibility":"off"}]},
 {"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#4a5a3a"}]},
 {"featureType":"transit","stylers":[{"visibility":"off"}]},
 {"featureType":"water","elementType":"geometry","stylers":[{"color":"#0f3a45"}]},
 {"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#6fb3c0"}]}
]
''';
