import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/home_cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout/home_cubit/states.dart';
import 'package:shop_app/models/categories_model/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageCubit , HomePageStates>
      (
      listener: (context , state){},
      builder: (context , state)
      {
       return ListView.separated(
         physics: BouncingScrollPhysics(),
           itemBuilder: (context , index)=>
               buildCategoriesItems(HomePageCubit.get(context).categoriesModel.data.categoriesData[index]),
           separatorBuilder:  (context , index)=>Container(
             height: 4,
             width: double.infinity,
           ),
           itemCount:HomePageCubit.get(context).categoriesModel.data.categoriesData.length,
       );
      },
    );
  }
}

Widget buildCategoriesItems(DataModel model)=>Row(
  children: [
    Image(
      image: NetworkImage(model.image),
      width: 80.0,
      height: 80.0,
      fit: BoxFit.cover,
    ),
    SizedBox(width: 20.0,),
    Text(model.name,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    Spacer(),
    IconButton(icon:Icon(Icons.arrow_forward_ios),
      onPressed: (){},
    ),
  ],
);
