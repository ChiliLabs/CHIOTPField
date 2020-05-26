# CHIOTPField

CHIOTPField is a set of textfields that can be used for One-time passwords, SMS codes, PIN codes, etc. All fields support insertion of one-time codes from SMS.

Made with ❤️ by [Chili Labs](https://chililabs.io).

## Overview

<img src="Gif/preview.gif" width="500" height="164">

## Requirements

* iOS 10.0+
* Swift 5

## Installation

### Manually

Just add the `Sources` folder to your project.

### CocoaPods

use [CocoaPods](https://cocoapods.org) with Podfile:
``` ruby
pod 'CHIOTPField', '~> 0.1'

# individual page control
pod 'CHIOTPField/One'
pod 'CHIOTPField/Two'
pod 'CHIOTPField/Three'
pod 'CHIOTPField/Four'
```

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/ChiliLabs/CHIOTPField.git", .upToNextMajor(from: "0.1"))
]
```

## Usage
### 🎨 Storyboards
Just drop UITextField and set its class to be one of CHIOTPField.
<img src="Gif/ibdesignable.gif" width="800" height="617">
### 💻 Code
``` swift
let field = CHIOTPFieldOne(frame: .init(x: 0, y: 0, width: 200, height: 60))
field.numberOfDigits = 4
field.cornerRadius = 4
```
