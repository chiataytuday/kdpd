
import UIKit

class searchViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchCollection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchStores : [Store] = []//찾는 가게를 담는 배열
    var searching = false
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching{
            return searchStores.count
        }else{
            return stores.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if searching{
            
            let pick = searchStores[indexPath.row]
            let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! searchCell
            
            cell.name.text = searchStores[indexPath.row].name
            
            if pick.photo1 == "x" || pick.photo1 == "n" || pick.photo1 == " " {
                cell.food.image = UIImage(named: "d")
            }else{
                cell.food.pin_setImage(from: URL(string: searchStores[indexPath.row].photo1))
            }
            
            return cell
            
        }else{
            
            let pick = stores[indexPath.row]
            let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! searchCell
            
            cell.name.text = stores[indexPath.row].name
            
            if pick.photo1 == "x" || pick.photo1 == "n" || pick.photo1 == " " {
                cell.food.image = UIImage(named: "d")
            }else{
                cell.food.pin_setImage(from: URL(string: pick.photo1))
            }
            return cell
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //검색을 위한
        searchStores = stores
        searchBar.delegate = self
        searchBar.placeholder = "가게,메뉴 검색"
    }

    //검색바 검색
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        searchStores = stores.filter({ SF-> Bool in
            
            guard let text = searchBar.text else {return false}
            if searchText.isEmpty{return true}
            return SF.name.contains(text)
            
        })
        searching = true
        searchCollection.reloadData()
    }
}
