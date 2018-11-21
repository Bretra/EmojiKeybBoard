//
//  ZYTextAttachment.m
//  KeyboardForChat
//
//  Created by VillageMud on 2018/11/20.
//  Copyright © 2018 ruofei. All rights reserved.
//

#import "ZYTextAttachment.h"

@implementation ZYTextAttachment
- (instancetype)initWithImage:(UIImage *)image
{
    if (self = [super init])
    {
        self.image = image;
    }
    return self;
    
}

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    return CGRectMake(0, -lineFrag.size.height * 0.2, lineFrag.size.height, lineFrag.size.height);
}

@end
