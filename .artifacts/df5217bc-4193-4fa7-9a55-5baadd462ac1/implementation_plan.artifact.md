# Implementation Plan - Dynamic Stripe Checkout Integration

Update the subscription flow to use the dynamic checkout URL generation endpoint instead of the static `paymentLink` from the package model.

## User Review Required

> [!IMPORTANT]
> The app will now call `GET /package/{id}/checkout` to obtain a fresh Stripe checkout URL every time the "Continue" button is pressed. This ensures the checkout session is correctly tied to the user's current context.

## Proposed Changes

### [Subscription Logic]

#### [MODIFY] [SubscriptionController](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/my_subscription/presentation/controller/subscription_controller.dart)
- Add `isCheckingOut` observable to track the API request state.
- Implement `handleCheckout(String packageId, bool isFromRegistration, ProfileController profileController)`:
    - Calls the new endpoint: `${ApiEndPoint.packages}/$packageId/checkout`.
    - Retrieves the `checkoutUrl` from the response.
    - Navigates to `WebViewScreen` with the generated URL.
    - Handles payment success logic (navigation and status updates).

### [UI Components]

#### [MODIFY] [MySubscriptionScreen](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/my_subscription/presentation/screens/my_subscription_screen.dart)
- Update the "Continue" button:
    - Bind its `isLoading` property to `controller.isCheckingOut.value`.
    - Update `onTap` to invoke `controller.handleCheckout`.
- Ensure the checkout process provides visual feedback while fetching the URL.

## Verification Plan

### Manual Verification
- **Registration Flow**:
    - Start a new registration.
    - Reach the subscription screen.
    - Select a package and click "Continue".
    - Verify that a loader appears on the button and then the Stripe checkout page opens in a WebView.
- **Plan Upgrade Flow**:
    - Log in as an existing user.
    - Navigate to "My Subscriptions" -> "Change Your Subscription Plan".
    - Select a new package and click "Continue".
    - Verify the same dynamic checkout behavior.
- **Error Handling**:
    - Verify that a descriptive error snackbar appears if the checkout URL cannot be generated.
