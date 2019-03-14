class NewsBean {
  List<Data> data;
  int pageSize;
  int totalItems;
  int totalPages;

  NewsBean({this.data, this.pageSize, this.totalItems, this.totalPages});

  NewsBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    pageSize = json['pageSize'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['pageSize'] = this.pageSize;
    data['totalItems'] = this.totalItems;
    data['totalPages'] = this.totalPages;
    return data;
  }
}

class Data {
  String id;
  List<NewsArray> newsArray;
  String createdAt;
  List<Null> eventData;
  String publishDate;
  String summary;
  String title;
  String updatedAt;
  String timeline;
  int order;
  Extra extra;
  bool isShowAll=false;
  bool isShowAllNews=false;

  Data(
      {this.id,
        this.newsArray,
        this.createdAt,
        this.eventData,
        this.publishDate,
        this.summary,
        this.title,
        this.updatedAt,
        this.timeline,
        this.order,
        this.extra});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['newsArray'] != null) {
      newsArray = new List<NewsArray>();
      json['newsArray'].forEach((v) {
        newsArray.add(new NewsArray.fromJson(v));
      });
    }
    createdAt = json['createdAt'];

    publishDate = json['publishDate'];
    summary = json['summary'];
    title = json['title'];
    updatedAt = json['updatedAt'];
    timeline = json['timeline'];
    order = json['order'];
    extra = json['extra'] != null ? new Extra.fromJson(json['extra']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.newsArray != null) {
      data['newsArray'] = this.newsArray.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;

    data['publishDate'] = this.publishDate;
    data['summary'] = this.summary;
    data['title'] = this.title;
    data['updatedAt'] = this.updatedAt;
    data['timeline'] = this.timeline;
    data['order'] = this.order;
    if (this.extra != null) {
      data['extra'] = this.extra.toJson();
    }
    return data;
  }
}

class NewsArray {
  int id;
  String url;
  String title;
  String siteName;
  String mobileUrl;
  String autherName;
  int duplicateId;
  String publishDate;
  String language;
  int statementType;

  NewsArray(
      {this.id,
        this.url,
        this.title,
        this.siteName,
        this.mobileUrl,
        this.autherName,
        this.duplicateId,
        this.publishDate,
        this.language,
        this.statementType});

  NewsArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    siteName = json['siteName'];
    mobileUrl = json['mobileUrl'];
    autherName = json['autherName'];
    duplicateId = json['duplicateId'];
    publishDate = json['publishDate'];
    language = json['language'];
    statementType = json['statementType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['title'] = this.title;
    data['siteName'] = this.siteName;
    data['mobileUrl'] = this.mobileUrl;
    data['autherName'] = this.autherName;
    data['duplicateId'] = this.duplicateId;
    data['publishDate'] = this.publishDate;
    data['language'] = this.language;
    data['statementType'] = this.statementType;
    return data;
  }
}

class Extra {
  bool instantView;

  Extra({this.instantView});

  Extra.fromJson(Map<String, dynamic> json) {
    instantView = json['instantView'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instantView'] = this.instantView;
    return data;
  }
}