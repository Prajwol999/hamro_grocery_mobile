import 'package:flutter/material.dart';
import 'package:hamro_grocery_mobile/app/constant/api_endpoints.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.categoryName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use InkWell to make the whole card tappable
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class CategoryCard extends StatelessWidget {

  final String title;

  final String imageUrl;



  const CategoryCard({super.key, required this.title, required this.imageUrl});



  @override

  Widget build(BuildContext context) {

    return Container(

      width: 120,

      margin: const EdgeInsets.symmetric(horizontal: 8.0),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        boxShadow: [

          BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 2)),

        ],

      ),

      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          ClipOval(

            child: Image.asset(

              imageUrl,

              width: 70,

              height: 70,

              fit: BoxFit.cover,

              errorBuilder: (context, error, stackTrace) => const Icon(Icons.category, size: 70, color: Colors.grey),

            ),

          ),

          const SizedBox(height: 8),

          Text(

            title,

            textAlign: TextAlign.center,

            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),

          ),

        ],

      ),

    );

  }

}
