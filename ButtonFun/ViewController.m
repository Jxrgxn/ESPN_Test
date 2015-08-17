//
//  ViewController.m
//  ButtonFun
//
//  Created by BASEL FARAG on 8/13/15.
//  Copyright (c) 2015 BaselNotBasilProductions. All rights reserved.
//

#import "ViewController.h"
#import "FunViewSquare.h"

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@interface ViewController ()
@property CGRect butCGRect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self supportedInterfaceOrientations];

    [self setUpRectColorChangeRandomization];

    //Programmatically create the gestureRecognizer upon load
    butGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleFunViewSquareTap:)];
    if(butGestureRecognizer)
    {
        [self.view addGestureRecognizer: butGestureRecognizer];
    }

}

/*A method designed to determine what device is currently being used,
and which subsequently adjusts the interface orientation*/
- (NSUInteger)supportedInterfaceOrientations
{
    if (IDIOM == IPAD) {
        return UIInterfaceOrientationPortrait | UIInterfaceOrientationPortraitUpsideDown;
    }
    else {
    return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeRight;
    }
}


- (void)setUpRectColorChangeRandomization
{
    //Set up the CGRect we've created and set it's position
    self.butCGRect = self.view.frame;
    NSInteger xIndex, yIndex = 0;
    for( CGFloat yPosition = 0.0; yPosition < self.butCGRect.size.height; yPosition+=40.0f )
    {
        // reset xIndex on every iteration
        xIndex = 0;
        for( CGFloat xPosition = 0.0; xPosition < self.butCGRect.size.width; xPosition+=40.0f )
        {
            //Create an instance of randomSquare using our FunViewSquare class
            FunViewSquare *randomSquare = [[FunViewSquare alloc] initWithFrame: CGRectMake(xPosition, yPosition, 40.f, 40.0f)];
            /*Once we've created out instance and assigned it positions,
             generate a random color for it and add it to the subviews*/
            if(randomSquare)
            {
                randomSquare.backgroundColor = [self randomColor];
                randomSquare.xIndex = xIndex;
                randomSquare.yIndex = yIndex;
                [self.view addSubview: randomSquare];
            }
            xIndex++;
        }
        yIndex++;
    }
}

- (void)handleFunViewSquareTap:(UITapGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        // handling code
        CGPoint locationOfTap = [sender locationInView: self.view];
        NSInteger xIndex = floorf(locationOfTap.x / 40.f);
        NSInteger yIndex = floorf(locationOfTap.y / 40.f);

        // find the view that matches these indexes
        for(FunViewSquare *specificSquare in [self.view subviews])
        {
            //The only view we're interested in are the ones associated with the FunViewSquare class. So we check to make sure that the view we're handling is of type
            if ([specificSquare isKindOfClass:[FunViewSquare class]]) {
                if((specificSquare.xIndex == xIndex) && (specificSquare.yIndex == yIndex))
                {
                    specificSquare.backgroundColor = [self randomColor];
                }
            }
        }
    }
}


- (UIColor *)randomColor
{
    UIColor *colorToReturn;

    uint32_t randomNumber = random();
    randomNumber = (randomNumber % 10); // a random number between 0 & 10

    switch(randomNumber)
    {
        case 0 :
            colorToReturn = [UIColor blueColor];
            break;
        case 1 :
            colorToReturn = [UIColor grayColor];
            break;
        case 2 :
            colorToReturn = [UIColor greenColor];
            break;
        case 3 :
            colorToReturn = [UIColor purpleColor];
            break;
        case 4 :
            colorToReturn = [UIColor redColor];
            break;
        case 5 :
            colorToReturn = [UIColor brownColor];
            break;
        case 6 :
            colorToReturn = [UIColor cyanColor];
            break;
        case 7 :
            colorToReturn = [UIColor orangeColor];
            break;
        case 8 :
            colorToReturn = [UIColor magentaColor];
            break;
        case 9 :
            colorToReturn = [UIColor whiteColor];
            break;
        default :
            colorToReturn = [UIColor blackColor];

    }
    return(colorToReturn);
}

@end
