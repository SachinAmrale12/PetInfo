//
//  NavigationManager.swift
//  PetInfo
//
//  Created by sachin on 27/07/22.
//

import Foundation
import UIKit

final class NavigationManager {
    class func navigateToPetDetails(from viewController: UIViewController, viewModel: PetDetailsViewModel) {
        let id = AppConstants.ViewControllerId.petDetailsViewController
        guard let controller = viewController.instantiateVC(storyboard: .main,
                                                            withIdentifier: id) as? PetDetailsViewController else { return }
        controller.viewModel = viewModel
        viewController.navigationController?.pushViewController(controller, animated: true)
    }
}
