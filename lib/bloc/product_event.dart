import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable{
  @override
  List<Object>  get props=>[];
}


class ProductFetched extends ProductEvent{

}
class SearchItem extends ProductEvent{
final String serchQuery;
    SearchItem(this.serchQuery);
}