class LifePath {
  final String number;
  final String meaning;

  LifePath(this.number, this.meaning);

  LifePath.fromJson(Map<dynamic, dynamic> json)
      : number = json['number'] as String,
        meaning = json['meaning'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'number': number,
        'meaning': meaning,
      };
}
