import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AppSize.s40,
          height: AppSize.s40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(ImageAssets.notificationAvatar, fit: BoxFit.fill)
        ),
        const SizedBox(width: AppSize.s10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Joy Arnold left 6 comments on Your Post', style: getMediumStyle(color: ColorManager.black)),
              const SizedBox(height: AppSize.s10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: AppSize.s4,
                    height: AppSize.s60,
                    decoration: BoxDecoration(
                      color: ColorManager.notificationStick,
                      borderRadius: BorderRadius.circular(AppSize.s10),
                    ),
                  ),
                  const SizedBox(width: AppSize.s10),
                  Flexible(
                    child: Text('“leaves are an integral part of the stem system. They are attached by a continuous vascular system to the rest of the plant so that free exchange of nutrients.”', style: getMediumStyle(color: ColorManager.black)),
                  )
                ],
              ),
              const SizedBox(height: AppSize.s10),
              Text('Yesterday at 11:42 PM', style: getRegularStyle(color: ColorManager.notificationDate)),
            ],
          ),
        )
      ],
    );
  }
}