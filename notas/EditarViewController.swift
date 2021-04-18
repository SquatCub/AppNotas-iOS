//
//  EditarViewController.swift
//  notas
//
//  Created by Brandon Rodriguez Molina on 15/04/21.
//

import UIKit

class EditarViewController: UIViewController {
    // Base de datos "local"
    var defaultsBD = UserDefaults.standard
    
    @IBOutlet weak var editNotaTextVIew: UITextView!
    @IBOutlet weak var fechaLabel: UILabel!
    
    var nota: String?
    var fecha: String?
    var index: Int?
    var notas: [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editNotaTextVIew.text = nota
        fechaLabel.text = "Fecha: "+fecha!
    }
    @IBAction func guardadNota(_ sender: Any) {
        notas?.remove(at: index!)
        notas?.insert(editNotaTextVIew.text!, at: index!)
        print(notas!)
        defaultsBD.set(notas, forKey: "notas")
        navigationController?.popToRootViewController(animated: true)
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
