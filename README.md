TwentyFourHours is a library for apps that are supposed to run all day long e.g. as a public display.
It lets you specify when the app is allowed to go idle and when not.

As of Version 0.0.1 you can specify

* the hour of the day after which the app is NOT allowed to go idle
* the hour of the day after which the app IS allowed to go idle
* for a) Monday - Friday and b) Saturday.

On Sunday the app is always allowed to go idle

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party code like NSUserDefaults+SettingsBundle in your projects.

### Podfile

```ruby
pod 'TwentyFourSeven'
```

## Usage

Add the setting pane to your existing Settings.bundle's Root.plist

```plist
<dict>
  <key>Type</key>
  <string>PSChildPaneSpecifier</string>
  <key>Title</key>
  <string>Shop Hours</string>
  <key>File</key>
  <string>ShopHours</string>
</dict>
```

### Initialize the Scheduler (objective-c)

in your AppDelegate.m file

```objective-c
#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [TwentyFourSeven sharedInstance];
}
@end
```

in your AppDelegate.h file

```objective-c
#import "TwentyFourSeven-Swift.h"
```
