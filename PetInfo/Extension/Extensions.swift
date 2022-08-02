//
//  Extensions.swift
//  PetInfo
//
//  Created by sachin on 27/07/22.
//

import Foundation
import UIKit

extension UIView {
    func setupCornerRadius(radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

extension UIButton {
    func setupButtonTitleWithColor(title: String, color: UIColor) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        self.setTitleColor(.white, for: .normal)
        self.backgroundColor = color
    }
}

extension UIColor {
    class func rgbColor(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat, alpha:CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static let lightBlue = UIColor.rgbColor(55, 127, 243, alpha: 1)
    static let lightGreen = UIColor.rgbColor(110, 206, 109, alpha: 1)
}

extension UIImageView {
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "default.png")
            return
        }
        DispatchQueue.global().async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "default.png")
            }
        }
    }
}

extension UIViewController {
    func showAlertWith(message: String?) {
        let alert = UIAlertController(title: "", message: message ?? "Something went wrong", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func instantiateVC(storyboard name: Storyboards, withIdentifier id: String) -> UIViewController {
        let newStoryboard = UIStoryboard(name: name.value, bundle: nil)
        return newStoryboard.instantiateViewController(withIdentifier: id)
    }
}

extension String {
    var firstCapital: String {
        let char = prefix(1).capitalized
        let string = dropFirst()
        return char + string
    }
}

extension Date {
    var startTime: Date {
        get {
            Calendar.current.date(byAdding: DateComponents(calendar: Calendar.current, hour:9),
                                  to: Calendar.current.startOfDay(for: Date()))!
        }
    }
    var endTime: Date {
        get {
            Calendar.current.date(byAdding: DateComponents(calendar: Calendar.current, hour: 18, minute: 00),
                                  to: Calendar.current.startOfDay(for: Date()))!
        }
    }
    
    static func getDateForTime(time: Int) -> Date {
        return Calendar.current.date(byAdding: DateComponents(calendar: Calendar.current, hour: time),
                                     to: Calendar.current.startOfDay(for: Date())) ?? Date()
    }
}
