import 'package:flutter/material.dart';
import 'package:hizmet_mobil_uygulama/models/Category.dart';

class CategoryIcon{
  Category _category;
  CategoryIcon(this._category);
  String SelectGetIcon(int categoryIndex, int subCategoryIndex, int hizmetIndex){
    if(categoryIndex!=null){
      if(subCategoryIndex!=null){
        if(hizmetIndex!=null){
          return "assets/Category/Cat111.png";
          //return "assets/Category/Cat${categoryIndex+1}${subCategoryIndex+1}${hizmetIndex+1}.png";
        }
        else{
          return "assets/Category/Cat${categoryIndex+1}${subCategoryIndex+1}.png";
        }
      }
      else{
        return "assets/Category/Cat${categoryIndex+1}.png";
      }
    }
  }
  String GetIcon(int index,int selectCategory,int selectSubCategory,int selectHizmet){
    if(selectCategory!=null){
      if(selectSubCategory!=null){
        if(selectHizmet!=null){
          return "assets/Category/Cat111.png";
        }
        else{
          return "assets/Category/Cat111.png";
          //return "assets/Category/Cat${selectCategory+1}${selectSubCategory+1}${index+1}.png";
        }
      }
      else{
        return "assets/Category/Cat${selectCategory+1}${index+1}.png";
      }
    }
    else{
      return "assets/Category/Cat${index+1}.png";
    }

}
  String GetIconHizmetVer(int index,int durum,int selectCategory,int selectSubCategory,int selectHizmet){
    if(durum ==1){
      return "assets/Category/Cat${index+1}.png";
    }
    if(durum == 2){
      return "assets/Category/Cat${selectCategory+1}${index+1}.png";
    }
    if(durum == 3){
      return "assets/Category/Cat111.png";
    }

  }
}