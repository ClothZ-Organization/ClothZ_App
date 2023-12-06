import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlanCard extends StatelessWidget {
  final bool isSelected;
  final String text;
  final VoidCallback onTap;
  const PlanCard({
    super.key,
    required this.isSelected,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: isSelected ? const Color(0xFF343434) : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 16,
          ),
          child: Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color:
                      isSelected ? const Color(0xFF7C00FF) : Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(90)),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : Colors.white,
                    width: 1.0,
                  ),
                ),
                child: isSelected
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset(
                          'lib/icons/check.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcATop),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(
                width: 7,
              ),
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0,
                  height: 1.21,
                  color: Color(0xFFFFFFFF),
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
