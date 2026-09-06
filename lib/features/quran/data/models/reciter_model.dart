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

// A curated list of high-quality reciters supported by api.alquran.cloud (type: versebyverse)
const List<ReciterModel> availableReciters = [
  ReciterModel(
    id: 'ar.abdulsamad', 
    nameAr: 'عبد الباسط عبد الصمد', 
    nameEn: 'Abdul Basit', 
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
    nameAr: 'محمود خليل الحصري', 
    nameEn: 'Mahmoud Al-Husary', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
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
    id: 'ar.aymanswoaid', 
    nameAr: 'أيمن سويد', 
    nameEn: 'Ayman Sowaid', 
    narrationAr: 'رواية حفص عن عاصم', 
    narrationEn: 'Hafs from Asim'
  ),
];
