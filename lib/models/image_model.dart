class ImageModel {

  // Field
  int id;
  String title, url;

  // Constructor
  ImageModel(this.id, this.title, this.url);

  //Setter from Json
  ImageModel.FromJSON(Map<String, dynamic>fromJSON) {
    id = fromJSON['id'];
    title = fromJSON['title'];
    url = fromJSON['url'];
  }

  
}