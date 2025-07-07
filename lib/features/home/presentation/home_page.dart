import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:travelapp/features/experience/bloc/experience_state.dart';
import 'package:travelapp/features/home/bloc/home_bloc.dart';
import 'package:travelapp/features/home/bloc/home_event.dart';
import 'package:travelapp/features/home/bloc/home_state.dart';
import 'package:travelapp/features/home/model/destination_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var textLocation = new TextEditingController();
  DataDestination? selectedMenu;
  int? destinationid;

  List<DataDestination> destination = [];
  List<DataDestination> destinationHistory = [];

  List<String> imageList = [
    "https://perkim.id/wp-content/uploads/2025/03/ilustrasi-bali_169.jpeg",
    "https://perkim.id/wp-content/uploads/2025/03/ilustrasi-bali_169.jpeg",
    "https://perkim.id/wp-content/uploads/2025/03/ilustrasi-bali_169.jpeg",
    "https://perkim.id/wp-content/uploads/2025/03/ilustrasi-bali_169.jpeg"
  ];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeBloc>(context).add(destinationList());
    BlocProvider.of<HomeBloc>(context).add(getDestinationHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [
              textHeader("Promo"),
              promo(imageList),
              textHeader("Recent History"),
              searchBox(),
              recentHistory(),
            ],
          ),
        ),
      ],
    );
  }

  Widget recentHistory() {
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return SizedBox(
          height: 150, // tinggi wajib ditentukan untuk horizontal list
          child: ListView.builder(
            scrollDirection:
                Axis.horizontal, // 👈 ini bikin scroll dari kiri ke kanan
            itemCount: destinationHistory.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 120, // 👈 lebar ditentukan karena scroll horizontal
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      destinationHistory[index].name!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      listener: (BuildContext context, HomeState state) {
        if (state.state == RequestState.success) {
          destinationHistory = state.dataHistory;
        }
      },
    );
  }

  Widget textHeader(String description) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        child: Text(
          description,
          style: TextStyle(
            fontFamily: 'nunito',
            fontSize: 20.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
 Widget promo(List<String> image) {
    print("image list home");
    print(image.length);
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: image.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200, // Fixed width for horizontal scrolling
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image[index]),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  "Promo 50%",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.black45,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
 
 
  Widget searchBox() {
    return Center(
      child: Container(
        child: dropDownMenu(),
        height: 100.h,
        width: 200.w,

        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(30), // 👈 Rounded corners
        ),
      ),
    );
  }
Widget dropDownMenu() {
  return BlocConsumer<HomeBloc, HomeState>(
    builder: (BuildContext context, HomeState state) {
      return Material(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12), // ✅ rounded corners
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: DropdownMenu<DataDestination>(
            controller: textLocation,
            width: MediaQuery.of(context).size.width,
            hintText: null, // hint will be handled by label
            requestFocusOnTap: true,
            enableFilter: true,
            inputDecorationTheme: InputDecorationTheme(
              border: InputBorder.none,
              labelStyle: TextStyle(
                color: Colors.grey.shade600, // ✅ grey label
                fontSize: 16,
              ),
            ),
            label: const Text("Search your destination"),
            menuStyle: MenuStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            onSelected: (DataDestination? menu) {
              setState(() {
                selectedMenu = menu;
                destinationid = menu?.destinationId;
              });
            },
            dropdownMenuEntries: destination!
                .map<DropdownMenuEntry<DataDestination>>((menu) {
              return DropdownMenuEntry<DataDestination>(
                value: menu,
                label: menu.name ?? '',
              );
            }).toList(),
          ),
        ),
      );
    },
    listener: (BuildContext context, HomeState state) {
      if (state.state == HomeStateStatus.success) {
        destination = state.data;
        destinationHistory = state.dataHistory;
      }
    },
  );
}
}
