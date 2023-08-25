# Widgets

Widgets is a demo app the demonstrates the power of `UICollectionViewCompositionalLayout` to produce multiple flexible layouts with some added algorithms to produce a random, cool looking mosaic-esque grid.

---

# Index
- [Setup](#setup-%EF%B8%8F)
- [Getting Started](#getting-started-)
    - [Architecture](#architecture)
    - [Logic](#logic)
- [Notes](#notes-%EF%B8%8F)
- [TODOs](#todos-%EF%B8%8F)
- [Demo](#demo-%EF%B8%8F)
- [Built using](#built-using-%EF%B8%8F)

---

## Setup ⚙️
Clone and run the project. No addtional steps are needed!

Each time you click the refresh button a random group of widgets are generated and shuffled to fit in a cool looking mosaic-esque grid.

---

## Getting Started 🏁 
### Architecture
This project is built using [VIP Architecture](https://www.kodeco.com/29416318-getting-started-with-the-vip-clean-architecture-pattern)

> VIP is an architectural pattern like MVC, MVP or MVVM. Its main difference is the clear logic separation between its components.

> VIPER already existed, but its implementation was a bit too complex and didn’t allow you to use segues.
The VIP pattern is a unidirectional architectural pattern. You might have already heard of some others, such as Redux, Flux or Model-View-Intent (MVI). These patterns focus on reactive UIs and state management.
Unidirectional patterns share one property: Their components are all interconnected and aren’t designed to mix. Each has its own clear responsibility.

![VIP Cycle](https://miro.medium.com/v2/resize:fit:1162/1*fHJVYYiH-zk6o7Qe5GoJcw.png)

### Logic
Since the demo is focusing on creating a mosaic-esque grid UI, most of the app's logic is centeralized in the presentation layer. The main resposibilty of the presentation layer is grouping the widgets into chunks that can make sense together in a row (i.e. full sized item, fifty fifty row, quadruple row, etc). Then each chunk is mapped to a corresponding `NSCollectionLayoutGroup` that is composed and declared very clearly each in its own function. Below is the group/row compositions that the app support as of now.

#### Full Sized

Full sized compositions consists of only one large widget. The widget takes the full width of the collection and the height will be determined according to its conent.

![Full sized](https://i.ibb.co/1MzBjZB/full-sized.png)


#### Fifty fifty

Fifty fifty compositions consists of two square widgets. Each widget takes half the width of the collection and is always shown as a square. The content will be clipped if it contradicts the 1:1 ratio of the widget itself.

![Fifty fifty](https://i.ibb.co/ZMDdLJK/full-sized.png)

#### Quadruples

Quadruple compositions consists of up to 4 mini widgets. Each widget takes quarter the width of the collection and is always shown as a square. The content will be clipped if it contradicts the 1:1 ratio of the widget itself. This compossition can contain less than 4 mini widgets and will be pushed to the leading edge if so.

![Quadruples](https://i.ibb.co/VqJf5yt/full-sized.png)

#### Mixed

Mixed compositions consists of 1 square widget and up to 4 mini widgets. This compossition can contain less than 4 mini widgets and will be pushed to the leading, top edge if so.

![Mixed](https://i.ibb.co/zxzdBjb/Simulator-Screenshot-i-Phone-14-Pro-2023-08-25-at-17-47-12.png)

---

 ## Notes ⚠️
 - The app doesn't use any third party libraries.
 - The widgets scene is built using only one cell for demonstrartion. In a real world scenario you'd probably have to use multiple cells to define different styles for each. Since the app is built using POP, providing different cells can be done smoothly without affecting the presentation logic.
 - The content of large and square cells is randomly generated to demonstrate full-sized widgets changing their height according to the content, and square widgets priotrizing their 1:1 aspect ratio over their content.

---
 
 ## TODOs ✔️
 - [ ] Snapshot testing (Would be a very valuable addition to the project)
 - [ ] Supporting other cell arrangements as triplets, large squares, etc.
 
 ---
 
 ## Demo 🤩️

 *Wait for it to load or use [the url](https://i.ibb.co/NCJyBLy/my-gif.gif)*

 ![Demo](https://i.ibb.co/NCJyBLy/my-gif.gif)
 
 ---
  
## Built using 🔧️

- Swift 5
- Xcode 14.3.1
- UIKit
- XCTest
