import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kchat/state/global_state.dart';
import 'package:kchat/widget/button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BottomSheetHelper {
  static void simplePopup(
      {required BuildContext context, required String text}) async {
    await show(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Text(text,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 16.h),
            Button(
                text: "OK",
                onPressed: () {
                  Navigator.pop(context);
                }),
            SizedBox(height: 16.h)
          ],
        ));
  }

  static Future<void> show(
      {required BuildContext context,
      required Widget child,
      bool isDismissible = true,
      bool showHandle = true,
      bool enableDrag = true}) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showHandle)
                Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 8.h),
                  decoration: BoxDecoration(
                    color: GlobalState.isDarkMode(context)
                        ? Colors.grey[700]
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              Flexible(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 0.8.sh,
                    ),
                    child: IntrinsicHeight(
                      child: child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showLoadingPopup(
      {required BuildContext context, String text = "Loading..."}) async {
    await show(
      context: context,
      isDismissible: false, // Prevent dismissal
      enableDrag: false, // Prevent dragging to close
      showHandle: false, // Hide the handle
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.h),
          LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).colorScheme.secondary, size: 100.sp),
          SizedBox(height: 16.h),
          Text(text,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  static void closeLoadingPopup(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
