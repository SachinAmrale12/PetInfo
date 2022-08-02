//
//  PetsTableViewCell.swift
//  PetInfo
//
//  Created by sachin on 27/07/22.
//

import UIKit

class PetsTableViewCell: UITableViewCell, ReuseableView {

    @IBOutlet private weak var imageViewPet: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(details: Pet) {
        imageViewPet.setCustomImage(details.imageUrl)
        labelTitle.text = details.title
    }
}
