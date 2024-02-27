class Movie{
  int id;
  String title;

  Movie(this.id, this.title);

  static Movie jsonToMovie(Map<String, dynamic> json){
    return Movie(json['id'], json['title']);
  }

}