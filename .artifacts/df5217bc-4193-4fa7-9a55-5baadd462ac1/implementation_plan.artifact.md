# Implementation Plan - Policy Compliance for Play Store

Refine app content and subscription terms to avoid rejection due to the use of external payments (Stripe). The goal is to rebrand "Premium Features" into "Academy Membership Benefits" and ensure all legal text aligns with physical service delivery.

## Proposed Changes

### [UI Components]

#### [MODIFY] [Manager Subscription Screen](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/auth/sign%20up/presentation/screen/manager_subscription_screen.dart)
- Change "unlock premium features" to "access advanced team management tools".

### [Legal Content - Safe Version]

I recommend using the following text for your **Subscription Terms & Conditions** on your dashboard/API:

> **Academy Membership Terms**
>
> **Membership Subscription:** By registering for an academy plan, you agree to the applicable recurring payment for access to physical academy events, training sessions, and grassroots league participation.
>
> **Auto-Renewal:** Your membership automatically renews to ensure continuous participation in the upcoming season unless canceled before the renewal date.
>
> **Billing:** Payments are processed securely via our partner provider (Stripe) and charged at the start of each membership period.
>
> **Cancellation:** You may cancel your membership at any time through your account settings within the app. Cancellation takes effect at the end of the current cycle.
>
> **Refund Policy:** Membership fees are dedicated to ground bookings and event scheduling and are non-refundable, except where required by UK consumer law.
>
> **Membership Benefits:** All benefits, including match participation and reward credit earning (ENG Coins), are available only during an active membership period.
>
> **Service Availability:** Access to the platform may occasionally be affected by maintenance or technical updates required for match reporting and stats tracking.
>
> **Contact:** For support regarding your membership, email us at contact@engsportsevents.com.

## Verification Plan

### Manual Verification
- **Code Audit**: Search the entire project for the word "Premium" and ensure it is not used in the context of paid features.
- **UI Check**: Verify that the Manager Subscription screen no longer uses the word "premium".
