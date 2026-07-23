# Implementation Plan - Fix Subscription Controller & Package Loading

Restore the missing package loading logic in `SubscriptionController` and ensure the dynamic checkout process uses the correct package ID from the API response.

## User Review Required

> [!CAUTION]
> I accidentally removed the package loading logic in a previous update. I am now restoring the full implementation to ensure packages are fetched correctly from the server and can be selected for payment.

## Proposed Changes

### [Subscription Feature]

#### [MODIFY] [SubscriptionController](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/my_subscription/presentation/controller/subscription_controller.dart)
- **Restore `fetchPackages`**: Re-implement the logic to fetch packages based on user role (Player, Manager, Other) and handle authentication tokens from both `Get.arguments` and `LocalStorage`.
- **Verify `PackageModel`**: Ensure the `id` field maps correctly to `_id` from the JSON response.
- **Dynamic Checkout**: Ensure `generateCheckoutUrl` uses the verified package ID and handles the redirect to `WebViewScreen` correctly with all required dependencies imported.

## Verification Plan

### Manual Verification
- **Package Loading**: Open the Subscription screen and verify that the plans (Amateur, Semi-Pro, Pro) are visible and populated from the server.
- **Selection**: Click on a plan and ensure the Golden border appears.
- **Checkout**: Click "Continue" and verify the app successfully fetches a dynamic Stripe URL and opens it in the WebView.
