import 'package:cubitvideourokrss/src/pages/last_news_page/cubit/news_cubit.dart';
import 'package:cubitvideourokrss/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../widgets/image_news_widget.dart';

class LastNewsPage extends StatelessWidget {
  const LastNewsPage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => NewsCubit(), child: const _LastNewsPage());
  }
}

class _LastNewsPage extends StatelessWidget {
  const _LastNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
      if (state is NewsInitial) {
        context.read<NewsCubit>().loadNews(state.visible);
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is NewsErrorState) {
        return GestureDetector(
            child: Center(
              child: Text(
                state.errorMessage,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
           ),
            onDoubleTap: () => context.read<NewsCubit>().reloadNews(false)
        );
      }
      if (state is NewsLoadedState) {
        return RefreshIndicator(
            child: listBuilder(context, state),
            onRefresh: () => context.read<NewsCubit>().reloadNews(state.visible));
      }

      return Container();
    });
  }

  Widget listBuilder(BuildContext context, NewsLoadedState state) {

        final Format = NumberFormat.currency(locale: "ru",decimalDigits: 2,symbol: "");

        return ListView.builder(
        itemCount: state.news.length,
        itemBuilder: (BuildContext context, int index) {

          final item = state.news[index];
          return Container(

             height: (index==0?200:100),
            child: state.visible || index ==0 ? Card(
              color: Colors.green[200],
              child:
                ListTile(
                  title: Row(
                    mainAxisAlignment: (index==0?MainAxisAlignment.center:MainAxisAlignment.spaceBetween) ,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(child: Text( item.Card,style: TextStyle(fontSize: 15)) ),
                      Text(
                        Format.format(item.Sum,) as String,
                          // item.Id,
                        // index.toString()
                         style: TextStyle(fontSize: (index==0?50:20), fontWeight: FontWeight.w500,color: (index==0?Colors.blue[900]:(item.Sum>0?Colors.green[900]:Colors.red[900])) ),
                        // maxLines: 8,
                        // textAlign: TextAlign.start,
                      ),

                    ],
                  ),
                // subtitle:Text( item.Id,),
                // trailing: Icon(Icons.keyboard_arrow_right,
                // color: Colors.grey[300]!,
                // size: 30,),
                     contentPadding: (index==0?EdgeInsets.symmetric(vertical: 1,horizontal: 1):EdgeInsets.all(15)) ,
                    // EdgeInsets.only(right:5, top:(index==0?50:20) ,bottom:(index==0?50:20) )
                  onTap:  ()=> context.read<NewsCubit>().reloadNews(!state.visible),
                    // launchUniversalLink(item.link!),
                  // leading: ImageNewsWigget(urlImage: item.enclosure!.url!),
                ),
                //     Text(item.Id!,maxLines: 8,textAlign: TextAlign.start),


            ):SizedBox(),
          );
        });
  }
}
