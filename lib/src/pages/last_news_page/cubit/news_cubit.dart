import 'package:bloc/bloc.dart';
import 'package:cubitvideourokrss/src/utils/Database.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../widgets/image_news_widget.dart';

part 'news_state.dart';

const _top7URL = 'http://192.168.0.17/test/hs/myservise/v1/one/';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial(false));



  Future<void> loadNews(visible) async{
    try{
      // await Future.delayed(const Duration(seconds: 2));
       final http.Response response = await http.Client().post(Uri.parse(_top7URL),headers: {'Accept':'application/json','Authorization':'Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6M2xqMWFoNTQ='});
      var convertDataToJson = json.decode(utf8.decode(response.bodyBytes));
      // await DBProvider.db.newCustomer(newCustomer)

       // await DBProvider.db.deleteAll();

      List<Customer> listcustomer = [];
      for(final element in Map.from(convertDataToJson).values) {
        for(final element_ in element) {
          var mas_element=[];
          for(final el in Map.from(element_).entries)mas_element.add(el.value);
          listcustomer.add(Customer(Card: mas_element[1], Id: mas_element[0], Sum: mas_element[2].toDouble()));
          bool element__= await DBProvider.db.getFindCustomer(mas_element[0]);

          if (!element__) {
            await DBProvider.db.newCustomer(Customer(Card: mas_element[1],
                Id: mas_element[0],
                Sum: mas_element[2].toDouble()));
          } else {
            await DBProvider.db.updateCustomer(Customer(Card: mas_element[1], Id: mas_element[0], Sum: mas_element[2].toDouble()));

          }
        }
      }
       emit(NewsLoadedState(listcustomer,visible));
    }catch (e){
      try {
        emit(NewsLoadedState(await DBProvider.db.getAllCustomer(),visible));
      } catch (e1) {
        emit(NewsErrorState("Упccc" + "\n" + e1.toString()));
      }
      // emit(NewsErrorState("Упccc" + "\n" + e.toString()));
    }
  }
  Future<void> reloadNews(visible) async{
    emit(NewsInitial(visible));
  }
}
