import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/home_cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/home_cubit/states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';
import 'package:shop_app/models/home_model/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit, HomePageStates>(
      listener: (cntext, state) {},
      builder: (context, state) {
        var cubit = HomePageCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel!= null,
          builder: (context) => productsBuilder(cubit.homeModel , cubit.categoriesModel) ,
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget productsBuilder(HomeModel model , CategoriesModel catModel) => SingleChildScrollView(
  physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners
                .map(
                  (e) => Image(
                    image: NetworkImage('${e.image}'),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              autoPlay: true,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories' , style: TextStyle(fontWeight: FontWeight.bold  ,fontSize: 24.0),),
                Container(
                  height: 100,
                  child: ListView.separated(
                       scrollDirection: Axis.horizontal ,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context , index)=>buildCategoryItems(catModel.data.categoriesData[index]),
                      separatorBuilder: (context , index)=>SizedBox(width: 10,),
                      itemCount: catModel.data.categoriesData.length,
                  ),
                ),
                Text('Top Products' , style: TextStyle(fontWeight: FontWeight.bold  ,fontSize: 24.0),),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.2,
              childAspectRatio: 1 / 1.57,
              children: List.generate(
                model.data.products.length,
                (index) => buildGridView(model.data.products[index]),
              ),
            ),
          ),
        ],
      ),
    );

Widget buildCategoryItems(DataModel catModel)=>Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
    Image(
      image : NetworkImage(catModel.image),
      height: 100.0,
      width: 100.0,
    ),
    Container(
      color: Colors.black.withOpacity(0.7),
      width: 100.0,
      child: Text(catModel.name,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,

        ),
      ),
    ),
  ],
);

Widget buildGridView(ProductModel model) =>
    Container(
      color: Colors.white,
      child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                height: 200.0,
                width: double.infinity,
              ),
              Container(
                color: Colors.red,
                child: model.discount!=0 ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text('Offer',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
                ): null,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 15,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    if(model.discount!=0)
                    Text('${model.old_price.round()}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.favorite_outline,
                        size: 20.0,
                        ),
                        onPressed: (){},

                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
