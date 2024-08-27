import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reactnativetask/utils/shared_data.dart';
import '../../models/store_list_model.dart';
import '../../utils/base_colors.dart';
import '../../utils/base_strings.dart';
import '../../utils/base_text_styles.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Timer? _timer;
  int _counter = 0;
  List<bool> toggleStates = List.generate(10, (index) => false);
  List<StoreListModel>? upcomingData = [];

  @override
  void initState() {
    getData();
    super.initState();
    _startTimer();
  }

  getData() async {
    upcomingData = await SharedData().getDataStored();
    print(upcomingData?[0].isNotified);
    if (upcomingData!.isEmpty) {
      setState(() {
        upcomingData?.addAll(stores);
      });
    } else {
      setState(() {
        upcomingData =  upcomingData;
      });
    }

  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _counter++;
        showNotification();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: const Text(BaseStrings.featuredStores)),
      body: ListView.builder(
        itemCount: upcomingData?.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            elevation: 10.0, // Adjust elevation here
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.grey.shade400, width: 1.0),
            ),
            child: ListTile(
              horizontalTitleGap: 8,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.grey.shade400, width: 1.0),
              ),
              dense: true,
              tileColor: BaseColors.baseColor,
              leading: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: upcomingData?[index].image ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    height: 60.0, // Increased size
                    width: 60.0, // Increased size
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // Ensures the image is circular
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              title: Text('${upcomingData?[index].name}',
                  style: TextStyles.boldText),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${BaseStrings.opensAt} ${upcomingData?[index].time}',
                      style: TextStyles.subtitleText),
                  upcomingData?[index].spendAmount != null
                      ? Text(
                          '${BaseStrings.spend} ${stores[index].spendAmount}, ${BaseStrings.save} ${stores[index].saveAmount}',
                          style: TextStyles.subText)
                      : const Text("")
                ],
              ),
              trailing: CupertinoSwitch(
                activeColor: BaseColors.greenColor,
                trackColor: BaseColors.greyColor.withOpacity(0.3),
                value: upcomingData![index].isNotified ?? false,
                onChanged: (bool value) async {
                  // Update the value in your data list
                  setState(() {
                    upcomingData?[index].isNotified = value;
                    print(upcomingData?[0].isNotified);

                    SharedData().saveDataStored(upcomingData!);
                  });

                  // Retrieve the updated data from SharedPreferences
                  var retrievedData = await SharedData().getDataStored();

                  // Print the updated data
                  print(retrievedData);


                },
              ),
            ),
          );
        },
      ),
    );
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> showNotification() async {
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'channel_id', // Your channel ID
    'channel_name', // Your channel name
    channelDescription: 'Channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Notification Title',
    'Notification Body',
    notificationDetails,
    payload: 'Notification Payload', // Optional payload
  );
}
