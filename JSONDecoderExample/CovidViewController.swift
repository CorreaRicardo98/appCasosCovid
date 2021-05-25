//
//  CovidViewController.swift
//  JSONDecoderExample
//
//  Created by Mac17 on 25/05/21.
//

import UIKit
struct MyModel: Codable {
    let country:String
    let cases:Int64
}
class CovidViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var covid = [MyModel]()
    
    

    
    @IBOutlet weak var tablaDatos: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                // we're OK to parse!
                print("Listo para llamar a parse!")
             parse(json: data)
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        print("Se llamo parse y creo decoder")
        if let jsonPeticion = try? decoder.decode([MyModel].self, from: json) {
            print("peticiones \(jsonPeticion.count)")
            //print("Json Petitions: \(jsonPeticion.articles.count)")
            covid = jsonPeticion
            tablaDatos.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covid.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaDatos.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = covid[indexPath.row].country
        celda.detailTextLabel?.text = "\(covid[indexPath.row].cases)"
        
        return celda
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
