//
//  ViewController.swift
//  Motocycles
//
//  Created by Fernando González González on 06/01/22.
//

import UIKit
import Lottie

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataMotocicle {
    
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
    var arrMotocycles = [[Any]]()
    var timeSelect:[Int]?
    var indexCell:Int?
    var available:Bool?
    
    //MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getTime()
        setDataHorarios()
        configureTable()
        createMotocyclesAvailable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if Core.shared.isNewUser() == false{
            //Show Onboarding
            let vc = storyboard?.instantiateViewController(withIdentifier: "inOnboardingVC") as! OnboardingView
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
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
            self.arrCurrentTime = [hour, minute]
        
    }
    
    func showHorariosDisponibles(){
        
        let currentH = /*arrCurrentTime[0]*/8
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
                //print("Comprobando Horario")
                
                //print("Hr:", hour)
                //Hora actual >= hora
                if currentH >= hour || currentH <= 20{
                    //print("Horarios disponibles")
                    //comprobar los minutos de la hora actual
                    if currentH == hour{
                        if currentM <= minute{
                            arrDisponibles.append(itemDate)
                        }else{
                            //print("Estás fuera de horario")
                        }
                    }
                    //Horarios que están disponibles
                    else if currentH < hour{
                        arrDisponibles.append(itemDate)
                    }else{
                        //print("Sin horarios")
                    }
                    
                }
                
            }else{
                timeEstimated = 8 - currentH
            }
            tableHorarios.reloadData()
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
    
    //MARK: - Motocycles
    //Remplazar por un servicio web
    func createMotocyclesAvailable(){
        
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
        
        if indexPath.row == indexCell{
            if let available = available {
                cell.configureBackground(disponible: available)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        indexCell = indexPath.row
        
        if let timeSelect = timeSelect {
            print("\nHola mundo")
            print(timeSelect)
            for i in arrDisponibles{
                
                if timeSelect == i{
                    print("Encontré la hora exacta")
                    
                    if let availableMotocycles = availableMotocycles {
                        print(availableMotocycles)
                        
                        if availableMotocycles == 0{
                            print("No hay motociclistas disponibles")
                            available = false
                        }else{
                            print("motociclistas disponibles")
                            available = true
                        }
                    }
                    
                }
                
            }
        }else{
            print("Sin datos")
        }
        
        let arrData = arrDisponibles[indexPath.row]
        
        performSegue(withIdentifier: "idDetail", sender: arrData)
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
    func countMotocicle(_ data:[Any]){
       
        let cantidad = data[0] as! Int
        let horarioSeleccionado = data[1]
        
        print("Cantidad",cantidad)
        availableMotocycles = cantidad
        
        print("Horario Seleccionado",horarioSeleccionado)
        timeSelect = (horarioSeleccionado as! [Int])
        DispatchQueue.main.async {
            self.tableHorarios.reloadData()
        }
        
        
    }
}

