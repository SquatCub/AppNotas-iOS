//
//  ViewController.swift
//  notas
//
//  Created by Brandon Rodriguez Molina on 12/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    var defaultsBD = UserDefaults.standard
    
    var notas = ["Ir al super", "Salir a caminar", "Hacer la tarea"]
    
    @IBOutlet weak var tablaNotas: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tablaNotas.delegate = self
        tablaNotas.dataSource = self
        
        notas = defaultsBD.array(forKey: "notas") as! [String]
    }
    
    @IBAction func addNotaButton(_ sender: Any) {
        var notaTextField = UITextField()
        
        let alerta = UIAlertController(title: "Agregar", message: "", preferredStyle: .alert)
        
        alerta.addTextField { (agregarNotaAction) in
            agregarNotaAction.placeholder = "Escribe aqui"
            notaTextField = agregarNotaAction
        }
        
        let accionAceptar = UIAlertAction(title: "Ok", style: .default) { (_) in
            guard let nuevaNota = notaTextField.text else { return }
            self.notas.append(nuevaNota)
            self.tablaNotas.reloadData()
            self.defaultsBD.set(self.notas, forKey: "notas")
        }
        
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(accionAceptar)
        alerta.addAction(accionCancelar)
        
        present(alerta, animated: true, completion: nil)
    }
}
// Table view methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNotas.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        celda.textLabel?.text = notas[indexPath.row]
        return celda
    }
}

