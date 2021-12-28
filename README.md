# Dogs App
## Architecture
* uses some principles of clean architecture:
    * limits 3rd party libraries exposure
    * depend on abstractions
    * TDD thoroughly
    * dependency rule - higher level abstractions don't depend on lower level.
    * is kinda domain driven
    * uses Command Query Request separation - command which mutate data are separated from queries
        * Helps share and propagate state and simplify presentation greatly
* components are separated into layers (which are not mandatory though)
    * View (ViewControllers, Views, ..)
        * renders data
    * Presentation (ViewModels, Formatters)
        * transforms data for View to render
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
* Uses [tuist](https://docs.tuist.io/tutorial/get-started) to generate project
* Open Xcode and run, all 3rd party libraries are installed using Swift package manager
* Developed using Xcode 13.2.1

## API
https://dog.ceo/dog-api/
