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
    "https://perkim.id/wp-content/uploads/2025/03/ilustrasi-bali_169.jpeg",
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
          height: 917.h,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 100),
              textHeaderMain("Find your place"),
              textHeader("Promo"),
              promo(imageList),
              textHeader("Find your experience"),
              searchBox(),

              // buttonSubmitExperience(),
              textHeader("Recent History"),
              recentHistory(),
            ],
          ),
        ),
      ],
    );
  }

  Widget recentHistory() {
    print("kedetect gaaa");
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return SizedBox(
          height: 150, 
          child: ListView.builder(
            scrollDirection:
                Axis.horizontal,
            itemCount: destinationHistory.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 120, 
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

  Widget textHeaderMain(String description) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        child: Text(
          description,
          style: TextStyle(
            fontFamily: 'nunito',
            fontSize: 25.sp,
            color: const Color.fromARGB(255, 32, 32, 32),
          ),
        ),
      ),
    );
  }

  Widget buttonSubmitExperience() {
    return ElevatedButton(
      onPressed: () {
        context.read<HomeBloc>().add(insertDestinationHistory(selectedMenu!));
        if (destinationid == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('This is a snackbar!'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          context.go("/experience/$destinationid");
        }
      },
      child: Text("Search"),
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
                  "Get your 50% deals at Otaqu",
                  style: TextStyle(
                        decoration: TextDecoration.none,

                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.normal,
                    // backgroundColor: Colors.black45,
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
        height: 200.h,
        width: 412.w, // full width container
        decoration: BoxDecoration(
          color: const Color.fromARGB(10, 200, 200, 200),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Where do u wanna go?",
                    style: TextStyle(
                      fontFamily: 'nunito',
                      fontSize: 15.sp,
                      color: Color.fromARGB(100, 160, 160, 160),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              // ⬅️ This centers the dropdown inside the container
              child: SizedBox(child: dropDownMenu()),
            ),
            buttonSubmitExperience(),
          ],
        ),
      ),
    );
  }

  Widget dropDownMenu() {
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return Material(
          color: Colors.transparent, // ⬅️ avoid default white background

          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50.h,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // or any variable like `col`
                width: 1, // optional: default is 1.0
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: DropdownMenu<DataDestination>(
              controller: textLocation,
              width: MediaQuery.of(context).size.width,
              hintText: null, // hint will be handled by label
              requestFocusOnTap: false,
              enableFilter: true,
              trailingIcon: const SizedBox.shrink(),

              inputDecorationTheme: InputDecorationTheme(
                border: InputBorder.none,
                labelStyle: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
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
                  })
                  .toList(),
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
