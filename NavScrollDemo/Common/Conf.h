//
//  Conf.h
//  NavScrollDemo
//
//  Created by njim3 on 2018/10/15.
//  Copyright © 2018 njim3. All rights reserved.
//

#ifndef Conf_h
#define Conf_h


#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height

#define NAVBAR_HEIGHT           self.navigationController.navigationBar.frame.size.height
#define TABBAR_HEIGHT           self.tabBarController.tabBar.frame.size.height

#define COLOR_NAV               [UIColor add_colorWithRGBHexString: @"2D95E9"]

#define CELLIDENTIFIER_HOMEVC   @"HomeVCTableIdentifier"
#define HEIGHT_HOMEVC_TABLE     84.0f

#define SEGUE_HOME2DETAIL       @"SEGUEHOME2DETAIL"

#define HEIGHT_DETAILVC_TABLE   44.0f
#define CELLIDENTIFIER_DETAILVC @"DetailVCTableIdentifier"


#endif /* Conf_h */
