//
//  NavigationController.swift
//  TaskList
//
//  Created by Pinto Junior, William James on 01/04/22.
//

import UIKit

public class NavigationController: UINavigationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    private func setupNavBar() {
        guard let navbar = self.navigationController?.navigationBar else {return}
        
        navbar.isTranslucent = true
        navbar.backgroundColor = .clear
        navbar.tintColor = .black
    }
}
