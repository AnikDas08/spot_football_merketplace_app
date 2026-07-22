# API Message Handling & Snackbar Improvements Walkthrough

I have improved how the app handles API messages and fixed several snackbars that were displaying technical details instead of user-friendly information.

## Changes Made

### 1. Robust Message Extraction
Updated `ApiResponseModel` to intelligently extract messages from API responses. It now checks for multiple common fields (`message`, `msg`, `error`, `error_description`) and handles various response structures. This ensures that if the server provides a specific reason for a failure, the app displays it correctly.

### 2. Standardized Snackbar Titles
Fixed snackbars in the authentication flow (`SignInController` and `ForgetPasswordController`) that were previously using status codes (like "200", "400") as titles. They now use descriptive titles:
- **"Success"**: For successful actions.
- **"Error"**: For failed actions.
- **"Rejected"**: For rejection actions (e.g., rejecting a transfer).

### 3. Centralized Message Logic
Refactored several controllers to use the standardized `response.message` property. This removes redundant manual parsing logic from the UI layer and ensures consistency across the app.
Affected controllers:
- `LiveMatchControlController`
- `RecordGoalController`
- `PlayerProfileController`
- `RefereeDashboardController`
- `TransferRequestController`

## Verification Results

- [x] Sign-in errors now show "Error" instead of "400" or "401".
- [x] Forget password success/error titles are corrected.
- [x] Action snackbars (recording goals, approving transfers) now pull their text directly from the server's descriptive `message` field when available.

render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/services/api/api_response_model.dart)
render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/features/auth/sign%20in/presentation/controller/sign_in_controller.dart)
render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/features/transferms/presentation/controller/transfer_request_controller.dart)
