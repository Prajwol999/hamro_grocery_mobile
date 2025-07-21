import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamro_grocery_mobile/feature/order/domain/entity/order_entity.dart';
import 'package:hamro_grocery_mobile/feature/order/presentation/view_model/order_event.dart';
import 'package:hamro_grocery_mobile/feature/order/presentation/view_model/order_state.dart';
import 'package:hamro_grocery_mobile/feature/order/presentation/view_model/order_view_model.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order #$orderId')),
      body: Center(
        child: Text('Details for order $orderId would be shown here.'),
      ),
    );
  }
}

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dispatch the event to fetch orders as soon as the screen is built,
    // if they haven't been fetched already.
    context.read<OrderBloc>().add(GetMyOrders());

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders'), centerTitle: true),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          // --- Loading State ---
          if (state.status == OrderRequestStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // --- Failure State ---
          if (state.status == OrderRequestStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage ?? 'An unknown error occurred.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<OrderBloc>().add(GetMyOrders());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // --- Success State ---
          if (state.myOrders.isEmpty) {
            return const Center(child: Text('You have no orders yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.myOrders.length,
            itemBuilder: (context, index) {
              final order = state.myOrders[index];
              return _OrderItemCard(order: order);
            },
          );
        },
      ),
    );
  }
}

/// A private widget to represent a single order card in the list.
class _OrderItemCard extends StatelessWidget {
  final OrderEntity order;

  const _OrderItemCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          // Navigate to a detail screen, passing the order ID.
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => OrderDetailScreen(orderId: order.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${order.id.substring(0, 8)}...',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  _OrderStatusChip(status: order.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Placed on: ${DateFormat.yMMMd().format(order.createdAt)}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Total: \$${order.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderStatusChip extends StatelessWidget {
  final OrderStatus status;

  const _OrderStatusChip({required this.status});

  Color _getStatusColor() {
    switch (status) {
      case OrderStatus.Delivered:
        return Colors.green;
      case OrderStatus.Shipped:
        return Colors.blue;
      case OrderStatus.Processing:
        return Colors.orange;
      case OrderStatus.Cancelled:
        return Colors.red;
      case OrderStatus.Pending:
      case OrderStatus.PendingPayment:
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        status.name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: _getStatusColor(),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
    );
  }
}
