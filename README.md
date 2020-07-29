![App Brewery Banner](Documentation/AppBreweryBanner.png)

# Clima

## Our Goal

It’s time to take our app development skills to the next level. We’re going to introduce you to the wonderful world of Cocoapods and open source libraries. These will power your apps to do incredible things without having to spend months coding up the functionality. Additionally, we’ll learn how to call Application Programming Interfaces (APIs) to grab data from websites. If you’re dreaming of making that Twitter-powered stock trading app then you’re about to get a lot closer to your goal!

## About The App

Clima is a location-aware weather app. It will find out where you are in the world and query an open source weather service to retrieve the temperature and weather conditions. Also, you can change the city at the tap of a button. Want to know what it’s like in Rio? Clima is here to help. Weather apps are so popular that they get their own category in the App Store.

## What I learned

* How to use CocoaPods to manage and use open source code libraries. 
* How to use the Command Line on Mac with Terminal.
* Learn about Networking calls.
* Use public web-based APIs to fetch data.
* How to parse data organised in JSON format.
* Learn about Core Location and utilising the iPhone’s inbuilt GPS. 
* Learn about navigation between View Controllers using Segues.
* Introduction to Delegates and Protocols.
* How to pass data between View Controllers.
* Learn and use Switch statements





## Fix for App Transport Security Override (HTTP)

```XML
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSExceptionDomains</key>
		<dict>
			<key>openweathermap.org</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
				<true/>
			</dict>
		</dict>
	</dict>
```


