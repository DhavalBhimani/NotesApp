//
//  CellToDosList.h
//  My To-Do
//
//  Created by DhavalBhimani on 12/1/18.
//  Copyright © 2018 DhavalBhimani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellToDosList : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblNoteTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end
