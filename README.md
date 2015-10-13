LJAutoScrollView
=================

LJAutoScrollView class provides an endlessly circulate scroll view. It allows auto scrolling infinitely in the horizontal direction.

- It offers an encapsulation of UICollectionView to support reuse features.

- Use NSTimer for auto scrolling.

- The implement of infinite scroll is inspired by this page:[Circular Infinite UIScrollView]

Installation
----------
Grab the source file into your project.

Or use cocoapods. Here is an example of your podfile:

```
pod 'LJAutoScrollView'
```

Usage
------
- LJAutoScrollView is a subclass of UIView. Just take it as UIView when initialization.
```
self.autoScrollView = [[LJAutoScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kAutoScrollViewHeight)];

self.autoScrollView.delegate = self;
```

- Configure it as you like.

```
self.autoScrollView.itemSize = CGSizeMake(self.view.frame.size.width, kAutoScrollViewHeight);

self.autoScrollView.scrollInterval = 3.0f;
```

- Don't forget to implement the delegate methods.

Check the demo project for more details.

License
-----------
LJAutoScrollView is available under the MIT license. See the LICENSE file for more info.

[Circular Infinite UIScrollView]:http://iosdevelopertips.com/user-interface/creating-circular-and-infinite-uiscrollviews.html
