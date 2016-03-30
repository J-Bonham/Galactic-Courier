//
//  YouWin.m
//  Galactic Courier
//
//  Created by Jeremiah Bonham on 5/17/15.
//  Copyright (c) 2015 Jeremiah.Bonham. All rights reserved.
//

#import "YouWin.h"
#import "LevelOne.h"
#import "Title.h"
@import iAd;

@interface YouWin () <ADBannerViewDelegate, UIAlertViewDelegate>
{

    
    SKSpriteNode *bg1;
    SKSpriteNode *stars1;
    
}

@property (nonatomic, strong) ADBannerView *ads;
@property (nonatomic) BOOL adVisible;

@end

@implementation YouWin

-(void)didMoveToView:(SKView *)view {
    
    self.scaleMode = SKSceneScaleModeAspectFill;
    
    self.backgroundColor = [SKColor blackColor];
    
    _ads = [[ADBannerView alloc] initWithFrame:CGRectZero];
    self.ads.delegate = self;
    [_ads setFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 100)];
    
    bg1 = [SKSpriteNode spriteNodeWithImageNamed:@"bg010"];
    bg1.anchorPoint = CGPointZero;
    bg1.position = CGPointMake(0, 0);
    bg1.zPosition = .5;
    [self addChild:bg1];
    
    stars1 = [SKSpriteNode spriteNodeWithImageNamed:@"stars010.png"];
    stars1.anchorPoint = CGPointZero;
    stars1.position = CGPointMake(0, 0);
    stars1.zPosition = .5;
    [self addChild:stars1];


    SKLabelNode *winner = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    winner.text = @"You Win!";
    winner.fontColor = [SKColor whiteColor];
    winner.fontSize = 40;
    winner.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    winner.zPosition = 1;
    [self addChild:winner];
    
    
    SKLabelNode *playAgain = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    
    playAgain.text = @"Tap To Continue";
    playAgain.fontColor = [SKColor whiteColor];
    playAgain.fontSize = 20;
    playAgain.position = CGPointMake(self.frame.size.width/2, -50);
    playAgain.zPosition = 1;
    SKAction *moveLabel = [SKAction moveToY:(self.frame.size.height/2 - 40) duration: 1.0];
    [playAgain runAction:moveLabel];
    
    [self addChild:playAgain];
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    if (!_adVisible){
        
        if (_ads.superview == nil){
            
            [self.view addSubview:_ads];
            
        }
        
        [UIView beginAnimations:@"animateAdBannerShow" context:NULL];
        _ads.frame = CGRectOffset(_ads.frame, 0, -_ads.frame.size.height);
        
        [UIView commitAnimations];
        
        _adVisible = YES;
        
    }
    
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    
    NSLog(@"Failed to load an Ad!");
    
    if (_adVisible){
        
        [UIView beginAnimations:@"animateAdBannerHide" context:NULL];
        _ads.frame = CGRectOffset(_ads.frame, 0, _ads.frame.size.height);
        
        [UIView commitAnimations];
        
        _adVisible = NO;
        
    }
    
}

-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    
    _ads.delegate = nil;
    [_ads removeFromSuperview];
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        [_ads removeFromSuperview];
        Title *firstScene = [Title sceneWithSize:self.size];
        [self.view presentScene:firstScene transition:[SKTransition doorsOpenHorizontalWithDuration:(1.25)]];
}



@end
