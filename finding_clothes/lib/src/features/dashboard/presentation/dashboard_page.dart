import 'package:auto_route/auto_route.dart';
import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_bottom_tab_bar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(dashboardViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // viewModel.goBack();
            viewModel.logOut();
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 40,
        // child: Container(
        //   color: Colors.red,
        // ),

        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FCBottomTabBarButton(
                isSelected: viewModel.isThis(0),
                iconButton: Icons.home,
                onTap: () {
                  viewModel.setTab(0);
                  viewModel.setText("Welcome to Goodleap's dashboard!");
                  debugPrint("--- dashboard");
                },
              ),
              FCBottomTabBarButton(
                isSelected: viewModel.isThis(1),
                iconButton: Icons.fit_screen_sharp,
                onTap: () {
                  viewModel.setTab(1);
                  viewModel.setText("Scan!");
                  debugPrint("--- d2");
                },
              ),
              FCBottomTabBarButton(
                isSelected: viewModel.isThis(2),
                iconButton: Icons.bookmark_border,
                onTap: () {
                  viewModel.setTab(2);
                  viewModel.setText("Bookmark border");
                  debugPrint("--- d3");
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                height: double.infinity,
                width: MediaQuery.sizeOf(context).width / 2,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/womenD.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: double.infinity,
                width: MediaQuery.sizeOf(context).width / 2,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/manD.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  viewModel.textView,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                    height: 1.64,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const Spacer(),
                // Container(
                //   height: 100.0,
                //   color: Colors.amber,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
