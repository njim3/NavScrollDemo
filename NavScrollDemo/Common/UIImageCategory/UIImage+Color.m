//
//  UIImage+Color.m
//  NavScrollDemo
//
//  Created by njim3 on 2018/10/15.
//  Copyright © 2018 njim3. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage*)imageWithColor: (UIColor*)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
