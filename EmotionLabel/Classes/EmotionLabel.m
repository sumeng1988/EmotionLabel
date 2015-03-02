//
//  EmotionLabel.m
//  EmotionLabel
//
//  Created by sumeng on 3/2/15.
//  Copyright (c) 2015 sumeng. All rights reserved.
//

#import "EmotionLabel.h"
#import "EmotionInfo.h"

@interface EmotionLabel ()

@property (nonatomic, copy) NSString *emotionText;

@end

@implementation EmotionLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initial];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initial];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initial];
    }
    return self;
}

- (void)initial {
    self.numberOfLines = 1;
    _canCopy = false;
    _maxEmotionSize = CGSizeZero;
    [self attachTapHandler];
}

- (void)setText:(NSString *)text {
    [super setText:@""];
    self.emotionText = text;
    
    NSString *pattern = [EmotionLabel buildPattern:[[EmotionInfo shared] all]];
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matchs = [regExp matchesInString:text
                                      options:NSMatchingReportCompletion
                                        range:NSMakeRange(0, [text length])];
    NSInteger loc = 0;
    for (NSTextCheckingResult *match in matchs) {
        NSString *component = [text substringWithRange:NSMakeRange(loc, match.range.location-loc)];
        NSString *emotion = [text substringWithRange:match.range];
        loc = match.range.location + match.range.length;
        [self appendText:component];
        [self appendImage:[[EmotionInfo shared] imageForKey:emotion]
                  maxSize:_maxEmotionSize];
    }
    if (loc < text.length) {
        NSString *component = [text substringFromIndex:loc];
        [self appendText:component];
    }
}

- (NSString *)getText {
    return _emotionText;
}

#pragma mark - Clipboard

- (void)attachTapHandler {
    [self setUserInteractionEnabled:YES];
    UILongPressGestureRecognizer *touchy = [[UILongPressGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:touchy];
}

- (void)handleTap:(UIGestureRecognizer*)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:self.frame inView:self.superview];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (void)copy:(id)sender {
    [UIPasteboard generalPasteboard].string = [self getText];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copy:) && _canCopy);
}

#pragma mark - pattern

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