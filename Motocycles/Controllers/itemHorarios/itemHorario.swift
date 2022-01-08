//
//  itemHorario.swift
//  Motocycles
//
//  Created by Fernando González González on 08/01/22.
//

import UIKit

class itemHorario: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var lblHorarios: UILabel!
    @IBOutlet weak var imgH: UIImageView!
    @IBOutlet weak var viewBG: UIView!
    
    //MARK: - PROPERTIES
    static let idcellHorario = "idCellHorarios"
    
    static func nib()-> UINib{
        return UINib(nibName: "itemHorario", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Configure Cell
    func configureCell(arrTime:[Any]){
        let horario = "\(arrTime[0])hrs \(arrTime[1])m"
        
        lblHorarios.text = horario
    }
    
    func configureBackground(disponible:Bool){
        viewBG.layer.cornerRadius = 15
        
        if disponible{
            imgH.tintColor = .green
        }else if disponible == false{
            imgH.tintColor = .red
        }
        
        
    }
    
}
