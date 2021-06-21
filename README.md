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

You can also tap the 'Search' button in the top right to apply different filters.

You can tap on any of the items in the view to open a sheet that will present more information about that item.

Inside these sheets, anything in blue is tappable and will open a subsequent sheet. If you really wanted to spend a long time in the app, you could end up a few hundred sheets deep!

## Technologies

The app is built using a mixture of programmatic UIKit and SwiftUI. The core of the app (the three screens seen in the tab bar, plus the info sheets) are built using UIKit. The filter screens are built using SwiftUI. I decided to do this in order to demonstrate that I have experience using both technologies.

Additionally, this app doesn't rely on any third party frameworks or libraries.

All network calls leverage `URLSession`.

The Characters screen uses `UICollectionView` and `UICollectionViewDiffableDataSource`. This seemed appropriate as each character has an image, so the grid format worked well. A different layout is used for iPhone and iPad, making better use of the larger screen to display more cells per row.

Both the Episodes and Locations screens use `UITableView`, given that no image is provided with each data entry.

## Architecture and Design Patterns

Principally the app's architecture is MVC. This was decided as it is essentially the "default" when it comes to creating UIKit-based apps. 

I was able to keep my ViewControllers small - no Massive-ViewControllers to be found here!

Additional design patterns and principles include:
- Repository pattern (for storing and manipulating data models)
- Dependency injection (to enable testability of my repositories)
- Singleton (used for my JSONManager and NetworkManager)

Initially I had three separate repositories for each data type (Character, Location, Episode), however I refactored this code to use generic types, making the code easier to maintain in the future.

I also simplified my API code into one single API class, rather than three.

## Other Cool Things...

Strings within the app have been fully localized and translated to French. You can check out the French version of the app by changing the scheme to `RickAndMortyApp (FR-CA)`.

No messages are printed to the console warning of conflicting constraints or anything of that nature - I am confident that the constraints I have used are stable and result in a good UI.

I wrote some simple unit tests using XCTest to demonstrate my knowledge of unit testing, mocking and dependency injection, and achieved 23.6% code coverage by testing the repositories alone.

I tested the app with Voiceover to ensure the app was accessible, and thanks to default UIKit behaviour and a good choice in labels, the app appeared to be accessible.

## If I had more time...

- I'd have looked for more cases where code duplication has occurred in order to improve maintenance
- I would improve the Character/Episode/Location views so that appropriate names would be shown instead of the plain URL
- I'd test the ViewControllers too to maximise code coverage
- I'd add extra customization to the UI based on whether data was loading, if there was an error or if the data simply did not exist
