//
//  SolarSystemViewController.swift
//  Universe
//
//  Created by Dmytro Yurchenko on 26.1.21.
//

import UIKit

class SolarSystemViewController: UIViewController {
    
    weak var delegate: StateMachineProtocol?
    
    @IBOutlet weak var planetsCollection: UICollectionView!
    @IBOutlet weak var starInfo: UIView!
    @IBOutlet weak var starName: UILabel!
    @IBOutlet weak var starType: UILabel!
    @IBOutlet weak var starEvolution: UILabel!
    
    weak var coordinator: Coordinator?
    weak var universeViewController: UniverseViewController?
    weak var solarSystem: SolarSystem?
    private let reuseIdentifier = "planetCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starInfo.layer.cornerRadius = starInfo.frame.height / 5
        planetsCollection.delegate = self
        planetsCollection.dataSource = self
        solarSystem?.delegate = self
        starName.text = solarSystem?.star.name
        starType.text = solarSystem?.star.type!.rawValue
        starEvolution.text = solarSystem?.star.starEvolution.rawValue
        self.delegate = coordinator
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Star and planets"
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        if parent == nil {
            delegate?.notifyStateMachine(source: self, .Back, solarSystem!, coordinator: coordinator!)
        }
    }
    
}

//MARK: - Changes update

extension SolarSystemViewController: ChangesDelegate {
    func updateChanges() {
        DispatchQueue.main.async { [weak self] in
            /*
             Mentor's comment:
             Some features are missing here.
             > Реализовать обработку жизненного цикла текущего уровня иерархии (например его удаление).
             Один из примеров: пользователь находится на экране звездно-планетарной системы и в это самое время
             родительская галактика сталкивается с другой галактикой в результате чего текущая звездно-планетарная
             система случайным образом выбрана для уничтожения. Необходимо корректнореализовать это состояние
             с точки зрения UI (например плейсхолдер или алерт с возвратом на более высокий уровень иерархии).
             */
            self?.planetsCollection.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource

extension SolarSystemViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        solarSystem!.planets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let planet = solarSystem!.planets[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! SolarSystemCollectionViewCell
        
        cell.planetName.text = planet.name
        cell.planetMass.text = "Mass: \(planet.mass)"
        cell.planetType.text = planet.type?.rawValue
        
        cell.layer.cornerRadius = cell.frame.height / 5
        
        return cell
    }
    
}

//MARK: - UICollectionViewDelegate

extension SolarSystemViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let planet = solarSystem!.planets[indexPath.row]
        delegate?.notifyStateMachine(source: self, .Next, planet, coordinator: coordinator!)
    }
}
