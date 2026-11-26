import 'package:flutter/material.dart';

import 'jokes.dart';

Color appColor = Colors.green[300] as Color;

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FavoriteJokesScreen(),
    ));

/// Displays a scrollable list of jokes where only one joke can be marked as the best.
class FavoriteJokesScreen extends StatefulWidget {
  const FavoriteJokesScreen({super.key});

  @override
  State<FavoriteJokesScreen> createState() => _FavoriteJokesScreenState();
}

class _FavoriteJokesScreenState extends State<FavoriteJokesScreen> {
  int? _bestJokeIndex;

  void _onFavoriteClick(int index) {
    setState(() {
      _bestJokeIndex = (_bestJokeIndex == index) ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text("Favorite Jokes"),
      ),
      body: ListView.builder(
        itemCount: jokes.length,
        itemBuilder: (context, index) {
          final joke = jokes[index];
          return FavoriteCard(
            title: joke.title,
            description: joke.description,
            isFavorite: _bestJokeIndex == index,
            onFavoriteClick: () => _onFavoriteClick(index),
          );
        },
      ),
    );
  }
}

/// Renders a single joke card with a selectable favorite heart button.
class FavoriteCard extends StatelessWidget {
  const FavoriteCard({
    super.key,
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.onFavoriteClick,
  });

  final String title;
  final String description;
  final bool isFavorite;
  final void Function() onFavoriteClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: appColor, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10.0),
                Text(description),
              ],
            ),
          ),
          IconButton(
              onPressed: onFavoriteClick,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ))
        ],
      ),
    );
  }
}
