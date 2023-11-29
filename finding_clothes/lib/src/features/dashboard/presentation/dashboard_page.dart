import 'package:auto_route/auto_route.dart';
import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/features/drawer/presentation/drawer_page.dart';
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
      drawer: const DrawerPage(),
      drawerScrimColor: Colors.transparent,
      bottomNavigationBar: BottomAppBar(
        height: 60,
        padding: const EdgeInsets.all(0),
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 40,
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FCBottomTabBarButton(
                isSelected: viewModel.isThis(0),
                iconButton: Icons.home,
                onTap: () {
                  viewModel.setTab(0);
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
