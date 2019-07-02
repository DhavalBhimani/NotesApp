//
//  AddNotesVC.m
//  My To-Do
//
//  Created by DhavalBhimani on 12/1/18.
//  Copyright © 2018 DhavalBhimani. All rights reserved.
//

#import "AddNotesVC.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "Function.h"
@interface AddNotesVC ()
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation AddNotesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];
    _txtVwAddNote.delegate=self;
    if(_isForEditNote){
        self.txtVwAddNote.text = _objNoteToEdit.note;
    }
    [self enableDisableDoneButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - save todo clicked
- (IBAction)btnDoneClicked:(id)sender {
    if(_txtVwAddNote.text.length > 0){
        [self createOrUpdateNoteWithString:_txtVwAddNote.text];
    }
}
- (void)createOrUpdateNoteWithString:(NSString*)textNote{
    if(_isForEditNote){
        [[[self.ref child:_objNoteToEdit.internalBaseClassIdentifier] child:@"note"] setValue:textNote];
        [self.navigationController popViewControllerAnimated:YES];
        _objNoteToEdit.note = textNote;
        if(_delegate && [_delegate respondsToSelector:@selector(didTodoChanged:)]){
            [_delegate didTodoChanged:_objNoteToEdit];
        }
    }else{
        //formatted date
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"dd-MM-yyyy";
        NSString *date = [formatter stringFromDate:[NSDate date]];
        //save note
        [[self.ref child:[Function randomStringWithLength:6]]
         setValue:@{@"note": textNote,
                    @"date": date
                    }];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - textview delegate.
-(void)textViewDidChange:(UITextView *)textView{
    [self enableDisableDoneButton];
}
-(void)enableDisableDoneButton{
    if(_txtVwAddNote.text.length == 0){
        _btnDone.enabled = NO;
    }else{
        _btnDone.enabled = YES;
    }
}
@end
