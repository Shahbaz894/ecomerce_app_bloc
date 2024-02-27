import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/whishlist_bloc/fav_bloc.dart';
import '../bloc/whishlist_bloc/fav_event.dart';
import '../bloc/whishlist_bloc/fav_state.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavBloc>(context).add(LoadTempData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Favorite'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:
        BlocBuilder<FavBloc, FavState>(
          builder: (context, state) {
            if (state.favModel.isEmpty) {
              return Center(
                child: Text(
                  'Your favorites list is empty 😌',
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.favModel.length,
                itemBuilder: (context, index) {
                  final product = state.favModel[index]; // Access individual product using index
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.network(
                        product.image.toString(),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.title.toString()),
                      subtitle: Text('\$${product.price}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          final id = product.id ?? 0; // Use a default value if product.id is null
                          BlocProvider.of<FavBloc>(context).add(DeleteFavEvent(id: id));
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

