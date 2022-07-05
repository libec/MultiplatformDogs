# Multiplatform Dogs
If you're interested in Dogs and Multiplatform code, this is the right place.

This repository contains a swift package that shares application logic between:
* iOS app which uses UIKit,
* iOS app which uses SwiftUI,
* and macOS app.

The app is quite simple and has only three features:
* List of dog breeds,
* collection of dog images for each breed,
* and a collection of user-favorite dogs.

![app.gif](https://github.com/libec/MultiplatformDogs/blob/develop/Docs/app.gif)


## What's the purpose?
Demonstrate that it's possible to have one module shared across multiple apps - **regardless of the UI framework** used to render it on the screen. The swift package contains everything besides the client-specific View layer.

## Applied principles
**Command Query Responsibility Segregation**
* Commands that modify data are separated from queries.
* Subscription to state updates comes easy with no overhead. 

**Repository Pattern**
* Stores and distributes the state.
* Shields domain logic from the data access.

**Dependency Injection**
* Swift package contains a complete dependency graph.
* It's then extended by the specifics of the client apps.
* Uses scopes to share repository implementations.

**Test Driven Development**
* Ensures that DI is done right.
* Serves as executable documentation.
* Makes sure each component is the right size, as the big classes are difficult to test.

## What's not the purpose?
The purpose is **NOT** to demonstrate and establish best practices in SwiftUI and Combine. There are multiple ways to implement DI, CQRS, handle state, SwiftUI re-rendering, etc. Consider this just one example.

## How to install
* Open in Xcode (preferably 13.4.1)
* Wait for the SPM to do its thing
* Run

## Who and why
I did this in my free time to learn. It later became a workshop for cleverlance.com - thanks for providing me with additional time to finish.

## API
https://dog.ceo/dog-api/
