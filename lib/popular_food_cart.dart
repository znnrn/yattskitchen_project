import 'package:flutter/material.dart';
import 'FoodMenuScreen.dart'; 
import 'cart_service.dart'; 

class PopularFoodCard extends StatelessWidget {
  final FoodItem item; 

  const PopularFoodCard({
    super.key,
    required this.item,
  });

  Widget _buildInfoChip(IconData icon, String text, Color iconColor, Color textColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 18),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 12, color: textColor)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[200], 
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  image: const DecorationImage(
                    image: NetworkImage('https://via.placeholder.com/150'), 
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Color(0xFFFFCC33), 
                      BlendMode.multiply,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    item.name.split(' ').first[0],
                    style: const TextStyle(fontSize: 40, color: Colors.white70),
                  ),
                ),
              ),
              if (item.isPopular)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Popular',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (item.rating != null)
                      _buildInfoChip(Icons.star, item.rating!.toString(),
                          Colors.amber, Colors.black)
                    else 
                      const Icon(Icons.star_border, color: Colors.grey, size: 18),
                      
                    if (item.time != null)
                      _buildInfoChip(
                          Icons.watch_later_outlined, item.time!, Colors.grey, Colors.black)
                    else 
                      const Icon(Icons.access_time, color: Colors.grey, size: 18),
                      
                    const Icon(Icons.favorite_border, color: Colors.grey, size: 18),
                  ],
                ),

                if (item.price != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'RM ${item.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: item.price == null ? null : () {
                      CartService.instance.addItem(item);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.name} added to cart!'),
                          duration: const Duration(milliseconds: 1500),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFCC33),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add, color: Colors.black, size: 18),
                        SizedBox(width: 5),
                        Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}