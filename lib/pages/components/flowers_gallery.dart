import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FlowersGalleryCom extends StatefulWidget {
  const FlowersGalleryCom({super.key});

  @override
  State<FlowersGalleryCom> createState() => _FlowersGalleryComState();
}

class _FlowersGalleryComState extends State<FlowersGalleryCom> {
  late Future<List<String>> _imageUrls;
  @override
  void initState() {
    super.initState();
    // _futureFiles = _listFiles('cloth-company/');
    _imageUrls = fetchImageUrls('flower-company/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flowers Compnay"),
      ),
      body: FutureBuilder<List<String>>(
        future: _imageUrls,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No images found.'));
          }
          final imageUrls = snapshot.data!;
          return GridView.custom(
            shrinkWrap: true,
            padding: const EdgeInsets.only(
              bottom: 16,
              left: 8,
              right: 8,
            ),
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 6,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: const [
                QuiltedGridTile(2, 2),
                QuiltedGridTile(4, 4),
                QuiltedGridTile(2, 2),
              ],
            ),
            childrenDelegate: SliverChildBuilderDelegate(
              (context, index) {
                return CachedNetworkImage(
                  imageUrl: imageUrls[index],
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                );
              },
              childCount: imageUrls.length,
            ),
          );
        },
      ),
    );
  }

  Future<List<String>> fetchImageUrls(String folderPath) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final Reference ref = storage.ref().child(folderPath);
    final ListResult result = await ref.listAll();

    List<String> urls = [];
    for (var item in result.items) {
      final url = await item.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }
}
