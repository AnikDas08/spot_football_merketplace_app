# Implementation Plan - Social Media Section on Home Screen

The goal is to add a "Social Media" section at the very bottom of the home screen, fetching links from the `/social-media/` API endpoint and opening them in their respective apps if available.

## User Review Required

> [!IMPORTANT]
> - The section will be added at the bottom of the `HomeScreen` scrolling content.
> - I will use `url_launcher` with `LaunchMode.externalApplication` to try and open links in apps first.
> - I've noticed a potential typo in the screenshot ("PLATFROMS"), I will use "PLATFORMS" unless specified otherwise.

## Proposed Changes

### Data Layer
- **[NEW] social_media_model.dart**: Model to parse the API response from `/social-media/`.
- **[MODIFY] api_end_point.dart**: Add `socialMedia` constant for the endpoint.

### Logic Layer
- **[MODIFY] club_profile_controller.dart**: Add `fetchSocialMedia()` method and a `socialMediaList` to store the data. Fetch this data on initialization.

### Presentation Layer
- **[NEW] social_media_section.dart**: A new widget that displays the horizontal list of social media cards as per the screenshot.
- **[MODIFY] home_screen.dart**: Integrate the `SocialMediaSection` at the bottom of the `Column`.

## Verification Plan

### Manual Verification
- Launch the app and scroll to the bottom of the Home screen.
- Verify the "OUR SOCIAL PLATFORMS" section is visible.
- Click on a social media card (e.g., YouTube) and ensure it opens the app (if installed) or the browser.
- Perform a pull-to-refresh on the Home screen and ensure social media links are updated.
