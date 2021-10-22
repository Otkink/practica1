// Generated by https://quicktype.io

class PopularMoviesDetailsModel {
  String? backdropPath;
  List<Genre>? genres;
  String? homepage;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  double? voteAverage;

  PopularMoviesDetailsModel({
    this.backdropPath,
    this.genres,
    this.homepage,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.voteAverage
  });

  factory PopularMoviesDetailsModel.fromMap(Map<String,dynamic> map){
    return PopularMoviesDetailsModel(
      backdropPath      : map['backdrop_path'],
      genres            : map['genres'],
      homepage          : map['homepage'],
      id                : map['id'],
      originalLanguage  : map['original_language'], 
      originalTitle     : map['original_title'],
      overview          : map['overview'],
      popularity        : map['popularity'],
      posterPath        : map['poster_path'],
      releaseDate       : map['release_date'],
      revenue           : map['revenue'],
      runtime           : map['runtime'],
      spokenLanguages   : map['spoken_languages'],
      status            : map['status'],
      tagline           : map['tagline'],
      title             : map['title'],
      voteAverage       : map['vote_average'] is int ? (map['vote_average'] as int).toDouble() : map['vote_average'],
    );
  }
}

class Genre {
  int? id;
  String? name;

  Genre({
    this.id,
    this.name,
  });
}


class SpokenLanguage {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });
}
