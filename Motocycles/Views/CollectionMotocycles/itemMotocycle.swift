//
//  itemMotocycle.swift
//  Motocycles
//
//  Created by Fernando González González on 08/01/22.
//

import UIKit

class itemMotocycle: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewBG: UIView!
    
    //MARK: - Properties
    static let idItem = "idItem"
    
    static func nib()->UINib{
        return UINib(nibName: "itemMotocycle", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Configure
    func configureItem(data:[Any]){
        lblName.text = "\(data[0])"
        imgProfile.image = UIImage(systemName: "bolt.car.fill")
        changeColorBG(status:data[1] as! Bool)
    }
    
    func changeColorBG(status:Bool){
        if status == true{
            viewBG.backgroundColor = UIColor.green
        }else{
            viewBG.backgroundColor = UIColor.red
        }
        
    }
}
