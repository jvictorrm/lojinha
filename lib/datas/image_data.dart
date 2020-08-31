class ImageData {
  int id;
  String imageUrl;

  ImageData.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.imageUrl = map['image_url'];
  }
}
