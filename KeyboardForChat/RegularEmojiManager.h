//
//  RegularEmojiManager.h
//  KeyboardForChat
//
//  Created by VillageMud on 2018/11/20.
//  Copyright © 2018 ruofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegularEmojiManager : NSObject

- (NSMutableAttributedString *)regularSpecialCharsWithCovertString:(NSString *)covertString andFont:(UIFont *)font;


- (NSMutableAttributedString *)regularEmojiWithString:(NSString *)string;


@end

NS_ASSUME_NONNULL_END
