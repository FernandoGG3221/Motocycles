//
//  OnboardingCollectionViewCell.swift
//  Motocycles
//
//  Created by Fernando González González on 18/01/22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    //MARK: - Properties
    static let idItemOnboarding = "idItemOnb"
    
    static func nib() -> UINib{
        return UINib(nibName: "OnboardingCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Configure
    func configuration(slide:ModelOnboarding){
        imgView.image = slide.image
        lblTitle.text = slide.title
        lblDescription.text = slide.description
        
    }
    

}
