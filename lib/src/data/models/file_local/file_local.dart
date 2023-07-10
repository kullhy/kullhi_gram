class FileLocal {
  String? name;
  String? path;
  int? id;

  FileLocal({this.id, this.name, this.path});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FileLocal &&
        name == other.name &&
        path == other.path &&
        id == other.id;
  }

  @override
  int get hashCode {
    return name.hashCode ^ path.hashCode ^ id.hashCode;
  }
}