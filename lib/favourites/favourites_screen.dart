import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/home_cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/home_cubit/states.dart';
import 'package:shop_app/models/get_favorites/get_favorites.dart';
import 'package:shop_app/shared/colors.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit , HomePageStates>(
      listener: (context , state){},
      builder: (context , state){
        return ConditionalBuilder(
          condition: state is! GetLoadingFavState,
          builder: (context) =>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return buildFavoriteItem(HomePageCubit.get(context).favoritesModel.data.data[index] , context);
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey,
              );
            },
            itemCount: HomePageCubit.get(context).favoritesModel.data.data.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  Widget buildFavoriteItem(FavData model  , context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Container(
                height: 120.0,
                width: 120.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(
                          '${model.product.image}',
                      ),
                      height: 120.0,
                      width: 120.0,
                    ),
                    Container(
                      child: model.product.discount != 0
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                'Offer',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.product.name}',
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
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product.price}',
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
                        if (model.product.discount != 0)
                          Text(
                            '${model.product.oldPrice}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: HomePageCubit.get(context).favorites[model.product.id] ? defaultColor : Colors.grey,
                            child: Icon(
                              Icons.favorite_outline,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            HomePageCubit.get(context).changeFavorite(model.product.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
