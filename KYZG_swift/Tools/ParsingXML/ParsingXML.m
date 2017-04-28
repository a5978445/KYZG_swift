//
//  ParsingXML.m
//  test
//
//  Created by 李腾芳 on 16/10/28.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import "ParsingXML.h"
#import "GDataXMLNode.h"
@implementation ParsingXML {
    GDataXMLDocument *_document;
    NSDictionary *_dic;
}

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        NSError *error;
        _document = [[GDataXMLDocument alloc]initWithData:data options:0 error:&error];
        if (error) {
            NSLog(@"warn:%@",error);
        }
       // NSLog(@"%@",_document.rootElement);
    }
    return self;
}

- (NSDictionary *)dic {
    if (_dic == nil) {
        
        if (_document.rootElement.name) {
          //  _dic =  @{_document.rootElement.name:[self parsingELement:_document.rootElement]};
            _dic = [self parsingELement:_document.rootElement];
        }
        
    }
  //  NSLog(@"%@",_dic);
    return _dic;
}

- (NSDictionary *)parsingELement:(GDataXMLElement *)element {
    
    if (element == nil) {
        return nil;
    }
  //  NSLog(@"%@",element);
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
   // NSLog(@"%@",element.attributes);
    for (GDataXMLElement *childElement in element.attributes) {
        if ([childElement isKindOfClass:[GDataXMLElement class]]) {
            dic[childElement.name] = childElement.stringValue;
        }
        
    }
    
    
    if ([element.children.firstObject isKindOfClass:[GDataXMLElement class]]) {
        for (GDataXMLElement *childElement in  element.children) {
            if (dic[childElement.name]) {
                NSMutableDictionary *childDic = dic[childElement.name];
                NSDictionary *otherDic = [self parsingELement:childElement];
                NSMutableArray *array = @[childDic.allValues].mutableCopy;
                [array addObject:otherDic.allValues];
                dic[childElement.name] = array;
            } else {
                [dic addEntriesFromDictionary:[self parsingELement:childElement]];
             //   NSLog(@"%@",dic.allValues);
             //   NSLog(@"%@",dic.allKeys);
                
            }
        }
    } else {
        
        return  [[NSMutableDictionary alloc]initWithObjects:@[element.stringValue] forKeys:@[element.name]];
        
    }
    
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc]initWithObjects:@[dic] forKeys:@[element.name]];
//    NSLog(@"%@",resultDic);
    return resultDic;
}

@end
