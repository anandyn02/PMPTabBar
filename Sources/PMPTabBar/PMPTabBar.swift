//
//  PMPTabBar.swift
//  CustTabBar
//
//  Created by Anand  on 25/09/23.
//

import UIKit
import Stevia

extension UIView {
    static func build<T: UIView>(_ builder: ((T) -> Void)? = nil) -> T {
        let view = T()
        view.translatesAutoresizingMaskIntoConstraints = false
        builder?(view)

        return view
    }
}

extension UIStackView {
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        return arrangedSubviews.reduce([UIView]()) { $0 + [removeArrangedSubViewProperly($1)] }
    }

    private func removeArrangedSubViewProperly(_ view: UIView) -> UIView {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
        return view
    }
}

class PMPTabBar: UITabBar {
    
    fileprivate enum CardTabBarViewUI {
        static let padding: CGFloat = 0
    }

    var didSelectItemAt: ((_ index: Int) -> Void)?
    
    private var barItemColor: UIColor = .clear {
        didSet { stackView.arrangedSubviews.forEach { $0.tintColor = barItemColor } }
    }
    fileprivate var barItemBackgroundColor: UIColor? = .clear {
        didSet { stackView.arrangedSubviews.forEach { $0.backgroundColor = barItemBackgroundColor } }
    }
    
    // MARK: - Views
    private lazy var stackView: UIStackView = .build { stackView in
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
    }

    fileprivate lazy var container: UIView = .build()
    
    var selectedImageColor: UIColor = .red {
        didSet {
            reloadViews()
        }
    }
    
    var font: UIFont? {
        didSet {
            reloadViews()
        }
    }
    
    var textColor: UIColor? {
        didSet {
            reloadViews()
        }
    }
    
    
    override var tintColor: UIColor! {
        set { barItemColor = newValue }
        get { return barItemColor }
    }
    
    override var barTintColor: UIColor? {
        set { container.backgroundColor = newValue }
        get { return container.backgroundColor }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
      //  addShadow()
    }

    override func setItems(_ items: [UITabBarItem]?, animated: Bool) {
        super.setItems(items, animated: animated)
        reloadViews()
    }
    
    private func setupUI() {
        
        tintColor = .label
        backgroundImage = UIImage()
        shadowImage = UIImage()
        setupConstraint()
        
    }
    
    private func setupConstraint() {
                        
        subviews {
            stackView
        }
        
        layout {
            4
            |-20-stackView-20-|
        }
        
    }
    
    private func reloadViews() {
        
        subviews.filter { String(describing: type(of: $0)) == "UITabBarButton" }.forEach { $0.removeFromSuperview() }
        stackView.removeAllArrangedSubviews()
        
        guard let items = items else { return }

        for (index, item) in items.enumerated() {
            addButton(with: item, tag: index)
        }
    }

    private func addButton(with item: UITabBarItem, tag: Int) {
        
        let buttonView = PMPBarItemView(title: item.title, image: item.image)
        buttonView.tintColor = barItemColor
        buttonView.tag = tag
        buttonView.selectedBackGroundColor = selectedImageColor
        buttonView.textFont = font
        buttonView.textColor = textColor
        
        buttonView.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)

        if selectedItem != nil && item === selectedItem {
            buttonView.isItemSelected = true
        } else {
            buttonView.isItemSelected = false
        }
        
        stackView.addArrangedSubview(buttonView)

    }

    func select(at index: Int) {
        UIView.animate(withDuration: 0.14) {
            for (_index, view) in self.stackView.arrangedSubviews.enumerated() {
                guard let barItemView = view as? PMPBarItemView else { return }
                barItemView.isItemSelected = _index == index
            }
            self.layoutIfNeeded()
        }
    }
    
    private func addShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 13
        layer.shadowOpacity = 0.05
    }

    
    // MARK: - Actions
    @objc func buttonTapped(sender: PMPBarItemView) {
        let index = sender.tag
        guard let item = items?[index] else { return }
        didSelectItemAt?(index)
        delegate?.tabBar?(self, didSelect: item)
    }
}
