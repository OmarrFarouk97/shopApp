// class HomeModel
// {
//  late bool status;
// late HomeDataModel data;
//
//  HomeModel.fromJson( Map <String,dynamic>json )
//  {
//    status =json['status'];
//    data = HomeDataModel.fromJson(json['data']);
//     //data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null!;
// }
// }
//
// class HomeDataModel
// {
//   List<BannerModel> banners =[];
//   List<ProductModel> products=[];
//
//   HomeDataModel.fromJson( Map <String,dynamic> json)
//   {
//     json['banners'].forEach((element)
//     {
//       banners.add(element);
//     });
//     json['products'].forEach((element) {
//       products.add(element);
//     });
//   }
// }
//
//
//
//
// class BannerModel
// {
//   late int id;
//   late String image;
//
//   BannerModel.fromJson(Map<String,dynamic> json)
//   {
//     id=json['id'];
//     image=json['image'];
//   }
// }
//
// class ProductModel
// {
//   late int id ;
//   dynamic price;
//   dynamic oldPrice;
//   dynamic discount;
//   late String image;
//  late String name;
//  late bool inFavorites ;
//  late bool inCart ;
//
//
//   ProductModel.fromJson(Map <String,dynamic> json)
//   {
//
//     id=json['id'];
//     price=json['price'];
//     oldPrice=json['old_price'];
//     discount=json['discount'];
//     image=json['image'];
//     name=json['name'];
//     inFavorites=json['in_favorites'];
//     inCart=json['in_cart'];
//
//   }
// }
class  HomeModel {
   bool? status;
   String? message;
   Data? data;


  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
   List<Banners>? banners=[];
   List<Products>? products=[];


  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {

      json['banners'].forEach((element) {
        banners?.add(Banners.fromJson(element));
      });
    }
    if (json['products'] != null) {
      json['products'].forEach((element) {
        products?.add(Products.fromJson(element));
      });
    }
  }
}

class Banners {
   int? id;
   String? image;


  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];

  }
}

class Products {
   int? id;
   dynamic price;
   dynamic oldPrice;
   int? discount;
   String? image;
   String? name;
   String? description;
   List<String>? images;
   bool? inFavorites;
   bool? inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}