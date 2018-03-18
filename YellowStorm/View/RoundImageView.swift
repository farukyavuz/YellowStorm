//
//  RoundImageView.swift
//  YellowStorm
//
//  Created by Faruk Yavuz on 18.03.2018.
//  Copyright © 2018 Faruk Yavuz. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {
    
    override func awakeFromNib() {
        setupView()
    }

    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
