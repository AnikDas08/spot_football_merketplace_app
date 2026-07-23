# Account Deletion Request Feature Walkthrough

I have implemented the "Account Deletion" request feature, allowing users to securely submit a request to support via email.

## Changes Made

### 1. New Account Deletion Screen
Created a brand-consistent screen where users can provide a reason for account deletion.
- **Pre-filled Email**: The user's email is displayed in a read-only field for verification.
- **Reason Input**: A multi-line text field for the user to explain their request.
- **Smart Email Intent**: The "Send Request" button automatically opens the device's default email app (or a web fallback) with all details pre-filled.

### 2. Navigation & Drawer Integration
- **Route Registration**: Registered the `/delete_account` route in the app's global router.
- **Drawer Menu**: Added a "Delete Account" item to the side drawer.
- **Access Control**: This option is automatically hidden for Guest users and is only visible when logged in.

### 3. UI & Branding
- Applied **Playfair Display** for the main title and followed the project's typography standards.
- Used **Title Case** for all labels and button text.

## Verification Results

- [x] **Access Control**: Verified that the "Delete Account" option only appears for logged-in users.
- [x] **ReadOnly Field**: Confirmed the email field cannot be edited by the user.
- [x] **Email Intent**: Tested the intent logic (mailto) to ensure it correctly maps recipient, subject, and body.

render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/features/auth/delete_account/presentation/screen/delete_account_screen.dart)
render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/features/drawer/presentation/screen/app_drawer.dart)
