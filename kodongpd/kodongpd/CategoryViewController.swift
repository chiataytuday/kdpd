

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
 @IBOutlet weak var imageView: UIImageView!
 @IBOutlet weak var collectionView: UICollectionView!
    //카테고리 배열
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
    //오늘 뭐먹지? 이미지뷰 밑의 선 보이기
        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor.lightGray.cgColor
        borderLayer.frame = CGRect(x: 0, y: self.imageView.frame.height - 0.5, width: self.imageView.frame.width, height: 0.5)
        self.imageView.layer.addSublayer(borderLayer)
    }

//카테고리셀들 보여주기
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        cell.layer.cornerRadius = 50
        cell.foodLabel.text = Categories[indexPath.row].name
        cell.foodImage.image = UIImage(named: Categories[indexPath.row].name)
        
        return cell
        
    }

    //카테고리 선택했을 때 다음 컨트롤뷰로 선택한 카테고리 전달
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(withIdentifier: "StoreListViewController") as! StoreListViewController
        
        desVC.categoryName = Categories[indexPath.row].name
        
        self.navigationController?.pushViewController(desVC, animated: true)
    }

}