import 'package:auto_route/auto_route.dart';
import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
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
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text("Welcome to Goodleap's dashboard!", style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        height: 1.64,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),),
                Spacer(),
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
