//
//  Constants.h
//  My To-Do
//
//  Created by DhavalBhimani on 12/1/18.
//  Copyright © 2018 DhavalBhimani. All rights reserved.
//

#pragma mark - Storyboards Constants
#define SB_Home @"Home"

#pragma mark - Storyboard
#define getStoryboard(StoryboardWithName) [UIStoryboard storyboardWithName:StoryboardWithName bundle:NULL]
#define loadViewController(StoryBoardName, VCIdentifer) [getStoryboard(StoryBoardName)instantiateViewControllerWithIdentifier:VCIdentifer]

#define APPDELEGATE  ((AppDelegate*)[[UIApplication sharedApplication] delegate])
