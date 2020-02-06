//
//  HomeVC.swift
//  LessonApp
//
//  Created by Zizo Adel on 1/16/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class HomeVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchVew: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var greetingNameLabel: UILabel!
    
    // MARK: - Variables
    var allTeachers: AllTeacher = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialUpdates()
        loadAllTeachers()
    }
    
    // MARK: - Actions
    @IBAction func logOutAction(_ sender: UIButton) {
        removeCurrentUser()
        dismiss(animated: true, completion: nil)
    }
    
    
    /****** load all teachers ******/
    func loadAllTeachers() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(), .none)
        allTeacherRequest { (allTeachers) in
            if let allTeachers = allTeachers {
                self.allTeachers = allTeachers
                self.collectionView.reloadData()
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(.none)
        }
        
    }
    
}

/****** Update views ******/
extension HomeVC {
    
    // MARK: - initial updates
    func initialUpdates() {
        greetingNameLabel.text = "مرحبا \(getFullName())"
        updateContainerView()
        updateSearchView()
    }
    
    // MARK: - Update containerView top corners
    func updateContainerView() {
        containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    // MARK: - update search view
    func updateSearchView() {
        searchVew.layer.shadowColor = UIColor.black.cgColor
        searchVew.layer.shadowRadius = 2
        searchVew.layer.shadowOpacity = 0.3
        searchVew.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    // MARK: - send teacher ifo
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTeacherInfo" {
            let teacherVC = segue.destination as! TeacherVC
            if let index = sender as? Int {
                teacherVC.teacherData = allTeachers[index]
            }
        }
    }
    
}

/****** Configure Collection view  data source ******/
extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allTeachers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TeachersCell
        if allTeachers.count > 0 {
            cell.generateCell(teacherData: allTeachers[indexPath.item])
        }
        return cell
    }
    
}
/****** Configure Collection view  delegate ******/
extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToTeacherInfo", sender: indexPath.item)
    }
    
}
/****** Configure Collection view  cell size ******/
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let itemWidth = (collectionView.frame.size.width - 20) / numberOfItemsPerRow
        return CGSize(width: itemWidth, height: 216)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}

/****** all teacher request ******/
extension HomeVC {
    
    func allTeacherRequest(completion: @escaping(_ allTeachers: AllTeacher?) -> Void) {
        guard let url = URL(string: KALLTEACHERS) else { return }
        request(url).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let _allTeachers = try JSONDecoder().decode(AllTeacher.self, from: data)
                    completion(_allTeachers)
                } catch {
                    self.alert(msg: error.localizedDescription)
                    completion(nil)
                }
            case .failure(_):
                self.alert(msg: "لا يوجد اتصال بالانترنت")
                completion(nil)
            }
        }
    }
    
}
