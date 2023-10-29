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
      // appBar: AppBar(
      //   title: const Text('Dashboard'),
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios),
      //     onPressed: () {
      //       // viewModel.goBack();
      //       viewModel.logOut();
      //     },
      //   ),
      // ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 40,
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
              const SizedBox(
                width: 20,
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
              const SizedBox(
                width: 20,
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
      body: PageStorage(
        bucket: viewModel.bucket,
        child: viewModel.currentScreen,
      ),
    );
  }
}
