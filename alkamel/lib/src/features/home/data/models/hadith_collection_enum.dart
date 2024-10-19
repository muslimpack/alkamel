enum HadithCollectionEnum {
  sahihBukhari(id: 1, title: "صحيح البخاري", loookupWord: ["بخاري في صحيحه"]),
  sahihMuslim(id: 2, title: "صحيح مسلم", loookupWord: ["مسلم في صحيحه"]),
  malik(id: 3, title: "موطأ مالك", loookupWord: ["مالك في الموطأ"]),
  anNasai(
    id: 4,
    title: "سنن النسائي الصغرى",
    loookupWord: ["روي النسائي في الصغري", "روي النسائي ف السنن الصغري "],
  ),
  ibnKhuzaymah(
    id: 5,
    title: "صحيح ابن خزيمة",
    loookupWord: ["ابن خزيمة في صحيحه"],
  ),
  ibnHibban(id: 6, title: "صحيح ابن حبان", loookupWord: ["ابن حبان في صحيحه"]),
  abuDawood(id: 7, title: "سنن أبي داود", loookupWord: ["داود في سننه"]),

  ///chekc
  atTirmidhi(id: 8, title: "جامع الترمذي", loookupWord: ["الترمذي في سننه"]),
  ibnMajah(id: 9, title: "سنن ابن ماجه", loookupWord: ["ابن ماجة في سننه"]),
  adDarami(id: 10, title: "سنن الدارمي", loookupWord: ["الدارمي في سننه"]),
  ahmad(id: 11, title: "مسند أحمد بن حنبل", loookupWord: ["أحمد في مسنده"]),
  hakim(
    id: 12,
    title: "المستدرك على الصحيحن",
    loookupWord: ["الحاكم في المستدرك"],
  ),
  bayhaqi(
    id: 13,
    title: "سنن البيهقي",

    ///chekc
    loookupWord: ["البيهقي في السنن الكبري"],
  ),
  other(id: 14, title: "أخرى", loookupWord: []),
  ;

  const HadithCollectionEnum({
    required this.id,
    required this.title,
    required this.loookupWord,
  });

  static HadithCollectionEnum fromString(String collectoion) {
    return HadithCollectionEnum.values
            .where((e) => e.title == collectoion)
            .firstOrNull ??
        HadithCollectionEnum.other;
  }

  final int id;
  final String title;
  final List<String> loookupWord;
}
