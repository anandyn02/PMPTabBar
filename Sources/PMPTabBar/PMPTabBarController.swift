//
//  PMPTabBarController.swift
//  CustTabBar
//
//  Created by Anand  on 25/09/23.
//

import UIKit

open class PMPTabBarController: UITabBarController {
    // MARK: - Views
    private lazy var cardTabBar = PMPTabBar()

    // MARK: - Properties
    open override var selectedIndex: Int {
        didSet {
            cardTabBar.select(at: selectedIndex)
        }
    }

    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(cardTabBar, forKey: "tabBar")        
    }
    
    public var selectedBackGroundColor: UIColor = .white {
        didSet {
            cardTabBar.selectedImageColor = selectedBackGroundColor
        }
    }
    
    public var textFont: UIFont? {
        didSet {
            cardTabBar.font = textFont
        }
    }
    
    public var textColor: UIColor? {
        didSet {
            cardTabBar.textColor = textColor
        }
    }
    
    public var radius: CGFloat? {
        didSet {
            cardTabBar.selectedRadius = radius ?? 0
        }
    }
    
}

extension PMPTabBarController {
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item),
              let controller = viewControllers?[index] else { return }
        
        selectedIndex = index
        delegate?.tabBarController?(self, didSelect: controller)
    }
}
