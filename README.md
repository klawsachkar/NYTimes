# NYTimes
This app shows the Most Popular News of New York City

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software

```
Mac
Xcode 10
```

### Libraries

The Libraries that were used to make this app work

```
SwiftyJSON: used for using JSON objects
Kingfisher: used for downloading images from URL
ObjectMapper: used to map JSON objects into Swift Objects
Alamofire: used to perform api calls
AlamofireObjectMapper: used to map JSON objects into Swift Objects inside Alamofire
SugarRecord/CoreData: used to save, read data into the Database
```

### Installing

A step by step series that tell you how to get a development env running

Step 1: Installing Cocoapods

```
Open Terminal:
$ sudo gem install cocoapods
```

Step 2: Clone or Download the Project 

```
Clone using any Git Source IDE
Or
Download the project directly from GitHub
```

Step 3: Install Pods of the Project 

```
Open Terminal:
cd {your project path that contains the Podfile file}
pod install
```

Step 4: Run your project

```
Open the workspace file of the project in Xcode
Run the project
```

## Running the tests

From the Test Navigator in Xcode

### Unit Tests

These tests will run the Apis that the app uses and save the results into the DB

```
testGetNewsForOneDay
testGetNewsForSevenDays
testGetNewsForThirtyDays
```

### UI Tests

These tests will run the app and try the user possible behaviors

```
testGetNewsByPullingToRefresh
testShowDetailsByTapping
```

## Author

* **Klaws Achkar** - *Senior iOS Developer* - (https://github.com/klawsachkar)
