# RickAndMortyApp

## Prerequisites to Run

- Xcode 12.5
- iOS 14.5
- An Apple developer account (to sign the app)

## Usage

The Rick And Morty App has 3 main functions:
- View Characters
- View Episodes
- View Locations

These can all be accessed using the tab bar at the bottom of the screen. Pulling down on any of these screens will refresh the data. Scrolling to the bottom and pulling up will fetch the next page, if necessary.

You can tap on any of the items in the view to open a sheet that will present more information about that item.

Inside these sheets, anything in blue is tappable and will open a subsequent sheet. If you really wanted to spend a long time in the app, you could end up a few hundred sheets deep!

## Technologies

The entire app is built using UIKit. While I could have used SwiftUI, I decided I wanted the extra challenge of building a completely programmatic UI using AutoLayout and UIKit.

Additionally, this app doesn't rely on any third party frameworks or libraries.

All network calls leverage `URLSession`.

The Characters screen uses `UICollectionView` and `UICollectionViewDiffableDataSource`. This seemed appropriate as each character has an image, so the grid format worked well.

Both the Episodes and Locations screens use `UITableView`, given that no image is provided with each data entry.

## Architecture and Design Patterns

Principally the app's architecture is MVC. This was decided as it is essentially the "default" when it comes to creating UIKit-based apps. 

I was able to keep my ViewControllers small - no Massive-ViewControllers to be found here!

Additional design patterns and principles include:
- Repository pattern (for storing and manipulating data models)
- Dependency injection (to enable testability of my repositories)
- Singleton (used for my JSONManager and NetworkManager)

## Other Cool Things...

Strings within the app have been fully localized and translated to French. You can check out the French version of the app by changing the scheme to `RickAndMortyApp (FR-CA)`.

No messages are printed to the console warning of conflicting constraints or anything of that nature - I am confident that the constraints I have used are stable and result in a good UI.

I wrote some simple unit tests using XCTest to demonstrate my knowledge of unit testing, mocking and dependency injection, and achieved 36.5% code coverage by testing the repositories alone.

The app with Voiceover to ensure the app was accessible, and thanks to default UIKit behaviour and a good choice in labels, the app appeared to be accessible.

## If I had more time...

- I'd have looked for more cases where code duplication has occurred in order to improve maintenance
- I would improve the Character/Episode/Location views so that appropriate names would be shown instead of the plain URL
- I'd test the ViewControllers too to maximise code coverage
- I'd add extra customization to the UI based on whether data was loading, if there was an error or if the data simply did not exist
