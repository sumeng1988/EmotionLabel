//
//  EmotionLabel.h
//  EmotionLabel
//
//  Created by sumeng on 3/2/15.
//  Copyright (c) 2015 sumeng. All rights reserved.
//

#import "M80AttributedLabel.h"

@interface EmotionLabel : M80AttributedLabel

@property (nonatomic, assign) BOOL canCopy;
@property (nonatomic, assign) CGSize maxEmotionSize;

@end
