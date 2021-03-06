//
// Autogenerated by Natalie - Storyboard Generator
// by Marcin Krzyzanowski http://krzyzanowskim.com
//
import UIKit

// MARK: - Storyboards

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
        let instance = type.init()
        if let identifier = instance.storyboardIdentifier {
            return self.instantiateViewController(withIdentifier: identifier) as? T
        }
        return nil
    }

}

protocol Storyboard {
    static var storyboard: UIStoryboard { get }
    static var identifier: String { get }
}

struct Storyboards {

    struct Login: Storyboard {

        static let identifier = "Login"

        static var storyboard: UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> UINavigationController {
            return self.storyboard.instantiateInitialViewController() as! UINavigationController
        }

        static func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewController(withIdentifier: identifier)
        }

        static func instantiateViewController<T: UIViewController>(ofType type: T.Type) -> T? where T: IdentifiableProtocol {
            return self.storyboard.instantiateViewController(ofType: type)
        }

        static func instantiateLogin() -> LoginViewController {
            return self.storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        }

        static func instantiateFirst() -> FirstViewController {
            return self.storyboard.instantiateViewController(withIdentifier: "First") as! FirstViewController
        }

        static func instantiateSecond() -> SecondViewController {
            return self.storyboard.instantiateViewController(withIdentifier: "Second") as! SecondViewController
        }

        static func instantiateFourth() -> FourthViewController {
            return self.storyboard.instantiateViewController(withIdentifier: "Fourth") as! FourthViewController
        }

        static func instantiateNavController() -> UINavigationController {
            return self.storyboard.instantiateViewController(withIdentifier: "NavController") as! UINavigationController
        }
    }
}

// MARK: - Colors
@available(iOS 11.0, *)
extension UIColor {
    static let ThirdViewController = UIColor(named: "ThirdViewController")
    static let LoginViewController = UIColor(named: "LoginViewController")
    static let FourthViewController = UIColor(named: "FourthViewController")
    static let FirstViewController = UIColor(named: "FirstViewController")
    static let SecondViewController = UIColor(named: "SecondViewController")
}

// MARK: - ReusableKind
enum ReusableKind: String, CustomStringConvertible {
    case tableViewCell = "tableViewCell"
    case collectionViewCell = "collectionViewCell"

    var description: String { return self.rawValue }
}

// MARK: - SegueKind
enum SegueKind: String, CustomStringConvertible {
    case relationship = "relationship"
    case show = "show"
    case presentation = "presentation"
    case embed = "embed"
    case unwind = "unwind"
    case push = "push"
    case modal = "modal"
    case popover = "popover"
    case replace = "replace"
    case custom = "custom"

    var description: String { return self.rawValue }
}

// MARK: - IdentifiableProtocol

public protocol IdentifiableProtocol: Equatable {
    var storyboardIdentifier: String? { get }
}

// MARK: - SegueProtocol

public protocol SegueProtocol {
    var identifier: String? { get }
}

public func ==<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.identifier == rhs.identifier
}

public func ~=<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.identifier == rhs.identifier
}

public func ==<T: SegueProtocol>(lhs: T, rhs: String) -> Bool {
    return lhs.identifier == rhs
}

public func ~=<T: SegueProtocol>(lhs: T, rhs: String) -> Bool {
    return lhs.identifier == rhs
}

public func ==<T: SegueProtocol>(lhs: String, rhs: T) -> Bool {
    return lhs == rhs.identifier
}

public func ~=<T: SegueProtocol>(lhs: String, rhs: T) -> Bool {
    return lhs == rhs.identifier
}

// MARK: - ReusableViewProtocol
public protocol ReusableViewProtocol: IdentifiableProtocol {
    var viewType: UIView.Type? { get }
}

public func ==<T: ReusableViewProtocol, U: ReusableViewProtocol>(lhs: T, rhs: U) -> Bool {
    return lhs.storyboardIdentifier == rhs.storyboardIdentifier
}

// MARK: - Protocol Implementation
extension UIStoryboardSegue: SegueProtocol {
}

extension UICollectionReusableView: ReusableViewProtocol {
    public var viewType: UIView.Type? { return type(of: self) }
    public var storyboardIdentifier: String? { return self.reuseIdentifier }
}

extension UITableViewCell: ReusableViewProtocol {
    public var viewType: UIView.Type? { return type(of: self) }
    public var storyboardIdentifier: String? { return self.reuseIdentifier }
}

// MARK: - UIViewController extension
extension UIViewController {
    func perform<T: SegueProtocol>(segue: T, sender: Any?) {
        if let identifier = segue.identifier {
            performSegue(withIdentifier: identifier, sender: sender)
        }
    }

