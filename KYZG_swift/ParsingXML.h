//
//  ParsingXML.h
//  test
//
//  Created by 李腾芳 on 16/10/28.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParsingXML : NSObject

- (instancetype)initWithData:(NSData *)data;
@property(readonly,nonatomic) NSDictionary *dic;

@end
