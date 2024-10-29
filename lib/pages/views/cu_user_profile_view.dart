import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:makemoney/core/commen/app_utils.dart';
import 'package:makemoney/pages/views/withdraw_view.dart';
import 'package:makemoney/service/model/user_model.dart';
import 'package:makemoney/service/stateManagment/provider/fetch_task_provider.dart';
import 'package:makemoney/service/stateManagment/provider/market_provider.dart';
import 'package:makemoney/widgets/funds_widget.dart';
import 'package:provider/provider.dart';

import '../../core/commen/constants.dart';
import '../../service/firestoreServices/social_service.dart';
import '../../service/stateManagment/provider/cu_user_provider.dart';
import '../../widgets/container_widget.dart';
import '../../widgets/listtile_shimmer_widget.dart';
import '../../widgets/my_coin_widget.dart';
import '../../widgets/read_user_widgdraw_notification.dart';
import '../../widgets/shimmer_effect_widget.dart';
import 'deposit_view.dart';

class UserProfile extends StatefulWidget {
  final UserModel userModel;

  const UserProfile({
    super.key,
    required this.userModel,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    final market = Provider.of<MarketProvider>(context, listen: false);
    market.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  imageUrl: widget.userModel.profileUrl!,
                  placeholder: (context, url) => AppUtils().waitLoading(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                  "Hello, ${widget.userModel.name}",
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  "${widget.userModel.phoneNumber}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            )
          ],
        ),
        actions: [
          const NotificationsBadge(),
          InkWell(
            onTap: () {
              AppUtils().exitDialog(context, () async {
                final userPro = Provider.of<CuUserProvider>(
                  context,
                  listen: false,
                );
                await userPro.logout().then((va) {
                  Get.back();
                  Get.back();
                });
              });
            },
            child: const Icon(Icons.logout),
          ),
          SizedBox(width: Get.width * 0.04),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.02),
              Consumer<CuUserProvider>(builder: (context, value, child) {
                if (value.user != null) {
                  return Card(
                    shadowColor: Colors.grey.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // <-- Radius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          SizedBox(height: Get.height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Account balance:"),
                              Row(
                                children: [
                                  const Text(
                                    "(1.20x )",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Image.asset(LocalImg.dLogo, height: 30),
                                  const SizedBox(width: 8),
                                  Text(
                                    value.user!.balance.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(LocalImg.dLogo, height: 30),
                              const SizedBox(width: 8),
                              Text(
                                value.user!.coinBalance.toString(),
                                style: const TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    if (widget.userModel.uid ==
                                        'W59hbs0PkFc8V9zbKrq62JEU4uO2') {
                                      AppUtils().toast(
                                        "NA KAR TU ADMIN HAI.",
                                      );
                                    } else {
                                      Get.to(
                                        () => WithdrawView(
                                          userModel: widget.userModel,
                                        ),
                                      );
                                      // final depositPro =
                                      //     Provider.of<WithdrawProvider>(context,
                                      //         listen: false);
                                      // // Call this to fetch the latest deposits
                                      // await depositPro.fetchDeposits();
                                      // final lastDeposit = await depositPro
                                      //     .getLastApprovedUserWithdraw(
                                      //         widget.userModel.uid!);
                                      // if (lastDeposit != null) {
                                      //   if (lastDeposit.isApproved == true) {
                                      //     // Navigate to the DepositMoneyCom screen
                                      //     Get.to(
                                      //       () => WithdrawView(
                                      //         userModel: widget.userModel,
                                      //       ),
                                      //     );
                                      //   } else {
                                      //     // Show toast if the last deposit is not approved
                                      //     AppUtils().toast(
                                      //         "Please wait for your last withdraw to be approved.\nبراہ کرم اپنے آخری ڈپازٹ کے منظور ہونے کا انتظار کریں۔");
                                      //   }
                                      // } else {
                                      //   Get.to(
                                      //     () => WithdrawView(
                                      //       userModel: widget.userModel,
                                      //     ),
                                      //   );
                                      // }
                                    }
                                  },
                                  child: Card(
                                    color: Colors.greenAccent,
                                    shadowColor: Colors.grey.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20) // <-- Radius
                                        ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (widget.userModel.uid ==
                                        'W59hbs0PkFc8V9zbKrq62JEU4uO2') {
                                      AppUtils().toast("NA KAR TU ADMIN HAI.");
                                    } else {
                                      Get.to(
                                        () => DepositView(
                                          userModel: widget.userModel,
                                        ),
                                      );
                                    }
                                  },
                                  child: Card(
                                    color: Colors.greenAccent,
                                    shadowColor: Colors.grey.withOpacity(0.4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20), // <-- Radius
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.01),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Please Login to continue"),
                  );
                }
              }),

              ///show analytics data
              SizedBox(height: Get.height * 0.01),
              SizedBox(
                height: Get.height / 6.6,
                child:
                    Consumer<MarketProvider>(builder: (context, value, child) {
                  if (value.isLoading) {
                    return const ShimmerEffectWidget();
                  } else {
                    return Row(
                      children: [
                        const MyCoinWidget(), //
                        Expanded(
                          child: ListView.builder(
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: value.markets.length,
                            itemBuilder: (con, int index) {
                              var data = value.markets[index];
                              return FundsWidget(
                                model: data,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ),

              SizedBox(height: Get.height * 0.02),
              Consumer<TaskProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(
                        child: ListTileShimmerWidget(
                      count: 4,
                      isLoad: true,
                    ));
                  }
                  if (provider.socialLinks.isEmpty) {
                    return const Center(child: Text('No social links found'));
                  }
                  // Display the list of social links
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.socialLinks.length,
                    itemBuilder: (context, index) {
                      final socialLink = provider.socialLinks[index];
                      final int colorValue =
                          int.parse(socialLink['color'], radix: 16);
                      final Color color = Color(0xFF000000 | colorValue);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ContainerWidget(
                          onTap: () async {
                            await SocialService().launchTask(
                              socialLink['link'],
                              socialLink['name'],
                            );
                          },
                          textColor: Colors.white,
                          bgColor: color,
                          task: socialLink['name'],
                          urdu: socialLink['task'] == ""
                              ? 'Task'
                              : socialLink['task'],
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: Get.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
