import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/data/models/Product.dart';
import 'package:shopping/presentation/state/states/favorite_state.dart';

class ToggleFavoriteEvent {
  final Product product;

  ToggleFavoriteEvent(this.product);
}

class FavoriteBloc extends Bloc<ToggleFavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInital()) {
    on<ToggleFavoriteEvent>((event, emit) {
      List<Product> updatedFavorites = state is FavoriteLoaded
        ? List<Product>.from((state as FavoriteLoaded).favorites)
        : [];

      if (updatedFavorites.contains(event.product)) {
        updatedFavorites.remove(event.product);
      } else {
        updatedFavorites.add(event.product);
      }

      emit(FavoriteLoaded(updatedFavorites));
    });
  }
}