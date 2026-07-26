# Page Header Backgrounds Update Walkthrough

I have updated the header backgrounds for the **News Details** and **Club Profile** screens to use the new action shot image as requested by the client.

## Changes Made

### 1. Constants Update
Added the `banner.png` image to the [AppImages](file:///D:/Ajijul/spot_football_merketplace_app/lib/utils/constants/app_images.dart) class for global accessibility.

### 2. News Details Header
Updated the [NewsDetailsScreen](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/news_details/presentation/screens/news_details_screen.dart) to replace the old gradient background with the new `banner` image using `BoxFit.cover` for optimal scaling.

### 3. Club Profile Header
Updated the [LeagueHeaderWidget](file:///D:/Ajijul/spot_football_merketplace_app/lib/features/home/presentation/widgets/league_header_widget.dart) (used in the Club Profile screen) to replace the purple gradient with the new `banner` image.

## Verification Results

- [x] **News Details**: Verified that the header now displays the new action shot image.
- [x] **Club Profile**: Verified that the top section now displays the same consistent background.
- [x] **Scaling**: Both headers use `BoxFit.cover` to ensure the image fills the area correctly regardless of screen size.

render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/features/news_details/presentation/screens/news_details_screen.dart)
render_diffs(file:///D:/Ajijul/spot_football_merketplace_app/lib/features/home/presentation/widgets/league_header_widget.dart)
