//
//  NSString+Regular.h
//  KeyboardForChat
//
//  Created by VillageMud on 2018/11/20.
//  Copyright © 2018 ruofei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Regular)

/**
 *  返回正则表达式匹配的第一个结果
 *
 *  @param pattern 正则表达式
 *
 *  @return 匹配的第一个结果 是NSTextCheckingResult类型
 */
-(NSTextCheckingResult *)firstMacthWithPattern:(NSString *)pattern;

-(NSArray <NSTextCheckingResult *> *)machesWithPattern:(NSString *)pattern;

@end

NS_ASSUME_NONNULL_END
