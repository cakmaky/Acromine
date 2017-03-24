//
//  MainVC.swift
//  Acromine
//
//  Created by YC on 3/23/17.
//
import UIKit
import SwiftyJSON

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var longFormArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return longFormArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let longForm = longFormArray[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as? TableCell {
         cell.configureCell(value: longForm)
         return cell
        }
        return TableCell()
    }
    
    
    @IBAction func findBtnPressed(_ sender: UIButton) {
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        spinnerActivity.label.text = "Loading";
        spinnerActivity.detailsLabel.text = "Please Wait!!";
        spinnerActivity.isUserInteractionEnabled = false;
        
        self.longFormArray.removeAll()
        let shortForm = textField.text
        let urlWithParam = "http://www.nactem.ac.uk/software/acromine/dictionary.py" + "?sf=\(shortForm!)"
        let url = URL(string: urlWithParam)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            let json = JSON(data: data!)
            if json.isEmpty {
                //print("json empty")
                self.longFormArray.append("No value found!")
            }
            else {
                if let array = json[0]["lfs"].array {
                    for index in 0..<array.count {
                        let value = array[index]["lf"].string ?? ""
                        self.longFormArray.append(value)
                    }
                }
            }
            //print(self.longFormArray)
            DispatchQueue.main.async{
                self.tableView.reloadData()
                spinnerActivity.hide(animated: true);
            }
        }
        task.resume()
    }
}
