import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ClothGalleryCom extends StatefulWidget {
  const ClothGalleryCom({super.key});

  @override
  State<ClothGalleryCom> createState() => _ClothGalleryComState();
}

class _ClothGalleryComState extends State<ClothGalleryCom> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  List<String> imageUrls = [];
  @override
  void initState() {
    super.initState();
    // _futureFiles = _listFiles('cloth-company/');
    // _imageUrls = fetchImageUrls('cloth-company/');
    _getImagesFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cloth Compnay"),
      ),
      body: imageUrls.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.custom(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 6,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: const [
                  QuiltedGridTile(4, 4),
                  QuiltedGridTile(2, 2),
                  QuiltedGridTile(2, 2),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CachedNetworkImage(
                    imageUrl: imageUrls[index],
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  );
                },
                childCount: imageUrls.length,
              ),
            ),
      // body: FutureBuilder<List<String>>(
      //   future: _imageUrls,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      //       return const Center(child: Text('No images found.'));
      //     }
      //     final imageUrls = snapshot.data!;
      //     return GridView.custom(
      //       shrinkWrap: true,
      //       padding: const EdgeInsets.only(
      //         bottom: 16,
      //         left: 8,
      //         right: 8,
      //       ),
      //       gridDelegate: SliverQuiltedGridDelegate(
      //         crossAxisCount: 6,
      //         mainAxisSpacing: 4,
      //         crossAxisSpacing: 4,
      //         repeatPattern: QuiltedGridRepeatPattern.inverted,
      //         pattern: const [
      //           QuiltedGridTile(4, 4),
      //           QuiltedGridTile(2, 2),
      //           QuiltedGridTile(2, 2),
      //         ],
      //       ),
      //       childrenDelegate: SliverChildBuilderDelegate(
      //         (context, index) {
      //           return CachedNetworkImage(
      //             imageUrl: imageUrls[index],
      //             placeholder: (context, url) =>
      //                 const Center(child: CircularProgressIndicator()),
      //             errorWidget: (context, url, error) => const Icon(Icons.error),
      //             fit: BoxFit.cover,
      //           );
      //         },
      //         childCount: imageUrls.length,
      //       ),
      //     );
      //   },
      // ),
    );
  }

  // Future<List<String>> fetchImageUrls(String folderPath) async {
  //   final FirebaseStorage storage = FirebaseStorage.instance;
  //   final Reference ref = storage.ref().child(folderPath);
  //   final ListResult result = await ref.listAll();

  //   List<String> urls = [];
  //   for (var item in result.items) {
  //     final url = await item.getDownloadURL();
  //     urls.add(url);
  //   }
  //   return urls;
  // }
  // final ref = FirebaseDatabase.instance.ref('cloth-company/');
  // ScrollController scrollController = ScrollController();
  // Future getListName() async {
  //   DatabaseEvent snapshot = await ref.once();
  //   List<dynamic> data =
  //       jsonDecode(jsonEncode(snapshot.snapshot.value)) as dynamic;

  //   // int count = -1;
  //   for (var element in data) {
  //     // print(++count);
  //     // print(element['img_name']);
  //     if (!buttonNames.contains(element['img_name'])) {
  //       buttonNames.add(element['img_name']);
  //     }
  //   }
  //   setState(() {});
  // }
  Future<void> _getImagesFromStorage() async {
    try {
      // Reference to your 'cloth-company' folder
      final storageRef = storage.ref('cloth-company');
      // Get all files from that directory
      final ListResult result = await storageRef.listAll();
      // Fetch download URLs for each image
      List<String> tempImageUrls = [];
      for (Reference file in result.items) {
        String downloadUrl =
            await file.getDownloadURL(); // Fetch the download URL
        tempImageUrls.add(downloadUrl);
      }
      // Update the state with image URLs
      setState(() {
        imageUrls = tempImageUrls;
      });
    } catch (e) {
      if (kDebugMode) {}
    }
  }
}
