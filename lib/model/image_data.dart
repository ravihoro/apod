class ImageData {
  final String copyright;
  final String date;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;

  const ImageData({
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
  });

  factory ImageData.fromJson(Map<String, dynamic> map) {
    return ImageData(
      copyright: map["copyright"],
      date: map["date"],
      explanation: map["explanation"],
      hdurl: map["hdurl"],
      mediaType: map["media_type"],
      serviceVersion: map["service_version"],
      title: map["title"],
      url: map["url"],
    );
  }
}
