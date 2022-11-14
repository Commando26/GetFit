import 'package:firstapp/models/category.dart';
import 'package:firstapp/models/subcategory.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/other/config.dart';
import 'package:firstapp/models/categorypart.dart';
class Utils{
  static List<Category> getMockedCategories(){
    return[
      Category(
          color: currentTheme.textColor,
          name: "Stretching",
          imgName: "stretch",
          subCategories: [
          SubCategory(name: "Calf Stretch", color: currentTheme.textColor, imgName: "calfs",
              parts: [
                CategoryPart(
              name: 'test',
              imgName: 'test',
              isSelected: false
          ),
              ]

          ),
            SubCategory(name: "Hamstring Stretch", color: currentTheme.textColor, imgName: "hamstring",
                parts: [
                  CategoryPart(
                      name: 'test',
                      imgName: 'test',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Quadriceps Stretch", color: currentTheme.textColor, imgName: "stretch",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Hip flexor Stretch", color: currentTheme.textColor, imgName: "hipflecs",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Knee-to-chest Stretch", color: currentTheme.textColor, imgName: "kneec",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Shoulder Stretch", color: currentTheme.textColor, imgName: "shoulder",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
          ]
      ),

      Category(
          color: currentTheme.textColor,
          name: "Yoga",
          imgName: "yoga",
          subCategories: [
            SubCategory(name: "Boat Pose", color: currentTheme.textColor, imgName: "boat",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Bow Pose", color: currentTheme.textColor, imgName: "bow",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Twisted Pose", color: currentTheme.textColor, imgName: "Twisted",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Crow Pose", color: currentTheme.textColor, imgName: "Crow",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Cobra Stretch", color: currentTheme.textColor, imgName: "cobra",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Plough Pose", color: currentTheme.textColor, imgName: "Plough",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
          ]
      ),
      Category(
          color: currentTheme.textColor,
          name: "Cardio",
          imgName: "cardio1",
          subCategories: [
            SubCategory(name: "Running", color: currentTheme.textColor, imgName: "running",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Burpees", color: currentTheme.textColor, imgName: "burp",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Swimming", color: currentTheme.textColor, imgName: "swin",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Cycling/Bicycling", color: currentTheme.textColor, imgName: "cycle",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Jumping rope", color: currentTheme.textColor, imgName: "rope",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Mountain climbing", color: currentTheme.textColor, imgName: "climb",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
          ]
      ),
      Category(
          color: currentTheme.textColor,
          name: "Full Body",
          imgName: "fullbody",
          subCategories: [
            SubCategory(name: "Bench Jump", color: currentTheme.textColor, imgName: "bench",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Cable woodchip", color: currentTheme.textColor, imgName: "wood",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Seated leg curl", color: currentTheme.textColor, imgName: "legcurl",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Kneeling push up", color: currentTheme.textColor, imgName: "kneelpush",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Farmer’s walk", color: currentTheme.textColor, imgName: "farmer",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "AB wheel rollout", color: currentTheme.textColor, imgName: "wheel",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ])


          ]
      ),
      Category(
          color: currentTheme.textColor,
          name: "Weights",
          imgName: "weights",
          subCategories: [
            SubCategory(name: "Bench Press", color: currentTheme.textColor, imgName: "benchpress",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Bicep Curl", color: currentTheme.textColor, imgName: "BicepCurl",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Shoulder Press", color: currentTheme.textColor, imgName: "shoulderpress",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Bent-Over Row", color:currentTheme.textColor, imgName: "bentrow",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Lateral Raise", color: currentTheme.textColor, imgName: "lateralraise",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ]),
            SubCategory(name: "Tricep Extensions", color: currentTheme.textColor, imgName: "tricepexten",
                parts: [
                  CategoryPart(
                      name: '',
                      imgName: '',
                      isSelected: false
                  ),
                ])
          ]
      )



    ];
  }
}