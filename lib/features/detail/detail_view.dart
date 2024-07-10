import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  final Map<String, dynamic> restaurant;

  const DetailView({Key? key, required this.restaurant}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late Map<String, dynamic> _restaurant;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _restaurant = widget.restaurant;
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 150,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 150,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_restaurant['name']),
        backgroundColor:
            const Color.fromARGB(255, 255, 153, 0).withOpacity(0.8),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                _restaurant['image'],
                width: MediaQuery.of(context).size.width,
                height: 180,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 9),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      _restaurant['description'],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  IconButton(
                    icon: Image.asset('assets/icons/liked.png',
                        width: 24, height: 30),
                    onPressed: () {
                      // Handle like functionality
                    },
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'opens at ${_restaurant['opening_time']} and closes at ${_restaurant['closing_time']}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 1),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 24),
                  const Icon(Icons.star, color: Colors.orange, size: 24),
                  const Icon(Icons.star, color: Colors.orange, size: 24),
                  const Icon(Icons.star, color: Colors.orange, size: 24),
                  const Icon(Icons.star_border, color: Colors.orange, size: 24),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Image.asset('assets/icons/bookmark.png',
                        width: 28, height: 28),
                    onPressed: () {
                      // Handle save functionality
                    },
                  ),
                  IconButton(
                    icon: Image.asset('assets/icons/map.png',
                        width: 28, height: 28),
                    onPressed: () {
                      // Handle map functionality
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // Handle see menu functionality
                    },
                    child: const Text(
                      'See Menu',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromARGB(255, 40, 116, 246),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "What's Popular Here",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: _scrollLeft,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 150,
                      child: ListView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildPopularItem('Momo', 'assets/images/momo.png'),
                          _buildPopularItem('Pizza', 'assets/images/pizza.png'),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: _scrollRight,
                  ),
                ],
              ),
              const SizedBox(height: 3),
              const Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              _buildReview('Good Place!', 'P'),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // Handle see all reviews functionality
                },
                child: const Text('See All Reviews'),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Add review.',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle add review functionality
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      backgroundColor: const Color.fromARGB(255, 255, 204, 2),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularItem(String name, String imagePath) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 9.0),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 120,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReview(String review, String initial) {
    return Row(
      children: [
        CircleAvatar(
          child: Text(initial),
        ),
        const SizedBox(width: 8),
        Text(review),
      ],
    );
  }
}
