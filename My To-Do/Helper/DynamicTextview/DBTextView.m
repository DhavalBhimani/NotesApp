//
//  DBTextView.m
//  DataForm
//
//  Created by C234 on 03/11/17.
//  Copyright © 2017 DB Framework. All rights reserved.
//

#import "DBTextView.h"

//code used for place holder - https://stackoverflow.com/a/1704469/7620713

@interface DBTextView ()

@property (nonatomic, retain) UILabel *placeHolderLabel;

@end
@implementation DBTextView
CGFloat const UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION = 0.10;
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if __has_feature(objc_arc)
#else
    [_placeHolderLabel release]; _placeHolderLabel = nil;
    [_placeholderColor release]; _placeholderColor = nil;
    [_placeholder release]; _placeholder = nil;
    [super dealloc];
#endif
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Use Interface Builder User Defined Runtime Attributes to set
    // placeholder and placeholderColor in Interface Builder.
    if (!self.placeholder) {
        [self setPlaceholder:@""];
    }
    
    if (!self.placeholderColor) {
        [self setPlaceholderColor:[UIColor lightGrayColor]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}
- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    [UIView animateWithDuration:UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION animations:^{
        if([[self text] length] == 0)
        {
            [[self viewWithTag:999] setAlpha:1];
        }
        else
        {
            [[self viewWithTag:999] setAlpha:0];
        }
    }];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}
- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if (_placeHolderLabel == nil )
        {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
}

//Initial Methods
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self preparePlaceholder];
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //[self preparePlaceholder];
    }
    return self;
}
//

#pragma mark ---> SetUpBorder (Width,Color)
/**
 Set BorderWidth of UIView  Control.
 */

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth != _borderWidth) {
        _borderWidth = borderWidth;
        [self updateLayerProperties];
    }
}

/**
 Set BorderColor of UIView  Control.
 */

- (void)setBorderColor:(UIColor *)borderColor {
    if (borderColor != _borderColor) {
        _borderColor = borderColor;
        [self updateLayerProperties];
    }
}

#pragma mark ---> SetUpCornerRadious
/**
 Set CornerRadious of UIView  Control.
 */

- (void)setCornerRadious:(CGFloat)cornerRadious {
    if (cornerRadious != _CornerRadious) {
        _CornerRadious = cornerRadious;
        [self updateLayerProperties];
    }
}

/**
 Set CornerRadious of UIView  Control.
 */
-(void)setNeedCircleView:(BOOL)NeedCircleView{
    if (NeedCircleView!=_NeedCircleView) {
        _NeedCircleView=NeedCircleView;
    }
    if (NeedCircleView==YES) {
        [self updateLayerProperties];
    }else{
        [self setCornerRadious:_CornerRadious];
    }
    
}

#pragma mark ---> SetUpShadow

/**
 Set ShadowOpacity of UIView  Control.
 */

-(void)setShadowOpacity:(CGFloat)ShadowOpacity{
    if (ShadowOpacity != _ShadowOpacity) {
        _ShadowOpacity = ShadowOpacity;
        [self setupShadow];
    }
    
}

/**
 Set ShadowColor of UIView  Control.
 */

-(void)setShadowColor:(UIColor *)ShadowColor{
    if (ShadowColor != _ShadowColor) {
        _ShadowColor = ShadowColor;
        [self setupShadow];
    }
}


/**
 Set ShadowOffSet of UIView  Control.
 */

-(void)setShadowOffset:(CGSize)ShadowOffset{
    
    
    _ShadowOffset = CGSizeMake(ShadowOffset.width, ShadowOffset.height); //ShadowOffset;
    [self setupShadow];
    
}

/**
 Set ShadowRadious of UIView  Control.
 */

-(void)setShadowRadious:(CGFloat)ShadowRadious{
    if (ShadowRadious != _ShadowRadious) {
        _ShadowRadious = ShadowRadious;
        [self setupShadow];
    }
}
//Setup Proporties

- (void)updateLayerProperties {
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
    if (self.NeedCircleView==YES) {
        self.layer.cornerRadius=self.layer.frame.size.height/2;
    }else{
        self.layer.cornerRadius = self.CornerRadious;
        
    }
    self.layer.masksToBounds = YES;
    
}
//Setup Shadow
-(void)setupShadow{
    self.layer.shadowColor=self.ShadowColor.CGColor;
    self.layer.shadowOffset=  CGSizeMake (self.ShadowOffset.width,self.ShadowOffset.height);  //self.ShadowOffset;
    self.layer.shadowOpacity=self.ShadowOpacity;
    self.layer.masksToBounds = NO;
}
@end
