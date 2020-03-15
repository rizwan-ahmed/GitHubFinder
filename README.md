# GitHubFinder
This app is developed to demonstrate my coding skills. It search github user whose data fetched from https://developer.github.com/v3/users/#get-a-single-user API. It also shows the followers list of the User.
### Features
- Search github user by its user name
- View details page. It shows the basic info of the user like email, name etc along with its picture
- Followers List of the User

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and debugging purposes.

### Prerequisites

You would need a macbook with XCode 11.x installed. 

### Installing

- To be able to install the build on the iPhone you will be needing Apple Developer provisioning and certifcate. You can create your Apple developer account [here](https://developer.apple.com/).
- You can create build on iOS 13.x or later simulator provided with the XCode 11.x or later.
- To run the project Navigate to the *GitHubUserFinder* folder on your machine where you cloned it. And open the project using *GitHubUserFinder.xcodeproj* file.

## User Guide to use the app
- On Home page user need to search github user by its username
- If user is exist, it will show the basic info of the user along with it's followers list
- If user does not exist, it will show the error alert

## Technical Details

### ThirdParty
- No Third Party library is used and everything is build using native iOS components.

### App Architecture
- MVVM Architecture is used in the app.
- Network layer is based on URLSession

### Code Structure
Code has following Group
- Networking group contains all the files related to network layer. 
- Source group contains the modules with their respetive view or view controllers and view models. Source group contains further subgroups named UserDetailPage and SearchUser
- Models group contains all the models being used in the app.


## Built With
- XCode 11.1
- Tested on iPhone 8 polus. (iOS 13.2.3)

## Authors

- **Rizwan Ahmed** - (https://github.com/rizwan-ahmed)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details




