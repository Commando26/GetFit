import 'package:firstapp/models/category.dart';
import 'package:firstapp/models/subcategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/view/workoutsTab/detailspage.dart';
import 'package:firstapp/other/config.dart';
import '../../helpers/utils.dart';

//Builds the exercises page with scrollable tabs
class CategoryList extends StatelessWidget{

  List<Category> categories = Utils.getMockedCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: const Text('Workouts'),
          automaticallyImplyLeading: false,
          actions: <Widget>[Container()],
          //backgroundColor: Colors.transparent,
          //elevation: 0.0,
        ),
        body:Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text('Select a Workout Category',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: currentTheme.textColor,fontSize: 18),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (BuildContext ctx, int index){
                        return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectedCategoryPage(
                                        //selectedCategory: Utils.getMockedCategories()[0],
                                        selectedCategory: this.categories[index],
                                      )
                                  )
                              );
                            },


                            child: Container(
                              margin: EdgeInsets.all(20),
                              height: 150,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child:  Image.asset('assets/icon/' + categories[index].imgName + '.png',
                                          fit:BoxFit.cover
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight: Radius.circular(20)

                                            ),
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                                  Colors.black.withOpacity(0.7),
                                                  Colors.transparent
                                                ]
                                            )
                                        )
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child:Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Text(categories[index].name,
                                              style: TextStyle(
                                                  color: currentTheme.textColor,
                                                  fontSize: 25
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                  )


                                ],
                              ),
                            ));

                      },
                    )
                )
              ],
            )
        )
    );
  }
}

// Builds the actual categories within the initial tabs
class SelectedCategoryPage extends StatelessWidget{

  Category selectedCategory;
  SelectedCategoryPage({required this.selectedCategory });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(this.selectedCategory.name),
        automaticallyImplyLeading: false,
      ),
     body: Container(
       child: Column(
         children: [
          /*Row(
       mainAxisAlignment: MainAxisAlignment.center,
           children: [
           Text(this.selectedCategory.name,
           style: TextStyle(color: currentTheme.textColor, fontSize: 20),
           )
         ],
     ),*/
           SizedBox(height: 30,),
           Expanded(
             child: GridView.count(
               crossAxisCount: 2,
               children: List.generate(
                 this.selectedCategory.subCategories.length,
                   (index){
                   return GestureDetector(
                     onTap: (){
                       Navigator.push(
                         context, MaterialPageRoute(
                           builder: (context) =>
                               DetailsPage(
                                   subCategory: this.selectedCategory.subCategories[index]
                                       as SubCategory,
                                 )
                       ));

                     },
                   child:
                     Container(
                     child: Column(
                       children: [
                         ClipOval(
                     child: Image.asset(
                         'assets/icon/' + this.selectedCategory.subCategories[index].imgName + '.png',
                       fit: BoxFit.cover, width: 100, height: 100,
                     ),
                         ),
                         SizedBox(height: 10),
                         Text(this.selectedCategory.subCategories[index].name,
                         style: TextStyle(color: currentTheme.textColor
                         ),
                         )
                           ],
                     )
                   ),
                   );
                   }
               ),
             ),
           )
           ],
       )

     ),
    );
  }
}