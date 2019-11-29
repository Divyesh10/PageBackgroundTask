pageextension 50120 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field(PostedInvoiceCount; PostedInvoiceCount)
            {
                ApplicationArea = All;
                Caption = 'Posted Sales Invoice Count';
                Editable = false;
            }
        }
    }
    var
        WaitTaskId: Integer;
        PostedInvoiceCount: Text;

    trigger OnAfterGetCurrRecord()
    var
        TaskParameters: Dictionary of [Text, Text];
    begin
        TaskParameters.Add('CustomerNo', "No.");
        CurrPage.EnqueueBackgroundTask(WaitTaskId, 50100, TaskParameters, 1000, PageBackgroundTaskErrorLevel::Warning);
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        PBTNotification: Notification;
    begin
        if (TaskId = WaitTaskId) then begin
            Evaluate(PostedInvoiceCount, Results.Get('PCount'));
        end;
    end;

    trigger OnPageBackgroundTaskError(TaskId: Integer; ErrorCode: Text; ErrorText: Text; ErrorCallStack: Text; var IsHandled: Boolean)
    var
        PBTErrorNotification: Notification;
    begin
        if (ErrorText = 'Child Session task was terminated because of a timeout.') then begin
            IsHandled := true;
            PBTErrorNotification.Message('It took to long to get results. Try again.');
            PBTErrorNotification.Send();
        end;
    end;
}
