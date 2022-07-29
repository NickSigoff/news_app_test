import 'package:json_annotation/json_annotation.dart';

part 'multimedia_model.g.dart';

@JsonSerializable()
class Multimedia {
  String? url;
  String? format;
  int? height;
  int? width;
  String? type;
  String? subtype;
  String? caption;
  String? copyright;

  Multimedia(
      {this.url,
      this.format,
      this.height,
      this.width,
      this.type,
      this.subtype,
      this.caption,
      this.copyright});

  factory Multimedia.fromJson(Map<String, dynamic> json) =>
      _$MultimediaFromJson(json);

  Map<String, dynamic> toJson() => _$MultimediaToJson(this);
}
