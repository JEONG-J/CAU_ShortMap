//
//  GraphInfo.swift
//  CAUShortMap
//
//  Created by 정의찬 on 12/10/23.
//

import UIKit
import SnapKit

class MapInformation: UIViewController {
    
    var pathInformation: String = "" {
          didSet {
              titleLabel.text = pathInformation
          }
      }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.text = "text"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
    }
    
    private func makeConstraints(){
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.width.greaterThanOrEqualTo(50)
            make.height.greaterThanOrEqualTo(50)
        }
    }
}
