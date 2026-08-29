import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:rate_my_app/rate_my_app.dart';

class MenspotWebView extends StatelessWidget {
  final String title;
  final String selectedUrl;

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 5, // Show rate popup after 5 launches of app after minDays is passed.
    remindDays: 0,
    remindLaunches: 10,
    googlePlayIdentifier: 'com.tonyyounes',
    appStoreIdentifier: '1468302034',
  );

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  MenspotWebView({
    required this.title,
    required this.selectedUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebView(
          initialUrl: selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {

            _controller.complete(webViewController);
            rateMyApp.init().then((_) {
               if (rateMyApp.shouldOpenDialog) {
                 rateMyApp.showRateDialog(
                   context,
                   title: 'Rate this app',
                   // The dialog title.
                   message: 'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.',
                   // The dialog message.
                   rateButton: 'RATE',
                   // The dialog "rate" button text.
                   noButton: 'NO THANKS',
                   // The dialog "no" button text.
                   laterButton: 'MAYBE LATER',
                   // The dialog "later" button text.
                   listener: (
                       button) { // The button click listener (useful if you want to cancel the click event).
                     switch (button) {
                       case RateMyAppDialogButton.rate:
                         print('Clicked on "Rate".');
                         break;
                       case RateMyAppDialogButton.later:
                         print('Clicked on "Later".');
                         break;
                       case RateMyAppDialogButton.no:
                         print('Clicked on "No".');
                         break;
                     }

                     return true; // Return false if you want to cancel the click event.
                   },
                   ignoreNativeDialog: true,
                   // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
                   dialogStyle: const DialogStyle(),
                   // Custom dialog styles.
                   onDismissed: () =>
                       rateMyApp.callEvent(RateMyAppEventType
                           .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
                   // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
                   // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
                 );
               }
            });
          },
          /*navigationDelegate: (NavigationRequest request) {
            devlog.log(request.url);
            if (request.url.contains('wa.me')) {
              launchUrlString(request.url); //This is where Whatsapp launches
              return NavigationDecision.prevent;
            }
          },*/
        ));
  }
}