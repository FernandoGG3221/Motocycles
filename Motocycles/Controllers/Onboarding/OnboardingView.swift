//
//  OnboardingView.swift
//  Motocycles
//
//  Created by Fernando González González on 17/01/22.
//

import UIKit

class OnboardingView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //MARK: - Outlets
    @IBOutlet weak var collectionV: UICollectionView!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - Properties
    var arrSlides:[ModelOnboarding] = []
    var currentPage = 0 {
        
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == arrSlides.count - 1{
                btnOK.setImage(UIImage(systemName: "mustache.fill"), for: .normal)
            }else{
                btnOK.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
            }
        }
        
    }
    
    //MARK: - Cicle Life
    override func viewDidLoad() {
        super.viewDidLoad()

        configurations()
    }
    

    //MARK: - Configurations
    
    private func configurations(){
        configStyleBtn()
        configCollection()
        setDataArrSlides()
    }
    
    private func configStyleBtn(){
        btnOK.layer.cornerRadius = 50
        btnSkip.layer.cornerRadius = 15
    }
    
    private func configCollection(){
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.register(OnboardingCollectionViewCell.nib(), forCellWithReuseIdentifier: OnboardingCollectionViewCell.idItemOnboarding)
    }
    
    private func setDataArrSlides(){
        let slide1 = ModelOnboarding.init(title: "Bienvenido", description: "Bienvenido a nuestra comunidad de motociclcistas", image: UIImage(systemName: "heart.fill")!)
        
        let slide2 = ModelOnboarding.init(title: "Grandes recompensas", description: "Al unirte con nosotros te esperan grandes recomepensas", image: UIImage(systemName: "dollarsign.circle")!)
        let slide3 = ModelOnboarding.init(title: "Disfruta el desafio", description: "Tendrás que cumplir tus tareas en horarios de 8 hrs a 20 hrs", image: UIImage(systemName: "clock")!)
        
        arrSlides = [slide1, slide2, slide3]
        
    }
    
    //MARK: - CollectionView Configure
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSlides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.idItemOnboarding, for: indexPath) as! OnboardingCollectionViewCell
        
        cell.configuration(slide: arrSlides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionV.frame.width
        let height = collectionV.frame.height
        
        print("\nw:", width, "\nh:", height)
        
        return CGSize(width: width, height: height)
    }
    
    //MARK: - Current Page
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
    }
    
    //MARK: - Actions
    
    @IBAction func btnOk(_ sender: UIButton) {
        
        if currentPage == arrSlides.count - 1 {
            closeOnboarding()
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionV.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        
    }
    
    @IBAction func btnSkipt(_ sender: UIButton) {
        closeOnboarding()
    }
    
    
    func closeOnboarding(){
        print("\n\nGo to Storyboard")
        print("\n------", Core.shared.setIsNotNewUser(), "---------\n") 
        Core.shared.setIsNotNewUser()
        dismiss(animated: true, completion: nil)
        
        
    }
    
}
