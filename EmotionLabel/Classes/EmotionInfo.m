//
//  EmotionInfo.m
//  EmotionLabel
//
//  Created by sumeng on 3/2/15.
//  Copyright (c) 2015 sumeng. All rights reserved.
//

#import "EmotionInfo.h"

@interface EmotionInfo ()

@property (nonatomic, strong) NSDictionary *dict;

@end

@implementation EmotionInfo

static EmotionInfo *instance = nil;

+ (EmotionInfo *)shared {
    if (instance == nil) {
        instance = [[EmotionInfo alloc] init];
    }
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"emotions"
                                                         ofType:@"plist"];
        _dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    return self;
}

- (NSArray *)all {
    return _dict.allKeys;
}

- (UIImage *)imageForKey:(NSString *)key {
    return [UIImage imageNamed:[_dict objectForKey:key]];
}

@end
