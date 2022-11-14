import 'package:firstapp/models/category.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firstapp/models/categorypart.dart';



class SubCategory extends Category{

  List<CategoryPart> parts;

  SubCategory({
    required this.parts,
    required String name,
    //required String icon,
    required Color color,
    required  String imgName
}): super(
      name: name,
     // icon: icon,
      color: color,
      imgName: imgName,
      subCategories: []
  );
}