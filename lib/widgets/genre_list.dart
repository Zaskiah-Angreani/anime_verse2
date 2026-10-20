import 'package:flutter/material.dart';

class GenreList extends StatelessWidget {
  final List<String> genres = const [
    "All",
    "Action",
    "Adventure",
    "Comedy",
    "Drama",
    "Fantasy",
    "Horror",
    "Mystery",
    "Romance",
    "Sci-Fi",
    "Slice of Life",
  ];

  final String selected;
  final ValueChanged<String>? onGenreSelected;

  const GenreList({
    super.key,
    this.selected = "All",
    this.onGenreSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.01,
      ),
      child: Row(
        children: genres.map((genre) {
          final isActive = genre == selected;

          return Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.03),
            child: InkWell(
              borderRadius: BorderRadius.circular(screenWidth * 0.06),
              onTap: () {
                if (onGenreSelected != null) {
                  onGenreSelected!(genre);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.012,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.06),
                  // PERBAIKAN: Ubah warna background saat genre aktif/terpilih
                  color: isActive
                      ? const Color(0xFF1E88E5) // Warna biru terang untuk active chip
                      : const Color(0xFF0b395e), // Warna navy bawaan saat inaktif
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: screenWidth * 0.02,
                      offset: Offset(0, screenHeight * 0.005),
                    ),
                  ],
                ),
                child: Text(
                  genre,
                  style: TextStyle(
                    fontSize: screenWidth * 0.038,
                    color: isActive ? Colors.white : Colors.grey.shade400,
                    fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}