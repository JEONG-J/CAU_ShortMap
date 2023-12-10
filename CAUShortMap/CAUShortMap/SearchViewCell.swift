//
//  SearchViewCell.swift
//  CAUShortMap
//
//  Created by 정의찬 on 12/10/23.
//

import UIKit
import SnapKit

class SearchViewCell: UITableViewCell {
    
    static let identifier = "SearchViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSelf()
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.textColor = UIColor.black
        text.font = UIFont.systemFont(ofSize: 30)
        return text
    }()
    
    private func setSelf(){
        self.backgroundColor = .white
    }
    
    private func makeConstraints(){
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.greaterThanOrEqualTo(30)
        }
    }
    
    public func configure(model: BuildingName){
        self.titleLabel.text = model.name
    }

}
