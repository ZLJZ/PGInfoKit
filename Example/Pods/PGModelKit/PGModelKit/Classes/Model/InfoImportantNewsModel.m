//
//  InfoImportantNewsModel.m
//  PanGu
//
//  Created by 张琦 on 2017/7/24.
//  Copyright © 2017年 Security Pacific Corporation. All rights reserved.
//

#import "InfoImportantNewsModel.h"

@implementation InfoImportantNewsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.newsno = [aDecoder decodeObjectForKey:@"newsno"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.digest = [aDecoder decodeObjectForKey:@"digest"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.newsno forKey:@"newsno"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.digest forKey:@"digest"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.image forKey:@"image"];
}

@end
