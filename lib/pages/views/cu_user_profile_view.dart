import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:makemoney/pages/accountsView/create_user_account.dart';
import 'package:makemoney/service/model/user_model.dart';
import 'package:makemoney/widgets/funds_widget.dart';

class UserProfile extends StatelessWidget {
  final UserModel userModel;

  const UserProfile({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: Get.height / 12,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: userModel.profileUrl!,
                    placeholder: (context, url) => AppUtils().waitLoading(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: Get.width * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hello, ${userModel.name}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "${userModel.phoneNumber}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              )
            ],
          ),
          actions: [
            const Icon(
              Icons.notification_add,
              size: 30,
            ),
            SizedBox(width: Get.width * 0.04),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.02),
              Card(
                shadowColor: Colors.grey.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // <-- Radius
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(height: Get.height * 0.01),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Account balance"),
                          Text("23423"),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "343495",
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Card(
                              color: Colors.greenAccent,
                              shadowColor: Colors.grey.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // <-- Radius
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: Get.height * 0.01),
                                    const Icon(Icons.play_arrow),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    const Text("Withdraw"),
                                    SizedBox(height: Get.height * 0.02),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              color: Colors.greenAccent,
                              shadowColor: Colors.grey.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(20), // <-- Radius
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: Get.height * 0.01),
                                    const Icon(Icons.stop),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    const Text("Deposit"),
                                    SizedBox(height: Get.height * 0.02),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.01),
                    ],
                  ),
                ),
              ),

              ///show analytics data
              SizedBox(height: Get.height * 0.01),
              SizedBox(
                height: Get.height / 7.1,
                child: ListView.builder(
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 12,
                  itemBuilder: (con, int index) {
                    return const FundsWidget();
                  },
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              TabBar(
                tabs: [
                  Tab(
                    icon: Text("Most Popular"),
                  ),
                  Tab(
                    icon: Text("Biggest Moves"),
                  ),
                  Tab(
                    icon: Text("Recomends"),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.confirmation_num,
                        ),
                      ),
                      title: Text("Polygon"),
                      subtitle: Text("MA"),
                      trailing: Text("\$0.011"),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Icon(
                          Icons.confirmation_num,
                        ),
                      ),
                      title: Text("Paython"),
                      subtitle: Text("Rate"),
                      trailing: Text("\$0.091"),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        child: Icon(
                          Icons.confirmation_num,
                        ),
                      ),
                      title: Text("Bitcoin"),
                      subtitle: Text("ssd"),
                      trailing: Text("\$0.043"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
