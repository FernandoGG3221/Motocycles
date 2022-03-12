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
    func configureItem(data:Motocycle){
        lblName.text = data.nombre.description
        imgProfile.image = UIImage(systemName: "bolt.car.fill")
        changeColorBG(status:data.estado)
    }
    
    func changeColorBG(status:Bool){
        (status == true) ?
        (viewBG.backgroundColor = UIColor.green):(viewBG.backgroundColor = UIColor.red)
    }
}
