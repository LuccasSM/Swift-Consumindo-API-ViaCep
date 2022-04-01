//
//  ViewController.swift
//  Swift-consumindo-API-CEP
//
//  Created by Luccas Santana Marinho on 31/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        insertViews()
        
        NSLayoutConstraint.activate([
            tF.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            tF.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            tF.widthAnchor.constraint(equalToConstant: 220),
            tF.heightAnchor.constraint(equalToConstant: 50),
            
            button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            button.leadingAnchor.constraint(equalTo: self.tF.trailingAnchor, constant: 10),
            button.widthAnchor.constraint(equalToConstant: 70),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            logradouro.topAnchor.constraint(equalTo: self.tF.bottomAnchor, constant: 30),
            logradouro.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            
            bairro.topAnchor.constraint(equalTo: self.logradouro.bottomAnchor, constant: 30),
            bairro.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            
            localidade.topAnchor.constraint(equalTo: self.bairro.bottomAnchor, constant: 30),
            localidade.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            
            ddd.topAnchor.constraint(equalTo: self.localidade.bottomAnchor, constant: 30),
            ddd.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            
            statusFinal.topAnchor.constraint(equalTo: self.ddd.bottomAnchor, constant: 30),
            statusFinal.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
        ])
    }
    
        // MARK: - Inserindo elementos na tela
    
    func insertViews() {
        self.view.addSubview(tF)
        self.view.addSubview(button)
        self.view.addSubview(logradouro)
        self.view.addSubview(bairro)
        self.view.addSubview(localidade)
        self.view.addSubview(ddd)
        self.view.addSubview(statusFinal)
    }
    
    // MARK: - Criando os elementos
    
    private lazy var tF: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Digite um CEP válido"
        tf.font = UIFont.systemFont(ofSize: 15)
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.autocorrectionType = UITextAutocorrectionType.no
        tf.keyboardType = UIKeyboardType.default
        tf.returnKeyType = UIReturnKeyType.done
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return tf
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.backgroundColor = .white
        button.setTitle("Ir", for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.addTarget(self, action: #selector(pesquisarApi), for: .touchUpInside)
        return button
    }()
    
    private lazy var logradouro: UILabel = {
        let logradouro = UILabel(frame: .zero)
        logradouro.translatesAutoresizingMaskIntoConstraints = false
        logradouro.text = "Logradouro:"
        logradouro.font = UIFont.boldSystemFont(ofSize: 18)
        logradouro.textColor = .white
        return logradouro
    }()
    
    private lazy var bairro: UILabel = {
        let bairro = UILabel(frame: .zero)
        bairro.translatesAutoresizingMaskIntoConstraints = false
        bairro.text = "Bairro:"
        bairro.font = UIFont.boldSystemFont(ofSize: 18)
        bairro.textColor = .white
        return bairro
    }()
    
    private lazy var localidade: UILabel = {
        let localidade = UILabel(frame: .zero)
        localidade.translatesAutoresizingMaskIntoConstraints = false
        localidade.text = "Localidade/UF:"
        localidade.font = UIFont.boldSystemFont(ofSize: 18)
        localidade.textColor = .white
        return localidade
    }()
    
    private lazy var ddd: UILabel = {
        let ddd = UILabel(frame: .zero)
        ddd.translatesAutoresizingMaskIntoConstraints = false
        ddd.text = "DDD:"
        ddd.font = UIFont.boldSystemFont(ofSize: 18)
        ddd.textColor = .white
        return ddd
    }()
    
    private lazy var statusFinal: UILabel = {
        let statusFinal = UILabel(frame: .zero)
        statusFinal.translatesAutoresizingMaskIntoConstraints = false
        statusFinal.text = "Status Final:"
        statusFinal.font = UIFont.boldSystemFont(ofSize: 18)
        statusFinal.textColor = .white
        return statusFinal
    }()
    
    // MARK: - Funcao no botao de Ir
    
    @objc func pesquisarApi() {
        APIViaCep.pesquisarCEP(tF.text!) { res in
            switch res {
                case .success(let cep):
                DispatchQueue.main.async {
                    self.logradouro.text = "Logradouro: \(cep.logradouro)"
                    self.bairro.text = "Bairro: \(cep.bairro)"
                    self.localidade.text = "Localidade/UF: \(cep.localidade)-\(cep.uf)"
                    self.ddd.text = "DDD: \(cep.ddd)"
                    self.statusFinal.text = "Status Final: CEP Válido"
                    self.statusFinal.textColor = .systemGreen
                }
            case .failure:
                DispatchQueue.main.async {
                    self.statusFinal.text = "Status Final: CEP Inválido"
                    self.statusFinal.textColor = .systemRed
                }
            }
        }
    }
}
