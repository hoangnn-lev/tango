//
//  Conversation.h
//  tango
//
//  Created by Hoang on 9/29/14.
//  Copyright (c) 2014 Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conversation : NSObject

@property int id;
@property (nonatomic, strong) NSString *native_language;
@property (nonatomic, strong) NSString *second_language;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *favorite;
@property (nonatomic, strong) NSString *modified;
@end
