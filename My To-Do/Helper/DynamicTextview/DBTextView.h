//
//  DBTextView.h
//  DataForm
//
//  Created by C234 on 03/11/17.
//  Copyright © 2017 DB Framework. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

IB_DESIGNABLE
@interface DBTextView : UITextView
#pragma mark ---> SetUpBorder (Width,Color)
/**
 Set BorderWidth of UIView  Control.
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/**
 Set BorderColor of UIView  Control.
 */
@property (nonatomic, copy)   IBInspectable UIColor *borderColor;

#pragma mark ---> SetUpCornerRadious
/**
 Set CornerRadious of UIView  Control.
 */
@property (nonatomic, assign)   IBInspectable CGFloat CornerRadious;
/**
 Set Round  Control.
 */
@property (nonatomic, assign)   IBInspectable BOOL NeedCircleView;

#pragma mark ---> SetUpShadow
/**
 Set ShadowOpacity of UIView  Control.
 */
@property (nonatomic, assign)   IBInspectable CGFloat ShadowOpacity;

/**
 Set ShadowColor of UIView  Control.
 */
@property (nonatomic, copy)   IBInspectable UIColor *ShadowColor;

/**
 Set ShadowOffSet of UIView  Control.
 */
@property (nonatomic, assign)   IBInspectable CGSize ShadowOffset;

/**
 Set ShadowRadious of UIView  Control.
 */
@property (nonatomic, assign)   IBInspectable CGFloat ShadowRadious;

/*
@property (copy, nonatomic) IBInspectable NSString *placeholder;

@property (nonatomic) IBInspectable double fadeTime;
@property (copy, nonatomic) IBInspectable NSAttributedString *attributedPlaceholder;
@property (retain, nonatomic) IBInspectable UIColor *placeholderTextColor;*/

@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;
@end
