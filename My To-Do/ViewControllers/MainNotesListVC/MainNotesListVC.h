//
//  MainNotesListVC.h
//  My To-Do
//
//  Created by DhavalBhimani on 12/1/18.
//  Copyright © 2018 DhavalBhimani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNotesVC.h"
@interface MainNotesListVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UpdateNoteDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblToDoList;
- (IBAction)btnAddNoteClicked:(id)sender;

@end
