//
//  ViewController.swift
//  PetInfo
//
//  Created by sachin on 27/07/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var viewContainer: UIView!
    @IBOutlet private weak var buttonChat: UIButton!
    @IBOutlet private weak var buttonCall: UIButton!
    @IBOutlet private weak var viewHoursContainer: UIView!
    @IBOutlet private weak var labelWorkingHours: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var stackViewButtons: UIStackView!
    
    lazy var loader = CustomLoaderView(text: "Loading...")
    let viewModel = MainViewModel()
    lazy var petDetailsViewModel = PetDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        if Reachability.isConnectedToNetwork() {
            loader.show()
            getConfigData()
            getPetDetails()
        } else {
            showAlertWith(message: AppConstants.Errors.noInternet)
        }
    }


    private func setupView() {
        view.addSubview(loader)
        buttonChat.setupButtonTitleWithColor(title: AppConstants.ButtonNames.chat, color: UIColor.lightBlue)
        buttonCall.setupButtonTitleWithColor(title: AppConstants.ButtonNames.call, color: UIColor.lightGreen)
        buttonChat.setupCornerRadius()
        buttonCall.setupCornerRadius()
        
        viewHoursContainer.layer.borderColor = UIColor.lightGray.cgColor
        viewHoursContainer.layer.borderWidth = 1
        
        tableView.registerReusableCell(PetsTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func getConfigData() {
        viewModel.getConfigData {[weak self] settings, error in
            DispatchQueue.main.async {
                if let settingsData = settings {
                    self?.updateButtons(settings: settingsData)
                } else {
                    self?.showAlertWith(message: error)
                }
            }
        }
    }
    
    private func getPetDetails() {
        viewModel.getPetDetails {[weak self] pets, error in
            DispatchQueue.main.async {
                self?.loader.hide()
                if let details = pets {
                    self?.viewModel.dataSource = details
                    self?.tableView.reloadData()
                } else {
                    self?.showAlertWith(message: error)
                }
            }
        }
    }
    
    private func updateButtons(settings: Settings) {
        buttonCall.isHidden = !settings.isCallEnabled
        buttonChat.isHidden = !settings.isChatEnabled
        stackViewButtons.isHidden = (settings.isCallEnabled || settings.isChatEnabled) ? false : true
        labelWorkingHours.text = "\(AppConstants.Strings.workingHour) \(settings.workHours)"
    }
    
    @IBAction func buttonChatTapped(_ sender: Any) {
        showAlert()
    }
    
    @IBAction func buttonCallTapped(_ sender: Any) {
        showAlert()
    }
    
    private func showAlert() {
        let message = viewModel.checkTimeExist(date: Date()) ? AppConstants.Strings.officeHourMessage : AppConstants.Strings.nonOfficeHourMessage
        showAlertWith(message: message)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PetsTableViewCell
        cell.selectionStyle = .none
        guard let data = viewModel.dataSource?[indexPath.row] else {
            return cell
        }
        cell.configureCell(details: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = viewModel.dataSource?[indexPath.row] else {
            return
        }
        petDetailsViewModel.petDetails = data
        NavigationManager.navigateToPetDetails(from: self, viewModel: petDetailsViewModel)
    }
}
