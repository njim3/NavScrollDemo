//
//  BaseVC.m
//  NavScrollDemo
//
//  Created by njim3 on 2018/10/16.
//  Copyright © 2018 njim3. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)setNavColorWithAlpha: (CGFloat)alpha {
    [self.navigationController.navigationBar setShadowImage: [UIImage new]];
    
    [self.navigationController.navigationBar setBackgroundImage:
     [UIImage imageWithColor: [COLOR_NAV colorWithAlphaComponent: alpha]]
                                                  forBarMetrics: UIBarMetricsDefault];
}

@end
