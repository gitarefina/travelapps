import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travelapp/features/experience/bloc/experience_bloc.dart';
import 'package:travelapp/features/experience/bloc/experience_event.dart';
import 'package:travelapp/features/experience/bloc/experience_state.dart';
import 'package:travelapp/features/experience/model/experience_model.dart';

class ExperiencePage extends StatefulWidget {
  final int id;
  const ExperiencePage({super.key, required this.id});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final ScrollController _scrollController = ScrollController();
  List<Package> model = [];
  int? id;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void Loading() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = !isLoading;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // String experienceId = GoRouterState.of(context).pathParameters['id']!;
    // id = int.tryParse(experienceId ?? '');
    // print("experienceId " + id.toString());
    context.read<ExperienceBloc>().add(
      getDataExperience(destination_id: widget.id, nextPage: page),
    );
    print("bloc experience id");
    print(id);
    _scrollController.addListener(onScroll);
  }

  int page = 1;
  void onScroll() {
    setState(() {
      page++;
    });

    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll - 200) {
      print("nambah gaaa");
      context.read<ExperienceBloc>().add(
        getDataExperience(destination_id: widget.id, nextPage: page),
      );
    }
    // });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocConsumer<ExperienceBloc, ExperienceState>(
        builder: (BuildContext context, state) {
          return ListView.separated(
            controller: _scrollController,
            itemCount: model.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < model.length) {
                return isLoading
                    ? shimmerBuilder()
                    : Container(
                        height: 126.h,
                        width: 250.w,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(99, 219, 219, 219),
                          borderRadius: BorderRadius.circular(
                            30,
                          ), // Radius of 16
                        ),

                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 30,
                                top: 20,
                                bottom: 10,
                              ),
                              child: Container(
                                height: 126.h,
                                width: 100.h,
                                child: Image.network(
                                  model[index].images[0],
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value:
                                              loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    (loadingProgress
                                                            .expectedTotalBytes ??
                                                        1)
                                              : null,
                                        ),
                                      );
                                    }
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                        size: 48,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 200.w,
                                  height: 100,
                                  child: Text(
                                    state.experience[index].name!,
                                    style: TextStyle(
                                      fontFamily: "nunito",
                                      fontSize: 19.sp,
                                      color: const Color.fromARGB(
                                        255,
                                        58,
                                        58,
                                        58,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 100),
                          ],
                        ),
                      );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1.h, thickness: 1, color: Colors.white);
            },
          );
        },
        listener: (BuildContext context, ExperienceState state) {
          if (state.state == RequestState.success) {
            model = state.experience;
          } else if (state.state == RequestState.failure) {
          } else if (state.state == RequestState.loading) {
            Loading();
          }
        },
      ),
    );
  }

  Widget shimmerBuilder() {
    return Shimmer.fromColors(
      child: Container(
        height: 126.h,
        width: 250.w,
        decoration: BoxDecoration(
          color: Color.fromARGB(99, 219, 219, 219),
          borderRadius: BorderRadius.circular(30), // Radius of 16
        ),

        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 20, bottom: 10),
              child: Container(height: 126.h, width: 100.h, child: Container()),
            ),
            Container(
              width: 200.w,
              height: 100,
              child: Text(
                "",
                style: TextStyle(
                  fontFamily: "nunito",
                  fontSize: 10.sp,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
      baseColor: const Color(0xFFE0E0E0), // light gray
      highlightColor: const Color(0xFFF5F5F5),
    );
  }
}
