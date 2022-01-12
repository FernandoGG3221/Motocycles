//
//  ViewController.swift
//  Motocycles
//
//  Created by Fernando González González on 06/01/22.
//

import UIKit
import Lottie

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataMotocicle {
    
    func countMotocicle(_ cantidad: Int?) {
        if let cantidad = cantidad {
            print("Cantidad", cantidad)
            availableMotocycles = cantidad
            tableHorarios.reloadData()
        }
        
        print("Hola")
    }
    
    //MARK: - Outlets
    @IBOutlet weak var tableHorarios: UITableView!
    @IBOutlet weak var lblTitlw: UILabel!
    
    
    //MARK: - Properties
    var animationView : AnimationView?
    var animationLike : AnimationView?
    
    //MARK: - Variables
    var arrHorarios = [[Int]]()
    var arrCurrentTime = [Int]()
    var arrDisponibles = [[Int]]()
    var availableMotocycles:Int?
    
    //MARK: - DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getTime()
        setDataHorarios()
        configureTable()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Animation Functions
    func loadAnimation404(_ modelAnimation:String){
        
        animationView = .init(name: modelAnimation)
        animationView?.frame = view.bounds
        animationView?.loopMode = .loop
        if let animationView = animationView {
            view.addSubview(animationView)
            animationView.play()
        }else{
            print("Not found animation404Error")
        }
        
        closeAnimation()
        
    }
    
    @objc func closeAnim(){
        animationView?.stop()
        animationView?.removeFromSuperview()
    }
    
    func closeAnimation(){
        let selector = #selector(closeAnim)
        
        _ = Timer.scheduledTimer(timeInterval: 3.1, target: self, selector: selector, userInfo: nil, repeats: false)
        
    }
    
    //MARK: - configureTable
    func configureTable(){
        tableHorarios.delegate = self
        tableHorarios.dataSource = self
        tableHorarios.register(itemHorario.nib(), forCellReuseIdentifier: itemHorario.idcellHorario)
    }
    
    //MARK: - Validate Time now
    func getTime(){
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        arrCurrentTime = [hour, minute]
    }
    
    func showHorariosDisponibles(){
        
        let currentH = /*arrCurrentTime[0]*/ 8
        let currentM = arrCurrentTime[1]
        var hour = -1
        let minute = 30
        var timeEstimated:Int?
        
        print("Hora:",currentH,"hrs", currentM,"m")
        
        for itemDate in arrHorarios{

            hour = itemDate[0]
            
            if currentH > hour && currentM > minute{
                print("Te encuentras fuera de horario")
            }else if currentH <= 20 && currentH >= 8{
                print("Comprobando Horario")
                
                print("Hr:", hour)
                //Hora actual >= hora
                if currentH >= hour || currentH <= 20{
                    print("Horarios disponibles")
                    //comprobar los minutos de la hora actual
                    if currentH == hour{
                        if currentM <= minute{
                            arrDisponibles.append(itemDate)
                        }else{
                            print("Estás fuera de horario")
                        }
                    }
                    //Horarios que están disponibles
                    else if currentH < hour{
                        arrDisponibles.append(itemDate)
                    }else{
                        print("Sin horarios")
                    }
                    
                }
                
                
                
                /*if currentH == hour{
                    print("Horario actual")
                    
                    if currentM <= minute{
                    print("Verificando")
                        arrDisponibles.append(itemDate)
                    }else{
                        print("Este horario ya no está disponible")
                    }
                    
                }else if currentH > hour{
                    print("Horarios fuera de tiempo")
                }else if currentH < hour && currentM <= minute{
                    print("Horarios Disponibles")
                    arrDisponibles.append(itemDate)
                }else{
                    
                }*/
                
            }else{
                timeEstimated = 8 - currentH
            }
        }
        
        if let timeEstimated = timeEstimated {
            print("Tiempo estimado de apertura: \(timeEstimated) hrs")
        }
        print("Hora:",currentH,"hrs", currentM,"m")
        
        print(arrDisponibles)
        
        if arrDisponibles.isEmpty{
            
        }else{
            print(arrDisponibles)
        }
        
        print("-----")
    }
    
    func setDataHorarios(){
        loadAnimation404(ModelAnimations.animationLoad.rawValue)
        var pos = 0
        
        for hour in 8...20{
            
            let media = 30
            
            arrHorarios.append([hour, 0])
            
            if hour != 20{
                arrHorarios.append([hour, media])
                pos += 1
            }else{
                print("Disponible hasta 20 hrs")
            }
            
        }
        showHorariosDisponibles()
    }
    
    //MARK: - Actions
    
    //MARK: - Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDisponibles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: itemHorario.idcellHorario, for: indexPath) as! itemHorario
        
        cell.configureCell(arrTime: arrDisponibles[index])
        
        //print(availableMotocycles)
        if let availableMotocycles = availableMotocycles {
            print(availableMotocycles)
            
            if availableMotocycles == 3{
                print("No hay motociclistas disponibles")
                cell.configureBackground(disponible: false)
            }else{
                print("motociclistas disponibles")
                cell.configureBackground(disponible: true)
            }
        }
        //cell.configureBackground(disponible: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        let arrData = arrDisponibles[indexPath.row]
        print(arrData)
        
        performSegue(withIdentifier: "idDetail", sender: arrData)
        //navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "idDetail"{
            let data = sender as! [Any]
            let detailScreen:DetalMotocycle = segue.destination as! DetalMotocycle
            detailScreen.data = data
            detailScreen.delegate = self
        }
    }
    
    //MARK: - Protocols
    
}

