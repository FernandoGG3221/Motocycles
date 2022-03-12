//
//  DetalMotocycle.swift
//  Motocycles
//
//  Created by Fernando González González on 08/01/22.
//

import UIKit

class DetalMotocycle: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    //MARK: - Outlets
    @IBOutlet weak var colecctionMotociclesView: UICollectionView!
    @IBOutlet weak var btnAccept: UIButton!
    
    //MARK: - Properties
    var delegate:DataMotocicle?
    var data:[Any]?
    
    //Motocycles
    var fernando:Motocycle = Motocycle.init(nombre: "Fernando", apellido: "González", estado: true)
    var fernando1:Motocycle = Motocycle.init(nombre: "Fer", apellido: "González", estado: true)
    var fer: Motocycle = Motocycle.init(nombre: "Fercho", apellido: "González", estado: true)
    var alfredo = Motocycle.init(nombre: "Alfredo", apellido: "Alonso", estado: true)
    var anastacio = Motocycle.init(nombre: "Anastacio", apellido: "Alejo", estado: true)
    var brenda = Motocycle.init(nombre:  "Brenda", apellido: "Aguayo", estado: true)
    var anayeli = Motocycle.init(nombre: "Anayeli", apellido: "Aventura", estado: true)
    var angelica = Motocycle.init(nombre: "Angélica", apellido: "Asunción",estado: true)
    var cristian = Motocycle.init(nombre: "Cristian", apellido: "Carcamo", estado: true)
    var carlos = Motocycle.init(nombre: "Carlos", apellido: "Camarena", estado: true)
    var diana = Motocycle.init(nombre: "Diana", apellido: "Dominguez", estado: true)
    
    
    var arrPersons:[Motocycle]?
    var arrData = [Any]()
    var availableMotocycle = 8
    
    //MARK: - Cicle Life Screen
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        configureCollection()
        recoveryInfo()
        
        configureBtn()
    }
    
    //MARK: - ConfigureColecctionView
    
    func configureCollection(){
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        colecctionMotociclesView.collectionViewLayout = layout
        colecctionMotociclesView.delegate = self
        colecctionMotociclesView.dataSource = self
        colecctionMotociclesView.register(itemMotocycle.nib(), forCellWithReuseIdentifier: itemMotocycle.idItem)
    }
    
    func recoveryInfo(){
        arrPersons = [fer, fernando, fernando1, alfredo,
                      anastacio, brenda, anayeli, angelica,
                      cristian, carlos, diana
        ]
    }
    
    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrPersons!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemMotocycle.idItem, for: indexPath) as! itemMotocycle
 
        cell.configureItem(data: arrPersons![index])
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemMotocycle.idItem, for: indexPath) as! itemMotocycle
        
        
        let person = arrPersons![index]
        cell.configureItem(data: person)
        
        changeStatus(namePerson: person)
        collectionView.reloadData()

    }
    
    func changeStatus(namePerson:Motocycle){
        namePerson.estado = !namePerson.estado
        (namePerson.estado) ? (availableMotocycle += 1) : (availableMotocycle -= 1)
        recoveryInfo()
    }
    
    func recoveryDataMotocicle(){
        //Usando el patrón de delegados para enviar datos a otro storyboard
        delegate?.countMotocicle([availableMotocycle, data!])
        navigationController?.popViewController(animated: true)
    }
    
    func configureBtn(){
        btnAccept.layer.cornerRadius = 20
    }
    
    @IBAction func btnAccept(_ sender: UIButton) {
        recoveryDataMotocicle()
        
    }
    
}
