# NinetyNine Test app

For networking I use [AbsNet](https://github.com/santiagofranco/AbsNet), a lib of mine, that I use in personal projects.
It is not "production-ready" yet, that's why I copied it as a folder in this project instead of using cocoapods.

All the unit test of both of the modules of the app are made with TDD, by using XCTestCase class. And without using libs to mocking due to the simplicity of the app. 

There are two branches, master and rxswift.
1. master contains a VIPER version, and it is a version that I consider ready for production (except for the lack of localizable files).
2. rxswift contains also a VIPER architecuture, but using rxswift & rxcocoa for events in view side, and rxswift for network calls and timer logic in interactors side. I also adapted the .test suite so the test are still passing.

UI testing left out because of simplifying.

I was learning RxSwift programming whilst made this app, so I used it in the best manner I figured out how, and in the manner, I consider the code is still clean, maintainable, scalable and testable.

The VIPER architecture is an implementation of this [clean architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
