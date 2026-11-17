import 'package:flutter/material.dart';

class TravelCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String date;
  final String location;
  final VoidCallback onDelete;
  const TravelCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.onDelete,
  });

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext alertContext) {
        return AlertDialog(
          title: const Text('Description'),
          backgroundColor: Theme.of(context).cardColor,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [Text(description)],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      padding: EdgeInsets.all(12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  showAboutDialog(context: context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.network(
  imageUrl,
  fit: BoxFit.cover,
  height: double.infinity,
  width: double.infinity,
  errorBuilder: (context, error, stackTrace) {
    return const Center(
      child: Icon(
        Icons.broken_image,
        size: 50,
        color: Colors.grey,
      ),
    );
  },
)
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          date,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        IconButton(onPressed: onDelete, icon: Icon(Icons.delete, color: Colors.red,))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
