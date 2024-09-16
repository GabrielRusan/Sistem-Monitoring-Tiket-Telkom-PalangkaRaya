import 'package:flutter/material.dart';
import 'package:telkom_ticket_manager/presentations/widgets/custom_text.dart';
import 'package:telkom_ticket_manager/utils/responsivennes.dart';

errorSnackbar(BuildContext context, String title, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.all(0),
      elevation: 0,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        left: ResponsiveWidget.isLargeScreen(context)
            ? 1200
            : ResponsiveWidget.isCustomScreen(context)
                ? 1000
                : ResponsiveWidget.isMediumScreen(context)
                    ? 800
                    : 200,
        right: 16,
      ),
      duration: const Duration(seconds: 1, milliseconds: 500),
      content: Container(
        padding: const EdgeInsets.all(8),
        height: 60,
        decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  color: Colors.white,
                  size: 16,
                  weight: FontWeight.bold,
                ),
                const Spacer(),
                CustomText(
                  text: message,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  size: 12,
                  color: Colors.white,
                  weight: FontWeight.w500,
                ),
              ],
            ))
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
    ),
  );
}
