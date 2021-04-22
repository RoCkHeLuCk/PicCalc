program PicCalc;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {FrmPicCalc};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'PicCalc';
  Application.CreateForm(TFrmPicCalc, FrmPicCalc);
  Application.Run;
end.
