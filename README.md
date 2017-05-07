# BendCell


[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Sample Gif:

<p align="center"><img src="https://github.com/riamf/BendCell/blob/master/images/sample.gif" /></p>

## Description

It is a simple framework to simulate UITableViewCell bending during scrolling. Cell will be bend in the scrolling direction. It is all done with the power of drawing.

## How to use

It can be used with cells created from Xcode interface builder (storyboard or xib) and from code if you want to implement cells by your self.

Every cell should inherit from _BendableCell_ like in the example

```swift
class XibCell: BendableCell {
  // cell stuff here
}
```
Also your class implementing _UITableViewDelegate_  should now inherit from _BendableTableViewController_ :

```swift
class ViewController: BendableTableViewController {
  // class stuff here
}
```
After that there is no need to declare conformance to _UITableViewDelegate_ protocol.

_BendableTableViewController_ implements few of the protocol functions, listed:

* scrollViewDidScroll
* scrollViewDidEndDragging
* scrollViewDidEndDecelerating
* scrollViewDidScrollToTop

So please remember to call _super_ if you want to them in your own code.

## License
The MIT License (MIT)
