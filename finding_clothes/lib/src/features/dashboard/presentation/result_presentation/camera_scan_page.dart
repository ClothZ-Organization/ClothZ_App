import 'package:camera/camera.dart';
import 'package:finding_clothes/src/features/dashboard/application/camera_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/application/camera_page_view_model.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_button.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_card_scan.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class CameraScanPage extends ConsumerWidget {
  const CameraScanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(cameraPageViewModel);
    return Scaffold(
      body: viewModel.isNotOkSearch()
          ? upgradeCameraScreen(viewModel: viewModel)
          : Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  child: CameraPreview(cameraController),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SvgPicture.asset(
                        'lib/icons/scanner.svg',
                        // colorFilter:
                        //     const ColorFilter.mode(Colors.white, BlendMode.srcATop),
                        height: MediaQuery.sizeOf(context).width - 40,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FCCardScan(
                      titleText: 'Upload from galery',
                      descriptionText:
                          'Upload your own photo to find similar products and the best prices.',
                      iconPath: 'lib/icons/album.svg',
                      onTap: () async {
                        if (await viewModel.getImage(false)) {
                          // ignore: use_build_context_synchronously
                          FCDialogUtils.showAlertDialog(context);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    buttonTakePhoto(
                      onTap: () {
                        viewModel.getImage(true);
                        debugPrint('take photo button');
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget buttonTakePhoto({required VoidCallback onTap}) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: const Color(0xFFD9D9D9),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(90),
      ),
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(90.0),
          color: const Color(0xFFD9D9D9),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.grey[800],
            borderRadius: BorderRadius.circular(90.0),
            onTap: onTap,
            child: Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(90),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget upgradeCameraScreen({required final viewModel}) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ClipRRect(
            child: Image.asset(
              'assets/images/backgroundUpgradePlan.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'You need a subscription to scan more',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                  height: 1.12,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FCButton(
                text: 'Upgrade Plan',
                onTap: () async {
                  viewModel.goSubscritionPage();
                },
              ),
            ],
          ),
        ),
        // Center(child: Text('You need a subscription to scan more.')),
      ],
    );
  }
}
