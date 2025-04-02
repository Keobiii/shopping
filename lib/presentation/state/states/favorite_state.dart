import 'package:shopping/data/models/Product.dart';

abstract class FavoriteState {
  @override
  List<Object?> get props => [];
}

class FavoriteInital extends FavoriteState {
}

class FavoriteLoaded extends FavoriteState {
  final List<Product> favorites;

  FavoriteLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}