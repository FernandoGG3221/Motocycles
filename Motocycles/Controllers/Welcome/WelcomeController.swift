//
//  WelcomeController.swift
//  Motocycles
//
//  Created by Fernando González González on 13/01/22.
//

import UIKit
import Lottie
import iCarousel

class WelcomeController: UIViewController, iCarouselDataSource {

    
    //MARK: - Outlets
    @IBOutlet weak var viewCarousel: UIView!
    
    //MARK: - Properties
    let carouselInit: iCarousel = {
        
       let view = iCarousel()
        view.type = .coverFlow
        
        return view
    }()
    var animationsLotties:AnimationView?
    
    var arrItemCarousel = [
        [ModelWelcomeAnimations.loadingMotorcycle.rawValue],
        [ModelWelcomeAnimations.moneyStack.rawValue],
        [ModelWelcomeAnimations.particle.rawValue],
        [ModelWelcomeAnimations.voodoo.rawValue]
    ]
    
    //MARK: - didLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCarousel()
        addLottiesArray()
        
    }
    
    //MARK: - Carousel
    func configureCarousel(){
        
        viewCarousel.addSubview(carouselInit)
        carouselInit.dataSource = self
        
        carouselInit.frame = CGRect(x: 0,
                                    y: 0,
                                    width: viewCarousel.frame.size.width - 22,
                                    height: viewCarousel.frame.size.height)
        
        print("Configurando carusel")
    }

    func addLottiesArray(){
        
    }
    
    func loadArrLotties(Index:Int){
        if arrItemCarousel.isEmpty{
            print("El arreglo de imágenes está vacio")
        }else{
            print(arrItemCarousel[Index])
            for nameAnimation in arrItemCarousel[Index]{
                
                animationsLotties = .init(name: nameAnimation)
                
                animationsLotties?.frame = viewCarousel.bounds
                animationsLotties?.loopMode = .loop
                
                if let animationsLotties = animationsLotties {
                    viewCarousel.addSubview(animationsLotties)
                    animationsLotties.play()
                }else{
                    print("Not found Animation")
                }
            }
        }
    }
    
    //MARK: - iCarusel
    func numberOfItems(in carousel: iCarousel) -> Int {
        return arrItemCarousel.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let heightView = viewCarousel.frame.size.height
        let widthView = viewCarousel.frame.size.width
        
        let view = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: widthView,
            height: heightView))
        view.backgroundColor = .cyan

        let imageView = UIImageView(frame: view.bounds)
        view.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFit
        print(index)

        //loadArrLotties(Index: index)
        //for i in arrItemCarousel[index]{
        //    imageView.image = UIImage(named: i)
        //}
        
        return view
    }

}
