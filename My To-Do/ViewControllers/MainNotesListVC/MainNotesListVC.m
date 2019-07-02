//
//  MainNotesListVC.m
//  My To-Do
//
//  Created by DhavalBhimani on 12/1/18.
//  Copyright © 2018 DhavalBhimani. All rights reserved.
//

#import "MainNotesListVC.h"
#import "CellToDosList.h"
#import "Constants.h"
#import "AppDelegate.h"
#import <FirebaseDatabase/FirebaseDatabase.h>
#import "WSNotes.h"

@import Firebase;

@interface MainNotesListVC ()
{
    NSMutableArray *arrNotesList;
}
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation MainNotesListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    arrNotesList = [[NSMutableArray alloc] init];
    self.ref = [[FIRDatabase database] reference];
    _tblToDoList.tableFooterView = [UIView new];
    [self getRecords];
    [self.ref observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        @try {
            if(snapshot != nil && [snapshot.value isKindOfClass: [NSDictionary class]]){
                WSNotes *objNote = [[WSNotes alloc] initWithDictionary:snapshot.value];
                objNote.internalBaseClassIdentifier = snapshot.key;
                NSPredicate *pred = [NSPredicate predicateWithFormat:@"internalBaseClassIdentifier == %@",objNote.internalBaseClassIdentifier];
                NSArray *filteredArr = [arrNotesList filteredArrayUsingPredicate:pred];
                if(filteredArr.count == 0){
                    [arrNotesList insertObject:objNote atIndex:0];
                    [_tblToDoList reloadData];
                }
            }
        } @catch (NSException *exception) {}
    }];
}
-(void)getRecords{

    [_ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            @try {
                if(snapshot != nil && [snapshot.value isKindOfClass: [NSArray class]]){
                    arrNotesList = [[NSMutableArray alloc] init];
                    NSArray *arrObjects = snapshot.children.allObjects;
                    for(int i=0; i<[arrObjects count]; i++){
                        FIRDataSnapshot *fireNote = [arrObjects objectAtIndex:i];
                        WSNotes *objNote = [[WSNotes alloc] initWithDictionary:fireNote.value];
                        objNote.internalBaseClassIdentifier = fireNote.key;
                        NSPredicate *pred = [NSPredicate predicateWithFormat:@"internalBaseClassIdentifier == %@",objNote.internalBaseClassIdentifier];
                        NSArray *filteredArr = [arrNotesList filteredArrayUsingPredicate:pred];
                        if(filteredArr.count == 0){
                            [arrNotesList addObject:objNote];
                        }
                    }
                    [_tblToDoList reloadData];
                }
            }@catch (NSException *exception) {
            }
        }
    withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - table view delegate

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrNotesList.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CellToDosList *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellToDosList" forIndexPath:indexPath];
    WSNotes *objNote = arrNotesList[indexPath.row];
    cell.lblNoteTitle.text = objNote.note;
    cell.lblDate.text = objNote.date;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddNotesVC *addNoteVC = loadViewController(SB_Home, @"AddNotesVC");
    addNoteVC.isForEditNote = YES;
    WSNotes *objNote = arrNotesList[indexPath.row];
    addNoteVC.objNoteToEdit = objNote;
    addNoteVC.delegate=self;
    [self.navigationController pushViewController:addNoteVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Confirm Delete?" message:@"Are you sure you want to delete this todo?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            WSNotes *objNote = arrNotesList[indexPath.row];
            [[self.ref child:objNote.internalBaseClassIdentifier] removeValue];
            [arrNotesList removeObjectAtIndex:indexPath.row];
            [_tblToDoList reloadData];
        }];
        UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:no];
        [alert addAction:yes];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Create New Note
- (IBAction)btnAddNoteClicked:(id)sender {
    AddNotesVC *addNoteVC = loadViewController(SB_Home, @"AddNotesVC");
    [self.navigationController pushViewController:addNoteVC animated:YES];
}

#pragma update note delagate
-(void)didTodoChanged:(WSNotes *)note{
    @try {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"internalBaseClassIdentifier == %@",note.internalBaseClassIdentifier];
        NSArray *filteredArr = [arrNotesList filteredArrayUsingPredicate:pred];
        if(filteredArr.count > 0){
            NSUInteger index = [arrNotesList indexOfObject:filteredArr.firstObject];
            [arrNotesList replaceObjectAtIndex:index withObject:note];
            [_tblToDoList reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:index inSection:0], nil] withRowAnimation:UITableViewRowAnimationFade];
        }
    } @catch (NSException *exception) {
        
    }
}
@end
