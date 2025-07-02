import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final String price;
  final String unit;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.unit,
    required this.imageUrl,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      width: 160,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                widget.imageUrl,
                width: double.infinity,
                height: 120,
                fit: BoxFit.contain, // This keeps image aspect ratio intact
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 120,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Nrs. ${widget.price} /',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Unit: ${widget.unit}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  quantityChanger(),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget quantityChanger() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => setState(() => _quantity = _quantity > 1 ? _quantity - 1 : 1),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.remove, size: 18, color: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '$_quantity',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          InkWell(
            onTap: () => setState(() => _quantity++),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.add, size: 18, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
