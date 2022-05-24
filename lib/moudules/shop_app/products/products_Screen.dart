import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/layout/shop_app/cubit/cubit.dart';
import 'package:project_udemy/layout/shop_app/cubit/states.dart';
import 'package:project_udemy/models/shop_app/categories_model.dart';
import 'package:project_udemy/models/shop_app/home_model.dart';
import 'package:project_udemy/styles/colors.dart';

class ProuductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if( state is ShopSuccessChangeFavoritesState)
        {
          if(!state.model.status!)
          {
            showToast(text: state.model.message, state: ToastStates.ERROR);
          }

        }
      },
      builder: (context, state) {
        //var home =ShopCubit.get(context).homeModel ;
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => productsBuilder(
                ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel,context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel,context) =>
      SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: model?.data?.banners
                    ?.map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: 250.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    viewportFraction: 1,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 90,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoriesItem(
                            categoriesModel!.data!.data![index]),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                        itemCount: categoriesModel!.data!.data!.length,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'New Products',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 2,
                  childAspectRatio: 1 / 1.55,
                  children: List.generate(
                    model!.data!.products!.length,
                    (index) => buildGridProduct(model.data!.products![index],context),
                  ),
                ),
              ),
            ],
          ));

  Widget buildCategoriesItem(DataModel model) => Container(
        height: 90,
        width: 90,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(model.image!),
              height: 90,
              width: 90,
            ),
            Container(
              width: double.infinity,
              color: Colors.black.withOpacity(.5),
              child: Text(
                model.name!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(Products model,context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 10.0, color: Colors.white),
                        ),
                      ))
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, height: 1.1),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()} LE',
                        style: TextStyle(
                          fontSize: 14,
                          color: defualtColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()} LE',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: ()
                        {
                          ShopCubit.get(context).changeFavourites(model.id!);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor: ShopCubit.get(context).favorites[model.id!]!  ? defualtColor : Colors.grey,
                          child:Icon(
                          Icons.favorite_border,
                          size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
