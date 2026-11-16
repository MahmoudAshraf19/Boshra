class ReciterModel {
  final String id;
  final String nameAr;
  final String nameEn;
  final String narrationAr;
  final String narrationEn;

  const ReciterModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.narrationAr,
    required this.narrationEn,
  });
}

// A curated list of high-quality reciters with Sheikh Al-Minshawi as #1 and Default.
const List<ReciterModel> availableReciters = [
  ReciterModel(
    id: 'ar.minshawi', 
    nameAr: 'محمد صديق المنشاوي (مرتل)', 
    nameEn: 'Mohamed Siddiq Al-Minshawi (Murattal)', 
    narrationAr: 'رواية حفص عن عاصم (مرتل)', 
    narrationEn: 'Hafs from Asim (Murattal)'
  ),
  ReciterModel(
    id: 'ar.minshawimujawwad', 
    nameAr: 'محمد صديق المنشاوي (مجود)', 
    nameEn: 'Mohamed Siddiq Al-Minshawi (Mujawwad)', 
    narrationAr: 'رواية حفص عن عاصم (مجود)', 
    narrationEn: 'Hafs from Asim (Mujawwad)'
  ),
  ReciterModel(
    id: 'ar.abdulsamad', 
    nameAr: 'عبد الباسط عبد الصمد (مرتل)', 
    nameEn: 'Abdul Basit (Murattal)', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
  ReciterModel(
    id: 'ar.alafasy', 
    nameAr: 'مشاري راشد العفاسي', 
    nameEn: 'Mishary Alafasy', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
  ReciterModel(
    id: 'ar.husary', 
    nameAr: 'محمود خليل الحصري (مرتل)', 
    nameEn: 'Mahmoud Al-Husary (Murattal)', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
  ReciterModel(
    id: 'ar.husarymujawwad', 
    nameAr: 'محمود خليل الحصري (مجود)', 
    nameEn: 'Mahmoud Al-Husary (Mujawwad)', 
    narrationAr: 'رواية حفص عن عاصم (مجود)', 
    narrationEn: 'Hafs from Asim (Mujawwad)'
  ),
  ReciterModel(
    id: 'ar.mahermuaiqly', 
    nameAr: 'ماهر المعيقلي', 
    nameEn: 'Maher Al Muaiqly', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
  ReciterModel(
    id: 'ar.abdurrahmaansudais', 
    nameAr: 'عبد الرحمن السديس', 
    nameEn: 'Abdul Rahman Al-Sudais', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
  ReciterModel(
    id: 'ar.shaatree', 
    nameAr: 'أبو بكر الشاطري', 
    nameEn: 'Abu Bakr Ash-Shaatree', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
  ReciterModel(
    id: 'ar.ahmedajamy', 
    nameAr: 'أحمد بن علي العجمي', 
    nameEn: 'Ahmed ibn Ali al-Ajamy', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
  ReciterModel(
    id: 'ar.saoodshuraym', 
    nameAr: 'سعود الشريم', 
    nameEn: 'Saood Ash-Shuraym', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
  ReciterModel(
    id: 'ar.hudhaify', 
    nameAr: 'علي بن عبدالرحمن الحذيفي', 
    nameEn: 'Ali Al-Hudhaify', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
  ReciterModel(
    id: 'ar.muhammadayyoub', 
    nameAr: 'محمد أيوب', 
    nameEn: 'Muhammad Ayyub', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
  ReciterModel(
    id: 'ar.muhammadjibreel', 
    nameAr: 'محمد جبريل', 
    nameEn: 'Muhammad Jibreel', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
  ReciterModel(
    id: 'ar.hanirifai', 
    nameAr: 'هاني الرفاعي', 
    nameEn: 'Hani Ar-Rifai', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
  ReciterModel(
    id: 'ar.abdullahbasfar', 
    nameAr: 'عبد الله بصفر', 
    nameEn: 'Abdullah Basfar', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
  ReciterModel(
    id: 'ar.aymanswoaid', 
    nameAr: 'أيمن سويد', 
    nameEn: 'Ayman Sowaid', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
];
