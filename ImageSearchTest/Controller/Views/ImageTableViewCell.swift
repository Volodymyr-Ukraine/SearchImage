//
//  ImageTableViewCell.swift
//  ImageSearchTest
//
//  Created by Vladimir on 9/21/19.
//  Copyright © 2019 Volodymyr. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    override var reuseIdentifier: String? {
        return "images"
    }
    // MARK: -
    // MARK: Properties
    
    public var searchImage: UIImageView?
    public var searchLabel: UILabel?
    private var constr: ImageTableViewCellConstraints = ImageTableViewCellConstraints()
    
    // MARK: -
    // MARK: Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    
    func commonInit(){
        let image = UIImageView(frame: .zero)
        let label = UILabel(frame: .zero)
        
        [image, label].forEach{ input in
                input.translatesAutoresizingMaskIntoConstraints = false
                input.backgroundColor = isTesting ? .yellow : .white
                self.addSubview(input)
        }
        self.searchImage = image
        self.searchLabel = label
        label.text = "Hello"
    }

    // MARK: -
    // MARK: Methods
    
    public func setData(text: String, image: UIImage?) {
        self.searchLabel?.text = text
        self.searchImage?.image = image
        /*let image = UIImage(data: rawImage)
        let imageView = UIImageView(image: image)
        //self.searchImage = nil
        self.searchImage = imageView
        self.searchImage?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        self.layoutSubviews()
        //self.searchImage?.image = UIImage(contentsOfFile: imageName)
         // */
    }
    
    public func setConstr(constraints set: ImageTableViewCellConstraints) {
        self.constr = set
        self.remakeConstraints()
       // self.layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //self.setAutoConstraints()
        //self.remakeConstraints()
    }
    
    private func setAutoConstraints() {
        self.removeConstraints(self.constraints)
        self.searchImage?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.searchImage?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.searchImage?.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.searchImage?.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.searchLabel?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.searchLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    private func remakeConstraints() {
        var makeConstraints: [NSLayoutConstraint] = []
        
        zip([self.constr.imageConstraints.outConstraints(), self.constr.textConstraints.outConstraints()],
            [self.searchImage, self.searchLabel])
            .forEach{ (constr, viewOptional) in
                constr
                    .forEach{ (attribute, typeOfView, value) in
                        let item = (typeOfView == .main) ? self : nil
                        if let view = viewOptional {
                            makeConstraints.append(NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: item, attribute: attribute, multiplier: 1.0, constant: value))
                        }
                }
        }
        self.removeConstraints(self.constraints)
        self.addConstraints(makeConstraints)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
       // super.setSelected(selected, animated: animated)
    } // */

}
