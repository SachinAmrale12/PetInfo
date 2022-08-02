//
//  ReusableView.swift
//  PetInfo
//
//  Created by sachin on 27/07/22.
//

import Foundation
import UIKit

public protocol ReuseableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
    static var nib: UINib? { get }

}

extension ReuseableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }

    static var nib: UINib? {
        let nib = UINib(nibName: defaultReuseIdentifier, bundle: nil)
        guard (nib.instantiate(withOwner: nil, options: nil).first as? UIView) != nil else {
            return nil
        }

        return nib
    }
}

protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableView {
    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: ReuseableView {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier) //Register nib
        } else {
            self.register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier) //Register class
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: ReuseableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath as IndexPath) as? T else {
            fatalError("Cannot dequeue cell \(T.self) for indexPath: \(indexPath)")
        }

        return cell
    }
    
    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReuseableView {
        if let nib = T.nib {
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier) //Register nib
        } else {
            self.register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)//Register class
        }
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: ReuseableView {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Cannot dequeue cell \(T.self)")
        }

        return cell
    }
}

extension UICollectionView {
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: ReuseableView {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier) //Register nib
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier) //Register class
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: ReuseableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath as IndexPath) as? T else {
            fatalError("Cannot dequeue cell \(T.self) for indexPath: \(indexPath)")
        }

        return cell
    }
    
    func registerReusableSupplementaryView<T: ReuseableView>(elementKind: String, _: T.Type) {
        if let nib = T.nib {
            self.register(nib,
                          forSupplementaryViewOfKind: elementKind,
                          withReuseIdentifier: T.defaultReuseIdentifier) //Register nib
        } else {
            self.register(T.self,
                          forSupplementaryViewOfKind: elementKind,
                          withReuseIdentifier: T.defaultReuseIdentifier) //Register class
        }
    }
        
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>
      (ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T
      where T: ReuseableView {
        let view = self.dequeueReusableSupplementaryView(
          ofKind: elementKind,
          withReuseIdentifier: viewType.defaultReuseIdentifier,
          for: indexPath
        )
        guard let typedView = view as? T else {
          fatalError(
            "Failed to dequeue a supplementary view with identifier \(T.defaultReuseIdentifier) "
              + "matching type \(viewType.self). "
              + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
              + "and that you registered the supplementary view beforehand"
          )
        }
        return typedView
    }

}
