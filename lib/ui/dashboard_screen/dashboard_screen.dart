import 'dart:async';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:reactnativetask/utils/shared_data.dart';
import '../../models/store_list_model.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_strings.dart';
import '../../utils/base_text_styles.dart';
import '../signin_screen/signin_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Map<int, Timer?> notificationTimers = {};
  List<StoreListModel>? upcomingData = [];
  TimeOfDay? selectedTime;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    upcomingData = await SharedData().readDataStored();
    if (upcomingData!.isEmpty) {
      setState(() {
        upcomingData?.addAll(stores);
      });
    } else {
      setState(() {
        upcomingData = upcomingData;
      });
    }

    // Initialize timers for already toggled on items
    for (int i = 0; i < upcomingData!.length; i++) {
      if (upcomingData![i].isNotified ?? false) {
        _startNotificationTimer(i);
      }
    }
  }

  String? getRandomImageUrl() {
    if (upcomingData == null || upcomingData!.isEmpty) {
      return ''; // Or return a default image URL
    }

    final random = Random();
    final randomIndex = random.nextInt(upcomingData!.length);
    return upcomingData![randomIndex].image;
  }

  void _startNotificationTimer(int index) {
    notificationTimers[index]?.cancel(); // Cancel any existing timer
    notificationTimers[index] =
        Timer.periodic(const Duration(seconds: 5), (timer) {
      showNotification();
    });
  }

  void _stopNotificationTimer(int index) {
    notificationTimers[index]?.cancel();
    notificationTimers.remove(index);
  }

  Future<void> _showAddDataDialog() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController imageController = TextEditingController();
    final TextEditingController spendAmountController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    final TextEditingController saveAmountController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(BaseStrings.addStore),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(labelText: BaseStrings.storeName),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return BaseStrings.enterStoreName;
                      }
                      return null;
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      final TimeOfDay? time = await showTimePicker(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return MediaQuery(
                              data: MediaQuery.of(context)
                                  .copyWith(alwaysUse24HourFormat: false),
                              child: child!);
                        },
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null && time != selectedTime) {
                        setState(() {
                          selectedTime = time;
                          timeController.text = formatTimeOfDay(time);
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: timeController,
                        decoration: const InputDecoration(
                          labelText: BaseStrings.openTime,
                          suffixIcon: Icon(Icons.access_time),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return BaseStrings.selectTime;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: spendAmountController,
                    decoration: const InputDecoration(
                        labelText: BaseStrings.spendAmount),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return BaseStrings.enterSpendAmount;
                      }
                      if (double.tryParse(value) == null) {
                        return BaseStrings.enterValidAmount;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: saveAmountController,
                    decoration: const InputDecoration(
                        labelText: BaseStrings.saveAmount),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return BaseStrings.enterSaveAmount;
                      }
                      if (double.tryParse(value) == null) {
                        return BaseStrings.enterValidAmount;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(BaseStrings.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final newStore = StoreListModel(
                    name: nameController.text,
                    image: imageController.text,
                    time: timeController.text,
                    spendAmount: double.tryParse(spendAmountController.text)
                            ?.toString() ??
                        '',
                    saveAmount: double.tryParse(saveAmountController.text)
                            ?.toString() ??
                        '',
                    isNotified: false,
                  );
                  setState(() {
                    upcomingData?.add(newStore);
                    SharedData().saveDataStored(upcomingData!);
                  });
                  Navigator.of(context).pop();
                } else {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: const Text(BaseStrings.add),
            ),
          ],
        );
      },
    );
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    final format = DateFormat.jm();
    return format.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
            onPressed: () {
              SharedData().saveUserCredentialsData(false);
              SharedData().clearData();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                  (Route<dynamic> route) => false);
            },
            child: const Row(
              children: [
                Text(
                  BaseStrings.signOut,
                  style: TextStyles.boldText,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.logout),
                )
              ],
            ))
      ], title: const Text(BaseStrings.featuredStores)),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 80.0),
            itemCount: upcomingData?.length,
            itemBuilder: (context, index) {
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.grey.shade400, width: 1.0)),
                child: ListTile(
                  horizontalTitleGap: 8,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side:
                          BorderSide(color: Colors.grey.shade400, width: 1.0)),
                  dense: true,
                  tileColor: BaseColors.baseColor,
                  leading: ClipOval(
                    child: CachedNetworkImage(
                        imageUrl: upcomingData?[index].image ?? "",
                        imageBuilder: (context, imageProvider) => Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => ClipOval(
                          child: Image.network(
                            getRandomImageUrl()!,
                            width: 50.0, // Set the width of the circle
                            height: 50.0, // Set the height of the circle
                            fit: BoxFit.cover,
                          ),
                        ),
                    ),
                  ),
                  title: Text('${upcomingData?[index].name}',
                      style: TextStyles.boldText),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${BaseStrings.opensAt} ${upcomingData?[index].time}',
                          style: TextStyles.subtitleText),
                      upcomingData?[index].spendAmount != null
                          ? Text(
                              '${BaseStrings.spend} ${upcomingData?[index].spendAmount}, ${BaseStrings.save} ${upcomingData?[index].saveAmount}',
                              style: TextStyles.subText)
                          : const Text(""),
                    ],
                  ),
                  trailing: CupertinoSwitch(
                    activeColor: BaseColors.greenColor,
                    trackColor: BaseColors.greyColor.withOpacity(0.3),
                    value: upcomingData![index].isNotified ?? false,
                    onChanged: (bool value) async {
                      setState(() {
                        upcomingData?[index].isNotified = value;
                        SharedData().saveDataStored(upcomingData!);
                      });

                      if (value) {
                        _startNotificationTimer(index);
                      } else {
                        _stopNotificationTimer(index);
                      }
                    },
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
                onPressed: _showAddDataDialog,
                backgroundColor: BaseColors.greenColor,
                child: const Icon(Icons.add)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Cancel all timers when the widget is disposed
    for (var timer in notificationTimers.values) {
      timer?.cancel();
    }
    super.dispose();
  }

  Future<void> showNotification() async {
    final List<String> activeStores = upcomingData!
        .where((store) => store.isNotified == true)
        .map((store) => store.name ?? "")
        .toList();
    final String activeStoresString = activeStores.join(", ");

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'Channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Store Notification',
      'Toggles ON: $activeStoresString',
      notificationDetails,
      payload: 'Active Stores: $activeStoresString',
    );
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
