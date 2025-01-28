# **DesignSystem Module Documentation**

---

## **Introduction**

The `DesignSystem` module provides an abstraction and standardization layer for reusable UI styles and components within the application. It ensures visual consistency by defining pre-set colors, fonts, sizes, margins, and shadows, along with UI components like `DSHeaderView`, `DSSearchBar`, `DSCenteredSpinnerView`, and more.

This module follows a modular architecture to ensure scalability and reusability throughout the application.

---

## **Folder Structure**

The `DesignSystem` module is organized into the following sections:

1. **`Animations/`** - Contains motion effects such as `DSTimeAnimation` and `DSParallaxMotionManager`.
2. **`Components/`** - Includes reusable UI components like `DSHeaderView`, `DSSearchBar`, `DSCenteredSpinnerView`.
3. **`Images/`** - Defines image-related styles within `DSImage`.
4. **`Styles/`** - Contains design styles such as `DSColors`, `DSFonts`, `DSShadows`, `DSSpacing`.
5. **`Theme/`** - Separates **colors** and **fonts** configurations into `DSColors` and `DSFonts`.
6. **`Tests/`** - Includes **unit tests** and **snapshot tests** to ensure stability and visual consistency.

---

## **Styles**

The `DesignSystem` module provides predefined styles to maintain UI consistency across the application.

### **1️⃣ DSColors - Color Palette**
```swift
public struct DSColors {
    public static let primaryText = Color.primary
    public static let secondaryText = Color.secondary
    public static let background = Color(UIColor.systemBackground)
    public static let searchBarBackground = Color(UIColor.systemGray6)
    public static let errorText = Color.red
    public static let white = Color.white
    public static let black = Color.black.opacity(0.4)
    public static let gray = Color.gray
}
```

### **2️⃣ DSFonts - Typography**
```swift
public struct DSFonts {
    public static let title = Font.title
    public static let subtitle = Font.title2
    public static let body = Font.body
    public static let callout = Font.callout
    public static let headline = Font.headline
    public static let subheadline = Font.subheadline
}
```

### **3️⃣ DSShadows - Shadows**
```swift
public struct DSShadows {
    public static let small = Color.black.opacity(0.1)
    public static let medium = Color.black.opacity(0.2)
    public static let large = Color.black.opacity(0.4)
}
```

### **4️⃣ DSSpacing - Spacing**
```swift
public struct DSSpacing {
    public static let xSmall: CGFloat = 4
    public static let small: CGFloat = 8
    public static let medium: CGFloat = 16
    public static let large: CGFloat = 24
    public static let xLarge: CGFloat = 32
    public static let xxLarge: CGFloat = 40
}
```

---

## **Components**

The following components are designed for reusability across the application.

### **✅ DSHeaderView**
_A reusable header with localization support._
```swift
DSHeaderView(key: "heroDetail_title", bundle: .heroDetail)
```

---

### **✅ DSSearchBar**
_A customizable search bar with icons and localization support._
```swift
DSSearchBar(
    text: $searchText,
    placeholder: "heroesList_search_placeholder".localized(),
    bundle: .heroList
)
```

---

### **✅ DSCenteredSpinnerView**
_A centered loading spinner._
```swift
DSCenteredSpinnerView(isLoading: true)
```

---

### **✅ DSNoResultsView**
_A generic "no results" view._
```swift
DSNoResultsView(
    imageName: "magnifyingglass.circle",
    title: "No results found",
    message: "Try adjusting your search criteria."
)
```

---

### **✅ DSParallaxMotionManager**
_Provides a parallax effect on images using device motion sensors._
```swift
@StateObject private var motionManager = DSParallaxMotionManager()

Image("heroImage")
    .offset(x: motionManager.xOffset, y: motionManager.yOffset)
```

---

## **Unit Tests**

Unit tests ensure the correct functionality of all components.

Example unit test for `DSSearchBar`:
```swift
func testSearchBar_initialState() {
    let searchText = Binding<String>(wrappedValue: "")
    let searchBar = DSSearchBar(text: searchText)
    XCTAssertNotNil(searchBar)
}
```

---

## **Snapshot Tests**

Snapshot tests verify that UI components maintain their expected appearance.

Example snapshot test:
```swift
func testDSHeaderViewSnapshot() {
    let headerView = DSHeaderView(key: "heroDetail_title", bundle: .heroDetail)
    assertSnapshot(of: headerView, as: .image)
}
```

---

## **Structure**

```
DesignSystem/
├── Sources/
│   ├── Animations/
│   │   ├── DSParallaxMotionManager.swift
│   │   ├── DSTimeAnimation.swift
│   ├── Components/
│   │   ├── DSCenteredSpinnerView.swift
│   │   ├── DSHeaderView.swift
│   │   ├── DSNoResultsView.swift
│   │   ├── DSSearchBar.swift
│   │   ├── DSSectionHeaderView.swift
│   ├── Images/
│   │   └── DSImage.swift
│   ├── Styles/
│   │   ├── DSCorner.swift
│   │   ├── DSOpacity.swift
│   │   ├── DSShadows.swift
│   │   ├── DSSpacing.swift
│   ├── Theme/
│   │   ├── Colors/
│   │   │   ├── DSColors.swift
│   │   ├── Fonts/
│   │   │   ├── DSFonts.swift
│   ├── Tests/
│   │   ├── ComponentsTests/
│   │   │   ├── __Snapshots__/
│   │   │   ├── DSHeaderViewTests.swift
│   │   │   ├── DSNoResultsViewTests.swift
│   │   │   ├── DSSearchBarSnapshotTests.swift
│   │   │   ├── DSSectionHeaderViewTests.swift
```

---

## **Future Improvements**
1. Expand `DSParallaxMotionManager` with customizable settings.
2. Add full **dark mode** support for all components.
3. Improve `DSSearchBar` performance with smoother animations.

---

## **Installation**
To use `DesignSystem` in another module:
```swift
import DesignSystem
```

---

🎨 **This module ensures a consistent and reusable UI across the application.** 🚀


