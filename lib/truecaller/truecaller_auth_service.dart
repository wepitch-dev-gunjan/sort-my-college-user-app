


// import 'package:truecaller_sdk/truecaller_sdk.dart';

// class TrueCallerAuthService{
// //Import package


// startVerification()async{

// //Step 1: Initialize the SDK with OPTION_VERIFY_ONLY_TC_USERS
// TcSdk.initializeSDK(sdkOption: TcSdkOptions.OPTION_VERIFY_ONLY_TC_USERS);

// //Step 2: Check if SDK is usable on that device, otherwise fall back to any other login alternative
// bool isUsable = await TcSdk.isOAuthFlowUsable;

// //Step 3: If isUsable is true, then do the following before you can invoke the OAuth consent screen -
// //3.1: Set a unique OAuth state and store that state in your session so that you can match it with the state received from the authorization server to prevent
// //any request forgery attacks.
// //3.2: Set the OAuth scopes that you'd want to request from the user. You can either ask all of them together or a subset of it.
// //3.3: Generate a random code verifier either yourself or using the SDK method as shown below. Store the code verifier in the current session since it would
// //be required later to generate the access token.
// //3.4: Generate code challenge using the code verifier from the previous step
// //3.5 Set the code challenge
// //3.6 Finally, after setting all of the above, invoke the consent screen by calling getAuthorizationCode
// TcSdk.isOAuthFlowUsable.then((isOAuthFlowUsable) {
//     if (isOAuthFlowUsable) {
//         oAuthState = "some_unique_uuid" //store the state to use later
//         TcSdk.setOAuthState(oAuthState); //3.1
//         TcSdk.setOAuthScopes(['profile', 'phone', 'openid']); //3.2
//         TcSdk.generateRandomCodeVerifier.then((codeVerifier) { //3.3
//             TcSdk.generateCodeChallenge(codeVerifier).then((codeChallenge) { //3.4
//                 if (codeChallenge != null) {
//                     this.codeVerifier = codeVerifier; //store the code verifier to use later
//                     TcSdk.setCodeChallenge(codeChallenge); //3.5
//                     TcSdk.getAuthorizationCode; //3.6
//                 } else {
//                     print("***Code challenge NULL. Device not supported***");
//                 }
//             });
//         });
//     } else {
//         print("***Not usable***");
//     }
// },
                   
// //Step 4: Be informed about the TcSdk.getAuthorizationCode callback result(success, failure, verification)
// StreamSubscription streamSubscription = TcSdk.streamCallbackData.listen((tcSdkCallback) {
//   switch (tcSdkCallback.result) {
//     case TcSdkCallbackResult.success:
//       TcOAuthData tcOAuthData = tcSdkCallback.tcOAuthData!;
//       String authorizationCode = tcOAuthData.authorizationCode; //use this along with codeVerifier generated in step 3.3 to generate an access token
//       String stateReceivedFromServer = tcOAuthData.state; //match it with what you set in step 3.1
//       List<dynamic> scopesGranted = tcOAuthData.scopesGranted; //list of scopes granted by the user
//       break;
//     case TcSdkCallbackResult.failure:
//       //Handle the failure
//       int errorCode = tcSdkCallback.error!.code;
//       String message = tcSdkCallback.error!.message;
//       break;
//     case TcSdkCallbackResult.verification:
//     // won't receive this callback if initializing SDK with sdkOption as TcSdkOptions.OPTION_VERIFY_ONLY_TC_USERS
//       print("Verification Required!!");
//       break;
//     default:
//       print("Invalid result");
//   }
// }));
// }
// //Step 5: Dispose streamSubscription
// @override
// void dispose() {
//   streamSubscription?.cancel();
//   super.dispose();
// }
// }