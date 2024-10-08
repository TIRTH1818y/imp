import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => home_page_state();
}

class home_page_state extends State<home_page> {
  late CarouselSliderController outerCarouselController =
      CarouselSliderController();

  int outerCurrentPage = 0;

  late Future<List<String>> futureimages;

  Future<List<String>> fetchimageurls() async {
    List<String> imageurl = [];
    final StorageRef = FirebaseStorage.instance.ref("sliderphotos/");
    final listresult = await StorageRef.listAll();

    for (var item in listresult.items) {
      final url = await item.getDownloadURL();
      imageurl.add(url);
    }
    return imageurl;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      futureimages = fetchimageurls();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FutureBuilder(
          future: futureimages,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()));
            }
            final imageurls = snapshot.data;

            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(15),
                ),
                SizedBox(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider(
                        carouselController: outerCarouselController,
                        items: imageurls!.map((images) {
                          return Builder(
                            builder: (BuildContext context) {
                              return CachedNetworkImage(
                                imageUrl: images,
                                fit: BoxFit.fitWidth,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(
                                      8,
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          aspectRatio: 16 / 8,
                          viewportFraction: .80,
                          onPageChanged: (index, reason) {
                            setState(() {
                              outerCurrentPage = index;
                            });
                          },
                        ),
                      ),

                      // Positioned(
                      //   left: 11,
                      //   child: CircleAvatar(
                      //     backgroundColor: Colors.white.withOpacity(0.5),
                      //     child: IconButton(
                      //       onPressed: () {
                      //         outerCarouselController
                      //             .animateToPage(outerCurrentPage - 1);
                      //       },
                      //       icon: const Icon(
                      //         Icons.arrow_back_ios,
                      //         size: 20,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //
                      // /// Right Icon
                      // Positioned(
                      //   right: 11,
                      //   child: CircleAvatar(
                      //     backgroundColor: Colors.white.withOpacity(0.5),
                      //     child: IconButton(
                      //       onPressed: () {
                      //         outerCarouselController
                      //             .animateToPage(outerCurrentPage + 1);
                      //       },
                      //       icon: const Icon(
                      //         Icons.arrow_forward_ios,
                      //         size: 20,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    imageurls.length,
                    (index) {
                      bool isSelected = outerCurrentPage == index;
                      return GestureDetector(
                        onTap: () {
                          outerCarouselController.animateToPage(index);
                        },
                        child: AnimatedContainer(
                          width: isSelected ? 30 : 10,
                          height: 10,
                          margin: EdgeInsets.symmetric(
                              horizontal: isSelected ? 6 : 3),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.blueAccent
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(
                              40,
                            ),
                          ),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black.withOpacity(0.2),
                ),
                post(),
              ],
            );
          },
        ),
      ],
    );
  }
  int likes= 123;
  bool liked =true;
  String posturl = "https://firebasestorage.googleapis.com/v0/b/crud1-5ff73.appspot.com/o/posts%2Fbmw-m3-touring-g81-mpp-03-wallpaper.jpg?alt=media&token=acdf1684-db46-4bf4-b736-eca793d0973d";

  Widget post() {
    return Card(
      color: Colors.cyan.shade100,
      child:  Padding(padding: EdgeInsets.all(10),
        child:Column(
          children: [
            Text("BMW ",style: TextStyle(fontSize: 20),),
            Image.network( posturl,
              width: MediaQuery.of(context).size.width/100*80,),
            Padding(
              padding: const EdgeInsets.only(top:5,left: 15),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: (){
                        setState(() {
                          liked =! liked;
                          if (liked){
                            likes += 1;
                          }
                          else{
                            likes -= 1;
                          }
                        });
                      }, icon:liked == true ?  const Icon(Icons.favorite ,color: Colors.red,size: 30,) : Icon(Icons.favorite_border,color: Colors.black,size: 30,),),
                  ),
                  Text(likes.toString() + "Like"),

                  // Padding(
                  //   padding: const EdgeInsets.only(left: 50),
                  //   child: IconButton(
                  //     onPressed: (){
                  //       setState(() {
                  //         liked =! liked;
                  //       });
                  //     }, icon: Icon(Icons.comment_outlined) ),
                  // ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
}
}
