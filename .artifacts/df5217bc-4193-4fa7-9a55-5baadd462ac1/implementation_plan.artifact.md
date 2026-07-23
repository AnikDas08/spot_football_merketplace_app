# Implementation Plan - Navigation Security Fix (Payment Flow)

Ensure users cannot bypass the payment screen and access their roles/home screen without a successful transaction.

## User Review Required

> [!IMPORTANT]
> - Users who reach the `MySubscriptionScreen` after login will be **blocked** from using the back button or system gestures to navigate elsewhere.
> - Successful payment is the **only** way to proceed to the home screen or role-specific setup.
> - The `onWillPop` or `PopScope` will be used to prevent navigation away from the payment screen.

## Proposed Changes

### [Navigation & Logic]

#### [MODIFY] [MySubscriptionScreen](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/my_subscription/presentation/screens/my_subscription_screen.dart)
- Wrap the `Scaffold` or its body with `PopScope` (or `WillPopScope` depending on the Flutter version used in the project).
- In the pop handler, check `isFromRegistration` and `LocalStorage.paymentStatus`:
    - If `paymentStatus` is false and it's a mandatory payment flow, return `false` to block the back action.
    - Optionally, provide a logout button or a "Cancel" action that takes the user back to the onboarding/login screen instead of Home.

#### [MODIFY] [SubscriptionController](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/my_subscription/presentation/controller/subscription_controller.dart)
- Ensure that the success callback in `generateCheckoutUrl` explicitly updates `LocalStorage.paymentStatus` before navigating to the Home screen.

### [Branding & UI]

#### [MODIFY] [CommonImage](file:///D:/Ajijul/spot_football_merketplace_app/lib/component/image/common_image.dart)
- Update `defaultImage` default value to `AppImages.appLogo`.
- In the `_buildNetworkImage` error widget, ensure the `defaultImage` is returned.
- In the `build` method, if `imageSrc` is null or empty, return the `defaultImage`.

#### [MODIFY] [AppDrawer](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/drawer/presentation/screen/app_drawer.dart)
- Remove manual ternary check for `image.isEmpty`.
- Let `CommonImage` handle the default logo for the logged-in user.

#### [MODIFY] [ClubProfileScreen](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/home/presentation/screens/club_profile_screen.dart)
- Update `_PlayerRow` to use `CommonImage` with the new default behavior.

#### [MODIFY] [TeamSheetScreen](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/team_sheet/presentation/screen/team_sheet_screen.dart)
- Update tactical board nodes and lists to use `CommonImage` defaults.

## Verification Plan

### Manual Verification
- **Security Check**: Reach the payment screen. Try the hardware back button and swipe back gesture. Verify the app stays on the payment screen.
- **Success Check**: Complete a simulated/test payment. Verify it takes you to the Home screen correctly.
- **Branding Check**: Navigate to various lists (Players, Lineups, Drawer). Verify any entry with a missing profile image shows the ENG logo.
