codeunit 50100 PBTWaitCodeunit
{
    trigger OnRun()
    var
        Result: Dictionary of [Text, Text];
        StartTime: Time;
        WaitParam: Text;
        WaitTime: Integer;
        EndTime: Time;
        PostedSalesInvoice: Record "Sales Invoice Header";
    begin

        PostedSalesInvoice.Reset();
        PostedSalesInvoice.SetRange("Bill-to Customer No.", Page.GetBackgroundParameters().Get('CustomerNo'));
        IF NOT PostedSalesInvoice.IsEmpty then
            Result.add('PCount', Format(PostedSalesInvoice.Count))
        Else
            Result.add('PCount', '0');
        Page.SetBackgroundTaskResult(Result);
    end;
}
