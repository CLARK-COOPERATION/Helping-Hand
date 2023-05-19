class MoodModel{
  MoodModel({
    required this.time,
    required this.mood,
    required this.score
});
  String time;
  String mood;
  double score;

  fromJson(Map<String, dynamic> json)=>{
    time: json['time'],
    mood: json['mood'],
    score: json['score']
  };

  Map<String, dynamic> toJson()=>{
    "time":time,
    "mood":mood,
    "score":score
  };
}