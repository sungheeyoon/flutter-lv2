import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lv2/common/const/data.dart';
import 'package:flutter_lv2/restaurant/component/retaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {'authorization': 'Bearer $accessToken '},
      ),
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FutureBuilder(
            future: paginateRestaurant(),
            builder: ((context, AsyncSnapshot<List> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];

                  return RestaurantCard(
                    image: Image.network(
                      'http://$ip${item['thumbUrl']}',
                      fit: BoxFit.cover,
                    ),
                    name: item['name'],
                    tags: List<String>.from(item['tags']),
                    ratingsCount: item['ratingsCount'],
                    deliveryTime: item['deliveryTime'],
                    deliveryFee: item['deliveryFee'],
                    ratings: item['ratings'],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
              );
            }),
          )),
    );
  }
}