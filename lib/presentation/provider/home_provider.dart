import 'package:flutter/widgets.dart';

class HomeProvider extends ChangeNotifier {

bool  isGrid = true;

 viewAlignment(){
   isGrid = !isGrid;
   notifyListeners();

 }
}