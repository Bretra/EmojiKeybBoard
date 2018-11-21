//
//  RegularEmojiManager.m
//  KeyboardForChat
//
//  Created by VillageMud on 2018/11/20.
//  Copyright © 2018 ruofei. All rights reserved.
//

#import "RegularEmojiManager.h"

#import "NSString+Regular.h"
#import "ZYTextAttachment.h"

@implementation RegularEmojiManager

- (NSMutableAttributedString *)regularSpecialCharsWithCovertString:(NSString *)covertString andFont:(nonnull UIFont *)font {
    // 需要正则的字符串
//    NSString *str = @"#呵呵呵#[偷笑] http://test.com/blah_blah";
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";

    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";

    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    
    
    // | 匹配多个条件,相当于or\或
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
//    NSString *pattern = [NSString stringWithFormat:@"%@", emotionPattern];
    // 使用系统的正则类来遍历
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    
    // 2.测试字符串
    NSArray *results = [regex matchesInString:covertString options:0 range:NSMakeRange(0, covertString.length)];
    if (!results) return nil;
    
    // 3.遍历结果
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"face" ofType:@"plist"];
    NSDictionary *faceDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableAttributedString *mutableAtt = [[NSMutableAttributedString alloc] initWithString:covertString];
     NSUInteger lengthDetail = 0;
    
    for (NSTextCheckingResult *result in results) {
        NSLog(@"%@ %@", NSStringFromRange(result.range), [covertString substringWithRange:result.range]);
        
        NSString *emojiKey = [covertString substringWithRange:result.range];
        NSString *imageName = faceDic[emojiKey];
       
        if (imageName) {
            NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
            //给附件添加图片
            textAttachment.image = [UIImage imageNamed:imageName];
            textAttachment.bounds = CGRectMake(0, -font.lineHeight * 0.2, font.lineHeight, font.lineHeight);
            //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
            NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];

            NSUInteger length = mutableAtt.length;
            NSRange newRange = NSMakeRange(result.range.location - lengthDetail, result.range.length);
            [mutableAtt replaceCharactersInRange:newRange withAttributedString:imageStr];
            
            lengthDetail += length - mutableAtt.length;
        }
    }
    return mutableAtt;
    
}

- (NSMutableAttributedString *)regularEmojiWithString:(NSString *)string {
    NSString *content = string;
    //匹配表情文字
    NSString *pattern = @"\\[\\w+\\]";
    
    NSArray *resultArr = [content machesWithPattern:pattern];
    if (!resultArr) return nil;
    
    NSMutableAttributedString *attrContent = [[NSMutableAttributedString alloc]initWithString:content];
    NSUInteger lengthDetail = 0;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"face" ofType:@"plist"];
    NSDictionary *faceDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    //遍历所有的result 取出range
    for (NSTextCheckingResult *result in resultArr) {
        //取出图片名
        NSString *emojiKey = [content substringWithRange:result.range];
        NSString *imageName = faceDic[emojiKey];
        
        // 创建AttributeString, 来包装图片
        ZYTextAttachment *attachment =   [[ZYTextAttachment alloc]initWithImage:[UIImage imageNamed:imageName]];
        // 将附近包装到NSAttributedString中
        NSAttributedString *imageString =   [NSAttributedString attributedStringWithAttachment:attachment];
        //图片附件的文本长度是1
        NSLog(@"%zd",imageString.length);
        
        NSUInteger length = attrContent.length;
        NSRange newRange = NSMakeRange(result.range.location - lengthDetail, result.range.length);
        [attrContent replaceCharactersInRange:newRange withAttributedString:imageString];
        
        lengthDetail += length - attrContent.length;
        
    }
    return attrContent;
}

@end
