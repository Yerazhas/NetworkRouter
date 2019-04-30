//
//  VC.swift
//  NetworkManager
//
//  Created by Yerassyl Zhassuzakhov on 4/30/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

class VC: UIViewController {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let endpoint = Endpoint.bookingHistory(token: "gFrSGWkTyWSnjUPMMIVDsDSJvuUVnO")
        networkManager.request(endpoint) { (result: Result<[History]>) in
            switch result {
            case .failure(let errorMessage):
                print(errorMessage)
            case .success(let histories):
                print(histories.map { $0.id })
            }
        }
    }
}

class History: Decodable {
    let id: Int
    let userId: Int
    let placeId: Int
    let date: String
    let time: String
    let peopleCount: Int
    let description: String
    let isPaid: Bool
    let paymentUrl: String
    let step: Int
    let price: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "ID"
        case userId = "UserID"
        case placeId = "PlaceID"
        case date = "Day"
        case time = "Time"
        case peopleCount = "CountPeople"
        case description = "Description"
        case isPaid = "Pay"
        case paymentUrl = "PayURL"
        case step = "Step"
        case price = "PlacePrice"
    }
}
