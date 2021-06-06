class CategoriesModel
{
  bool status;
  CategoriesData data;

  CategoriesModel.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    data = CategoriesData.fromJson(json['data']);
  }
}
class CategoriesData
{
  int currentPage;
  List<DataModel> categoriesData = [];

  CategoriesData.fromJson(Map<String , dynamic>  json)
  {
    currentPage = json['current_page'];
    json['data'].forEach((element){
      categoriesData.add(DataModel.fromJson(element));
    });
  }
}

class DataModel
{
  int id;
  String name;
  String image;

  DataModel.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
