//
//  EmotionInfo.h
//  EmotionLabel
//
//  Created by sumeng on 3/2/15.
//  Copyright (c) 2015 sumeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EmotionInfo : NSObject

+ (EmotionInfo *)shared;

- (NSArray *)all;
- (UIImage *)imageForKey:(NSString *)key;

@end