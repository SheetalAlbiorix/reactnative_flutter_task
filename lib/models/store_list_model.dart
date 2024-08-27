class StoreListModel {
  String? image;
  String? name;
  String? time;
  String? spendAmount;
  String? saveAmount;
  bool? isNotified;

  StoreListModel(
      {this.image,
      this.name,
      this.time,
      this.spendAmount,
      this.saveAmount,
      this.isNotified});

  Map<String, dynamic> toJson() => {
        'image': image,
        'name': name,
        'time': time,
        'spendAmount': spendAmount,
        'saveAmount': saveAmount,
        'isNotified': isNotified,
      };

  factory StoreListModel.fromJson(Map<String, dynamic> json) {
    return StoreListModel(
      image: json['image'],
      name: json['name'],
      time: json['time'],
      spendAmount: json['spendAmount'],
      saveAmount: json['saveAmount'],
      isNotified: json['isNotified'],
    );
  }
}

final List<StoreListModel> stores = [
  StoreListModel(
      image:
          'https://imgs.search.brave.com/BrsUyDM5KPm6UGsBgtQklucDSYZw61rY3ju3X6CjA20/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTMx/MjI4MzU1Ny9waG90/by9jbGFzc2ljLXRo/YWktZm9vZC1kaXNo/ZXMuanBnP3M9NjEy/eDYxMiZ3PTAmaz0y/MCZjPTlZME5CeWxu/ak5pTmw2RWtLNlhh/YkVUemozdEhuSE9R/V3dWay02aVVFX0k9',
      name: 'Orange Inn',
      time: '10:00 AM',
      spendAmount: '\$100.00',
      saveAmount: '\$20.00',
      isNotified: false),
  StoreListModel(
      image:
          'https://imgs.search.brave.com/8hwWcSfaxpaTPI8bm2oVBbkxGkS5p3TJCpsMGxyfKuQ/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTI5/NTM4NzI0MC9waG90/by9kZWxpY2lvdXMt/bWVhbC5qcGc_cz02/MTJ4NjEyJnc9MCZr/PTIwJmM9aXNXNmRz/eHRkQUR0M3BPbHhH/am1LakZ5RVktRTc2/UTNUWE1tek45LXd1/TT0',
      name: 'Begs & Megs',
      time: '11:00 AM',
      isNotified: false),
  StoreListModel(
      image:
          'https://imgs.search.brave.com/nh-J34qpDYukTs-xYL5lkP5fh90FmyLau1nDADVnUBU/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAwLzQyLzE2LzE2/LzM2MF9GXzQyMTYx/NjY1X1RMVklTaHFm/OUUxeVRtVTR5WEZn/TFdjRVVtVzR6ZmpK/LmpwZw',
      name: 'Burger King',
      time: '12:00 PM',
      spendAmount: '\$200.00',
      saveAmount: '\$30.00',
      isNotified: false),
  StoreListModel(
      image:
          'https://imgs.search.brave.com/JqPwC7ZOo2sIXqNV5qLFj1CwRwrDdbqYN32Ynqy5g1w/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvMTM2/NTU0NjQ2MC9waG90/by93b21hbi10YWtl/cy1mcmVzaC1vcmdh/bmljLXZlZ2V0YWJs/ZXMuanBnP3M9NjEy/eDYxMiZ3PTAmaz0y/MCZjPWkzZ1BLbk9H/M1lWVGVrRW5WTGtG/M0tFTGdqenJGc0Rx/YVRZLTJNSGRsVWM9',
      name: 'Orchid White',
      time: '01:00 PM',
      spendAmount: '\$250.00',
      saveAmount: '\$20.00',
      isNotified: false),
  StoreListModel(
      image:
          'https://imgs.search.brave.com/8d_yMLz0C0-RyHIepcVP49bZOBHsXMPcZXoLB-_Th5w/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzA1LzE3Lzk2Lzg5/LzM2MF9GXzUxNzk2/ODk4OF9oRkhqUVQ2/Rmxma3NqeDhuMEt4/ZnZNdFAydHFsbUdL/ay5qcGc',
      name: 'Mocha',
      time: '02:00 PM',
      spendAmount: '\$300.00',
      saveAmount: '\$40.00',
      isNotified: false),
  StoreListModel(
      image:
          'https://media.istockphoto.com/id/657090194/photo/rajwari-or-rajwadi-sweet-kesar-badam-pista-kulfi-or-ice-cream-candy.webp?b=1&s=612x612&w=0&k=20&c=Jjauq4oXhMGao5fF7i_pAZmk9tSo2BU8bBzscGi46tU=',
      name: 'Cookies n Cream',
      time: '5:00 AM',
      spendAmount: '\$400.00',
      saveAmount: '\$20.00',
      isNotified: false),
  StoreListModel(
      image:
          'https://images.unsplash.com/photo-1447078806655-40579c2520d6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8N3x8fGVufDB8fHx8fA%3D%3D',
      name: 'Fruit Junction',
      time: '11:00 AM',
      spendAmount: '\$150.00',
      saveAmount: '\$20.00',
      isNotified: false),
  StoreListModel(
      image:
          'https://imgs.search.brave.com/8efEMEH7NP7Ky2C9N1yjH75VpqNAnOjMsH7P10cAdcA/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNTg5/NDE1NzA4L3Bob3Rv/L2ZyZXNoLWZydWl0/cy1hbmQtdmVnZXRh/Ymxlcy5qcGc_cz02/MTJ4NjEyJnc9MCZr/PTIwJmM9YUJGR1VV/LTk4cG5vaHQ3M2Nv/OHIyVFpJS0YzTUR0/QkJ1OUtTeHR4S19D/MD0',
      name: 'Veggies Hub',
      time: '10:00 AM',
      isNotified: false),
  StoreListModel(
      image:
          'https://imgs.search.brave.com/z4Wsv_BXjhSZftxnKaqnW4CXfURSbkEV_lp9UScogs0/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNDkx/MTE3ODc4L3Bob3Rv/L3NpbmdhcG9yZS1j/aGlsaS1jcmFiLmpw/Zz9zPTYxMng2MTIm/dz0wJms9MjAmYz04/NEYzOUFSZ3FGb18x/QTFOUld6Ym9LU1U1/WV9ISWRZN2ZPUmdv/aUJvS0lvPQ',
      name: 'Eatery',
      time: '01:00 PM',
      spendAmount: '\$250.00',
      saveAmount: '\$20.00',
      isNotified: false),
  StoreListModel(
      image:
          'https://imgs.search.brave.com/S7IWbjFt06buQ5N1dhnd-6UNW-Q8EN9azwbD64OMupI/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNDgx/MTQ5MjgyL3Bob3Rv/L3NvdXRoLWluZGlh/bi1mb29kLmpwZz9z/PTYxMng2MTImdz0w/Jms9MjAmYz13NDNu/YXEwNzQzWER2ekNp/NUZXX1JPdnp3NF9L/YUNrdWFtMTZzZnkz/aFRjPQ',
      name: 'Fixed Punch',
      time: '02:00 PM',
      isNotified: false),
];
