// Copyright SIX DAY LLC. All rights reserved.

import Foundation
import UIKit

func applyStyle() {

    if #available(iOS 11, *) {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UIDocumentBrowserViewController.self]).tintColor = Colors.appBackground
    } else {
        UINavigationBar.appearance().isTranslucent = false
    }
    UIWindow.appearance().tintColor = Colors.appBackground
    UINavigationBar.appearance().tintColor = Colors.appWhite
    UINavigationBar.appearance().setBackgroundImage(UIImage(color: Colors.appBackground), for: .default)
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().barTintColor = Colors.appBackground
    UINavigationBar.appearance().backIndicatorImage = R.image.backWhite()
    UINavigationBar.appearance().backIndicatorTransitionMaskImage = R.image.backWhite()
    UINavigationBar.appearance().titleTextAttributes = [
        .foregroundColor: Colors.appWhite,
        .font: Fonts.light(size: 25) as Any
    ]

    //We could have set the backBarButtonItem with an empty title for every view controller, but we don't have a place to do it for Eureka view controllers. Using appearance here, while a hack is still more convenient though, since we don't have to do it for every view controller instance
    UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: 0), for: .default)
    UIBarButtonItem.appearance().tintColor = Colors.appWhite
    UIBarButtonItem.appearance(whenContainedInInstancesOf: [UIToolbar.self]).tintColor = Colors.appBackground

    UIToolbar.appearance().tintColor = Colors.appBackground

    //Background (not needed in iOS 12.1 on simulator)
    UISearchBar.appearance().backgroundColor = Colors.appBackground
    //Cancel button
    UISearchBar.appearance().tintColor = Colors.appWhite
    //Cursor color
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = Colors.appWhite

    UITextField.appearance().tintColor = Colors.blue

    UIRefreshControl.appearance().tintColor = Colors.appWhite

    UIImageView.appearance().tintColor = Colors.lightBlue

    BalanceTitleView.appearance().titleTextColor = UIColor.white
    BalanceTitleView.appearance().subTitleTextColor = UIColor(white: 0.9, alpha: 1)
}

func applyStyle(viewController: UIViewController) {
	// See use of setBackButtonTitlePositionAdjustment(:for:) above
//    viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
}

struct Colors {
    static let darkBlue = UIColor(hex: "3375BB")
    static let blue = UIColor(hex: "2e91db")
    static let red = UIColor(hex: "f7506c")
    static let veryLightOrange = UIColor(hex: "FFECC9")
    static let green = UIColor(hex: "2fbb4f")
    static let lightGray = UIColor.lightGray
    static let veryLightGray = UIColor(hex: "F6F6F6")
    static let gray = UIColor.gray
    static let darkGray = UIColor(hex: "606060")
    static let black = UIColor(hex: "313849")
    static let lightBlack = UIColor(hex: "313849")
    static let lightBlue = UIColor(hex: "007aff")
    static let appBackground = UIColor(red: 84, green: 193, blue: 227)
    static let appWhite = UIColor.white
    static let appText = UIColor(red: 47, green: 47, blue: 47)
    static let appHighlightGreen = UIColor(red: 117, green: 185, blue: 67)
    static let appActionButtonGreen = UIColor(red: 105, green: 200, blue: 0)
    static let disabledActionButton = UIColor(hex: "d7ebc8")
    static let appActionButtonShadow = UIColor.clear
    static let appGreenContrastBackground = UIColor(red: 86, green: 153, blue: 8)
    static let appLightButtonSeparator = UIColor(red: 255, green: 255, blue: 255, alpha: 0.2)
    static let appRed = UIColor(red: 204, green: 71, blue: 65)
    static let appGrayLabelColor = UIColor(red: 155, green: 155, blue: 155)
    static let settingsSubtitleColor = UIColor(red: 141, green: 141, blue: 141)
}

struct StyleLayout {
    static let sideMargin: CGFloat = 15
}

struct Fonts {
    static let labelSize: CGFloat = 18

    static func light(size: CGFloat) -> UIFont? {
        return UIFont(resource: R.font.sourceSansProLight, size: size)
    }
    static func regular(size: CGFloat) -> UIFont? {
        return UIFont(resource: R.font.sourceSansProRegular, size: size)
    }
    static func semibold(size: CGFloat) -> UIFont? {
        return UIFont(resource: R.font.sourceSansProSemibold, size: size)
    }
    static func bold(size: CGFloat) -> UIFont? {
        return UIFont(resource: R.font.sourceSansProBold, size: size)
    }
}

extension UISegmentedControl {
    func style() {
        setDividerImage(UIImage(color: Colors.appBackground), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        subviews.forEach { $0.tintColor = Colors.appBackground }
    }
}

enum Metrics {
    enum CornerRadius {
        static let popups = CGFloat(20)
        static let box = CGFloat(2)
        static let textbox = CGFloat(4)
        static let button = CGFloat(4)
    }

    enum DappsHome {
        enum Icon {
            static let shadowOffset = CGSize(width: 0, height: 0)
            static let shadowOpacity = Float(0.15)
            static let shadowRadius = CGFloat(6)
            static let shadowColor = UIColor.black
        }
    }
}
