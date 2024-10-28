
import 'dart:convert';

Homescreenmodel homescreenmodelFromJson(String str) => Homescreenmodel.fromJson(json.decode(str));

class Homescreenmodel {
    String? status;
    int? totalResults;
    List<News>? articles;

    Homescreenmodel({
        this.status,
        this.totalResults,
        this.articles,
    });

    factory Homescreenmodel.fromJson(Map<String, dynamic> json) => Homescreenmodel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: json["articles"] == null ? [] : List<News>.from(json["articles"]!.map((x) => News.fromJson(x))),
    );  
}

class News {
    Source? source;
    String? author;
    String? title;
    String? description;
    String? url;
    String? urlToImage;
    DateTime? publishedAt;
    String? content;

    News({
        this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
        content: json["content"],
    );
}

class Source {
    dynamic id;
    String? name;

    Source({
        this.id,
        this.name,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
    );
}
