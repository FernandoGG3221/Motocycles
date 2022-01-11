//
//  DetalMotocycle.swift
//  Motocycles
//
//  Created by Fernando González González on 08/01/22.
//

import UIKit

class DetalMotocycle: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var colecctionMotociclesView: UICollectionView!
    
    //MARK: - Properties
    var delegate:DataMotocicle?
    var data:[Any]?
    var fernando:Motocycle = Motocycle.init(nombre: "Fernando", apellido: "González", estado: true)
    var fernando1:Motocycle = Motocycle.init(nombre: "Fer", apellido: "González", estado: true)
    var fer: Motocycle = Motocycle.init(nombre: "Fercho", apellido: "González", estado: true)
    var arrPersons:[[Any]]?
    var arrData = [Any]()
    var statusGlobal = true
    var touch = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //navigationController?.navigationBar.isHidden = true
        configureCollection()
        recoveryInfo()
        //changeValueFer()
        
        recoveryDataMotocicle()
    }
    
    //MARK: - ConfigureColecctionView
    
    func configureCollection(){
        colecctionMotociclesView.delegate = self
        colecctionMotociclesView.dataSource = self
        colecctionMotociclesView.register(itemMotocycle.nib(), forCellWithReuseIdentifier: itemMotocycle.idItem)
    }
    
    func recoveryInfo(){
        
        arrPersons = [[fer], [fernando], [fernando1]]
        
        arrData = [
            [fer.nombre!, fer.estado!],
            [fernando.nombre!, fernando.estado!],
            [fernando1.nombre!, fernando1.estado!]
        ]
        
        /*if let ferP = fer.nombre{
            arrData.append([ferP, fer.estado!])
            
        }
        
        if let fer = fernando.nombre{
            arrData.append([fer, fernando.estado!])
        }
        
        if let fer = fernando1.nombre{
            arrData.append([fer, fernando1.estado!])
        }
        */
        
        
        //print(arrData)
        print(arrPersons)
        //statusItem(index: 0)
    }
    
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemMotocycle.idItem, for: indexPath) as! itemMotocycle
        
        
        
        cell.configureItem(data: arrData[index] as! [Any])
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemMotocycle.idItem, for: indexPath) as! itemMotocycle
        
        /*var data = arrData[index] as! [Any]
        
        if data[1] as! Bool == true{
            print("1", data[1])
            data[1] = false
            print(data[1])
            recoveryInfo()
            collectionView.reloadData()
        }else if data[1] as! Bool == false{
            print("2",data[1])
            data[1] = true
            recoveryInfo()
            collectionView.reloadData()
        }else{
            print("Error")
        }*/
        
        //print(arrPersons!)

        
        //print(status)
        
        
        let data = arrData[index] as! [Any]
        
        if "\(data[0])" == "Fercho"{
            changeValueFer()
        }else if "\(data[0])" == "Fernando"{
            changeValueFernando()
        }else if "\(data[0])" == "Fer"{
            changeValueFernando1()
        }
        
        cell.changeColorBG(status: data[1] as! Bool)
        
        collectionView.reloadData()
    }
    
    func changeValueFer(){
        if fer.estado == true{
            fer.estado = false
        }else{
            fer.estado = true
        }
        
        recoveryInfo()
    }
    
    func changeValueFernando(){
        if fernando.estado == true{
            fernando.estado = false
        }else{
            fernando.estado = true
        }
        
        recoveryInfo()
    }
    
    func changeValueFernando1(){
        if fernando1.estado == true{
            fernando1.estado = false
        }else{
            fernando1.estado = true
        }
        
        recoveryInfo()

    }
    
    func recoveryDataMotocicle(/*index:Int*/){
        
        for i in arrPersons![0]{
            for j in [i]{
                var temp = j as! Motocycle
                if let estado = temp.estado{
                    temp.estado = false
                    
                }
                recoveryInfo()
            }
            print(arrPersons!)
        }
        
    }
}