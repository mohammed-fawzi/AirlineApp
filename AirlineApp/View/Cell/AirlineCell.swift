//
//  AirlineCell.swift
//  AirlineApp
//
//  Created by mohamed fawzy on 19September//2021.
//

import UIKit

class AirlineCell: UITableViewCell {
    
    var viewModel: AirlineCellViewModel?{
        didSet{
            bind()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(){
        viewModel?.name.subscribe({ [weak self] name in
            self?.textLabel?.text = name
        })
    }
       
    
    override func prepareForReuse() {
        textLabel?.text = nil
    }

}
