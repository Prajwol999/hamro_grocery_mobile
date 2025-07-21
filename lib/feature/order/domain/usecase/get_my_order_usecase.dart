import 'package:dartz/dartz.dart';
import 'package:hamro_grocery_mobile/app/usecase/usecase.dart';
import 'package:hamro_grocery_mobile/core/error/failure.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/entity/order_entity.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/repository/order_repository.dart';

class GetMyOrdersUseCase implements UseCaseWithoutParams<List<OrderEntity>> {
  final IOrderRepository _repository;

  GetMyOrdersUseCase({required IOrderRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, List<OrderEntity>>> call() async {
    return await _repository.getMyOrders();
  }
}
