# Dogs App
## Architecture
* uses some principles of clean architecture:
    * limits 3rd party libraries exposure
    * depend on abstractions
    * TDD thorougly
    * dependency rule - higher level abstractions don't depend on lower level.
    * is kinda domain driven
    * uses Command Query Request separation - command which mutate data are separated from queries
        * Helps share and propagate state and simplify presentation greatly
* components are separated into layers (which are not mandatory though)
    * View (ViewControllers, Views, ..)
        * renders data
    * Presentation (ViewModels, Formatters)
        * tranforms data for View to render
        * passes actions to domain
        * Uses Wireframes, Coordinators or whatever to navigate between scenes
    * Domain (UseCases, Repository interfaces, Repositories sometimes)
        * Business logic, uses stateless UseCases to access Repositories
    * Data Access (Repositories, Resources)
        * Uses Resources to access local or remote data

### App is separated in modules
Or rather should be, but I skipped that for this scale to focus on more important bits.
Module dependencies also adhere to dependency rule - module can't depend on module from higher level.
This is to further enforce boundaries, for instance feature should not be imported in generic or infrastructure.
* App
* Features
* Generic
* Infrastructure

## How to install
* Open Xcode and run, all 3rd party libraries are installed using Swift package manager
* Developed using Xcode 13

## Improvements
I didn't do those on purpose to fit under requested 8 hours while still showing something worth showing.
* Imperative world of UIKit with Combine framework is rough around the edges without any extension. It would deserve something similar to Bond and ReactiveKit
* Loading, proper error handling and reloading in case of error
* Features could be separated in multiple modules
* Support for iPad and/or landscape
* Sub-breeds are not reflected as of now
* Project setup - swiftlint, one-click deploy, localization, log collection, support for multiple configurations (staging, production,...)

## API
https://dog.ceo/dog-api/

