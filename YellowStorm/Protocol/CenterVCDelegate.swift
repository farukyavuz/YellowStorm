//
//  CenterVCDelegate.swift
//  YellowStorm
//
//  Created by Faruk Yavuz on 18.03.2018.
//  Copyright © 2018 Faruk Yavuz. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
