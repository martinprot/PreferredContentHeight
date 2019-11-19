# PreferredContentHeight

## Purpose 

I created this project in order to understand how the mecanism `preferredContentSize` and `func preferredContentSizeDidChange(forChildContentContainer:)` is working to bubble up the size of a embedded view controller.

## Structure & Problem

The main `ViewController` opens a `PopupViewController` that embeds a `UINavigationController` whose root view controller is the `ContentViewController`. Pfiou 😅

When the `ContentViewController`'s `preferredContentSize` changes, `UINavigationController.preferredContentSizeDidChange()` is called. 

I expected that the navigation controller would then set its preferredContentSize to bubble up the size by triggering `PopupViewController.preferredContentSizeDidChange()`. 

That is exactly which occurs when 

- ContentViewController preferred width increase
- ContentViewController preferred width decrease
- ContentViewController preferred height increase
- ~~ContentViewController preferred height decrease~~

Indeed, I don't know why, UINavigationController do not updates its `preferredContentSize` if the height of its active view controller decrease.

## Solution

I made a simple navigation controller subclasse which correctly bubble up the preferredContentSize of its active view controller: 

```swift
class CustomNavigationController: UINavigationController {
    override public func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        print("NAV UPDATING CONTENT SIZE")
        if self.navigationBar.isHidden {
            self.preferredContentSize = container.preferredContentSize
        }
        else {
            var size = container.preferredContentSize
            size.height += self.navigationBar.bounds.height
            self.preferredContentSize = size
        }
    }
}
```

Try it yourself.