    func perform<T: SegueProtocol>(segue: T) {
        perform(segue: segue, sender: nil)
    }
}
// MARK: - UICollectionView

extension UICollectionView {

    func dequeue<T: ReusableViewProtocol>(reusable: T, for: IndexPath) -> UICollectionViewCell? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableCell(withReuseIdentifier: identifier, for: `for`)
        }
        return nil
    }

    func register<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
            register(type, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeueReusableSupplementaryViewOfKind<T: ReusableViewProtocol>(elementKind: String, withReusable reusable: T, for: IndexPath) -> UICollectionReusableView? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: identifier, for: `for`)
        }
        return nil
    }

    func register<T: ReusableViewProtocol>(reusable: T, forSupplementaryViewOfKind elementKind: String) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
            register(type, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        }
    }
}
// MARK: - UITableView

extension UITableView {

    func dequeue<T: ReusableViewProtocol>(reusable: T, for: IndexPath) -> UITableViewCell? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableCell(withIdentifier: identifier, for: `for`)
        }
        return nil
    }

    func register<T: ReusableViewProtocol>(reusable: T) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
            register(type, forCellReuseIdentifier: identifier)
        }
    }

    func dequeueReusableHeaderFooter<T: ReusableViewProtocol>(_ reusable: T) -> UITableViewHeaderFooterView? {
        if let identifier = reusable.storyboardIdentifier {
            return dequeueReusableHeaderFooterView(withIdentifier: identifier)
        }
        return nil
    }

    func registerReusableHeaderFooter<T: ReusableViewProtocol>(_ reusable: T) {
        if let type = reusable.viewType, let identifier = reusable.storyboardIdentifier {
             register(type, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
}

// MARK: - LoginViewController
extension UIStoryboardSegue {
    func selection() -> LoginViewController.Segue? {
        if let identifier = self.identifier {
            return LoginViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}
protocol LoginViewControllerIdentifiableProtocol: IdentifiableProtocol { }

extension LoginViewController: LoginViewControllerIdentifiableProtocol { }

extension IdentifiableProtocol where Self: LoginViewController {
    var storyboardIdentifier: String? { return "Login" }
    static var storyboardIdentifier: String? { return "Login" }
}
extension LoginViewController {

    enum Segue: String, CustomStringConvertible, SegueProtocol {
        case loginToFirst = "loginToFirst"

        var kind: SegueKind? {
            switch self {
            case .loginToFirst:
                return SegueKind(rawValue: "show")
            }
        }

        var destination: UIViewController.Type? {
            switch self {
            case .loginToFirst:
                return FirstViewController.self
            }
        }

        var identifier: String? { return self.rawValue }
        var description: String { return "\(self.rawValue)" }
    }

}

// MARK: - FirstViewController
extension UIStoryboardSegue {
    func selection() -> FirstViewController.Segue? {
        if let identifier = self.identifier {
            return FirstViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}
protocol FirstViewControllerIdentifiableProtocol: IdentifiableProtocol { }

extension FirstViewController: FirstViewControllerIdentifiableProtocol { }

extension IdentifiableProtocol where Self: FirstViewController {
    var storyboardIdentifier: String? { return "First" }
    static var storyboardIdentifier: String? { return "First" }
}
extension FirstViewController {

    enum Segue: String, CustomStringConvertible, SegueProtocol {
        case firstToSecond = "firstToSecond"
        case firstToThird = "firstToThird"

        var kind: SegueKind? {
            switch self {
            case .firstToSecond:
                return SegueKind(rawValue: "show")
            case .firstToThird:
                return SegueKind(rawValue: "show")
            }
        }

        var destination: UIViewController.Type? {
            switch self {
            case .firstToSecond:
                return SecondViewController.self
            case .firstToThird:
                return ThirdViewController.self
            }
        }

        var identifier: String? { return self.rawValue }
        var description: String { return "\(self.rawValue)" }
    }

}

// MARK: - ThirdViewController

// MARK: - SecondViewController
protocol SecondViewControllerIdentifiableProtocol: IdentifiableProtocol { }

extension SecondViewController: SecondViewControllerIdentifiableProtocol { }

extension IdentifiableProtocol where Self: SecondViewController {
    var storyboardIdentifier: String? { return "Second" }
    static var storyboardIdentifier: String? { return "Second" }
}

// MARK: - FourthViewController
protocol FourthViewControllerIdentifiableProtocol: IdentifiableProtocol { }

extension FourthViewController: FourthViewControllerIdentifiableProtocol { }

extension IdentifiableProtocol where Self: FourthViewController {
    var storyboardIdentifier: String? { return "Fourth" }
    static var storyboardIdentifier: String? { return "Fourth" }
}

