//
//  InformationTableViewCell.swift
//  KYZG_swift
//
//  Created by LiTengFang on 2017/2/25.
//  Copyright © 2017年 LiTengFang. All rights reserved.
//

import UIKit

class InformationTableViewCell: UITableViewCell {

    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let timeLabel = UILabel()
    private let commentCount = UILabel()
    
    var model:InformationTableViewCellModel? {
        didSet {
            commentCount.attributedText = model?.attributedCommentCount;
            titleLabel.attributedText = model?.attributedTittle;
            timeLabel.attributedText = model?.timeString;
            bodyLabel.attributedText = model?.bodyString;
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews()->Void {
 
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakMode.byCharWrapping;
        self.titleLabel.font = UIFont.systemFont(ofSize: 15) 
        self.contentView.addSubview(self.titleLabel)
        
      
        self.bodyLabel.numberOfLines = 0;
        self.bodyLabel.lineBreakMode = NSLineBreakMode.byCharWrapping;
        self.bodyLabel.font = UIFont.systemFont(ofSize: 13)
        self.bodyLabel.textColor = UIColor.gray
        self.contentView.addSubview(self.bodyLabel)
        
        //    self.authorLabel = [UILabel new];
        //    self.authorLabel.font = [UIFont systemFontOfSize:12];
        //    self.authorLabel.textColor = [UIColor nameColor];
        //    [self.contentView addSubview:self.authorLabel];
        

        self.timeLabel.font = UIFont.systemFont(ofSize: 12)
        self.timeLabel.textColor = UIColor.gray
       
        self.contentView.addSubview(self.timeLabel)
        
   
        self.commentCount.font = UIFont.systemFont(ofSize: 12)
        self.commentCount.textColor = UIColor.gray
        self.contentView.addSubview(self.commentCount)
    }
    
    func addLayout() -> Void {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5);
            make.left.equalToSuperview().offset(8);
            make.right.equalToSuperview().offset(-8);
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8);
            make.left.equalToSuperview().offset(8);
            make.right.equalToSuperview().offset(-8);
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
        }
        
        commentCount.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
