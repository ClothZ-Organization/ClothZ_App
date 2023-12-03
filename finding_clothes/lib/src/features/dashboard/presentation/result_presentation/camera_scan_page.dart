import 'package:camera/camera.dart';
import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/application/result_page_view_model.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_card_scan.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraScanPage extends ConsumerWidget {
  const CameraScanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(resultPageViewModel);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: CameraPreview(cameraController),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
}
