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


+ (NSAttributedString *)attributedString:(NSString *)text {
    NSString *pattern = [[self class] buildPattern:[[EmotionInfo shared] all]];
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matchs = [regExp matchesInString:text
                                      options:NSMatchingReportCompletion
                                        range:NSMakeRange(0, [text length])];
    NSInteger loc = 0;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] init];
    for (NSTextCheckingResult *match in matchs) {
        NSString *component = [text substringWithRange:NSMakeRange(loc, match.range.location-loc)];
        [str appendAttributedString:[[NSAttributedString alloc] initWithString:component]];
        
        NSString *emotion = [text substringWithRange:match.range];
        loc = match.range.location + match.range.length;
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [[EmotionInfo shared] imageForKey:emotion];
        [str appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    }
    if (loc < text.length) {
        NSString *component = [text substringFromIndex:loc];
        [str appendAttributedString:[[NSAttributedString alloc] initWithString:component]];
    }
    return str;
}

+ (NSString *)buildPattern:(NSArray *)keys {
    NSString *ret = @"(";
    for (int i = 0; i < keys.count; i++) {
        NSString *emotion = [keys objectAtIndex:i];
        NSString *key = [NSRegularExpression escapedPatternForString:emotion];
        ret = [ret stringByAppendingString:key];
        if (i != keys.count - 1) {
            ret =[ret stringByAppendingString:@"|"];
        }
    }
    ret = [ret stringByAppendingString:@")"];
    return ret;
}

@end
