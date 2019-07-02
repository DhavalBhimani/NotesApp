//
//  AddNotesVC.h
//  My To-Do
//
//  Created by DhavalBhimani on 12/1/18.
//  Copyright © 2018 DhavalBhimani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBTextView.h"
#import "WSNotes.h"
@protocol UpdateNoteDelegate <NSObject>
    -(void)didTodoChanged:(WSNotes*)note;
@end

@interface AddNotesVC : UIViewController<UITextViewDelegate>
@property (nonatomic, assign) id <UpdateNoteDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDone;
- (IBAction)btnDoneClicked:(id)sender;
@property (weak, nonatomic) IBOutlet DBTextView *txtVwAddNote;
@property (assign, nonatomic) WSNotes *objNoteToEdit;
@property (assign, nonatomic) BOOL isForEditNote;
@end
