# Implementation Plan - Robust API Message Handling and Snackbar Fixes

Improve the extraction of meaningful messages from API responses and fix snackbars that display status codes instead of descriptive titles.

## Proposed Changes

### [Core Services]

#### [MODIFY] [api_response_model.dart](file:///D:/Ajijul/spot_football_merketplace_app/lib/services/api/api_response_model.dart)
- Enhance the `message` getter to check for multiple common fields (`message`, `msg`, `error`, `error_description`).
- Add logic to handle cases where the API response might be a direct string or nested under a `data` object (e.g., `data['message']`).
- Fallback to `AppString.someThingWrong` only if no descriptive text is found.

### [Authentication Controllers]

#### [MODIFY] [sign_in_controller.dart](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/auth/sign%20in/presentation/controller/sign_in_controller.dart)
- Replace `title: response.statusCode.toString()` with `title: 'Success'` in the success snackbar.
- Replace `title: response.statusCode.toString()` with `title: 'Error'` in the error snackbar.

#### [MODIFY] [forget_password_controller.dart](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/auth/forgot%20password/presentation/controller/forget_password_controller.dart)
- Replace `title: response.statusCode.toString()` with `title: 'Error'` in the error snackbar within `sendForgetPasswordEmail`.

### [Consistency & Cleanup]

#### [MODIFY] Multiple Controllers
Refactor the following controllers to use `response.message` instead of manually accessing `response.data['message']` for better consistency and error handling:
- [live_match_control_controller.dart](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/live_match_control/presentation/controller/live_match_control_controller.dart)
- [record_goal_controller.dart](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/live_match_control/presentation/controller/record_goal_controller.dart)
- [player_profile_controller.dart](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/player_profile/presentation/controllers/player_profile_controller.dart)
- [referee_dashboard_controller.dart](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/referee_dashboard/presentation/controller/referee_dashboard_controller.dart)
- [transfer_request_controller.dart](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/transferms/presentation/controller/transfer_request_controller.dart)

## Verification Plan

### Manual Verification
- **Sign In**: Attempt to sign in with incorrect credentials. Verify the snackbar title says "Error" and the message is descriptive (e.g., "Invalid email or password").
- **Forget Password**: Enter an invalid email. Verify the snackbar title says "Error" and shows a meaningful message.
- **Other Actions**: Perform actions like approving a transfer or recording a goal. Verify that snackbars show descriptive text from the API rather than generic messages or codes.
