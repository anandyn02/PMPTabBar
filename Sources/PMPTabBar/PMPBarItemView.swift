//
//  PMPBarItemView.swift
//  CustTabBar
//
//  Created by Anand  on 25/09/23.
//

import UIKit
import Stevia

class PMPBarItemView: UIControl {

    private lazy var labelTitle: UILabel = .build { label in
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
    }

    private lazy var viewContainer: UIView = .build()
    
    private lazy var imageView: UIImageView = .build { imgview in
        imgview.layer.cornerRadius = 8
        imgview.contentMode = .center
    }
    
    var isItemSelected: Bool = false {
        didSet {
            imageView.layer.cornerRadius = isItemSelected ? 8 : 0
            imageView.backgroundColor = isItemSelected ? selectedBackGroundColor : .clear
        }
    }
    
    var textFont: UIFont? {
        didSet {
            labelTitle.font = textFont
        }
    }
    
    var textColor: UIColor? {
        didSet {
            labelTitle.textColor = textColor
        }
    }
    
    var selectedBackGroundColor: UIColor = .red
    
    init(title: String?, image: UIImage?) {
        super.init(frame: .zero)
       
        labelTitle.text = title
        imageView.image = image

        clipsToBounds = true
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraint() {
        subviews {
            labelTitle
            imageView
        }
        
        layout {
            2
            |-2-imageView.height(30)-2-|
            4
            |-2-labelTitle-2-|
            2
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
