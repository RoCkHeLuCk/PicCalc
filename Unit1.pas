unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, ShellApi;

type


  TFrmPicCalc = class(TForm)
    Panel1: TPanel;
    GrbCPU: TGroupBox;
    LblCPUHz: TLabel;
    LblCPUS: TLabel;
    EdtCPUHz: TEdit;
    CmbCPUHz: TComboBox;
    EdtCPUs: TEdit;
    CmbCPUs: TComboBox;
    GrbDivPre: TGroupBox;
    LblDivPreHz: TLabel;
    LblDivPreS: TLabel;
    EdtDivPreHz: TEdit;
    CmbDivPreHz: TComboBox;
    EdtDivPreS: TEdit;
    CmbDivPreS: TComboBox;
    CmbDivPreD: TComboBox;
    GrbTimer: TGroupBox;
    LblTimerHz: TLabel;
    LblTimerS: TLabel;
    EdtTimerHz: TEdit;
    CmbTimerHz: TComboBox;
    EdtTimerS: TEdit;
    CmbTimerS: TComboBox;
    EdtTimerI: TEdit;
    UpdTimerI: TUpDown;
    CkbTimerB: TCheckBox;
    EdtTimerF: TEdit;
    UpdTimerF: TUpDown;
    SttTimerM: TStaticText;
    GrbDivPro: TGroupBox;
    LblDivProHz: TLabel;
    LblDivProS: TLabel;
    EdtDivProHz: TEdit;
    CmbDivProHz: TComboBox;
    EdtDivProS: TEdit;
    CmbDivProS: TComboBox;
    CmbDivProD: TComboBox;
    GrpPIC: TGroupBox;
    Ckb18F: TCheckBox;
    RdgPICT: TRadioGroup;
    GrbCounter: TGroupBox;
    LblCounterHz: TLabel;
    LblCounterS: TLabel;
    EdtCounterHz: TEdit;
    CmbCounterHz: TComboBox;
    EdtCounterS: TEdit;
    CmbCounterS: TComboBox;
    EdtCounterC: TEdit;
    SttCounterC: TStaticText;
    PgcCalc: TPageControl;
    TbsFormula: TTabSheet;
    TbsAjuste: TTabSheet;
    TbsCodigo: TTabSheet;
    SctCounterC: TStaticText;
    TabSobre: TTabSheet;
    ImgSobre: TImage;
    LblSobreA: TLabel;
    LblSobreP: TLabel;
    LblSobreF: TLabel;
    EdtSobreE: TEdit;
    EdtSobreS: TEdit;
    PnlCodigo: TPanel;
    BtnCodigoGer: TButton;
    CkbCodigoDel: TCheckBox;
    CkbCodigoInt: TCheckBox;
    CkbCodigoSet: TCheckBox;
    CkbCodigoEna: TCheckBox;
    CkbCodigoDef: TCheckBox;
    CkbCodigoFlg: TCheckBox;
    CkbCodigoMan: TCheckBox;
    RceCodigo: TRichEdit;
    PnlAjuste: TPanel;
    RdgAjuste: TRadioGroup;
    BtnProcurar: TButton;
    CkbFixDivPre: TCheckBox;
    CkbFixDivPro: TCheckBox;
    LtvAjuste: TListView;
    LblFormulaCPU: TLabel;
    LblFormulaHz: TLabel;
    LblFormulaDiv: TLabel;
    LblFormulaResp: TLabel;
    RdgFormula: TRadioGroup;
    LblFormulaInvert: TLabel;
    //procedures
    procedure CmbCPUHzSelect(Sender: TObject);
    procedure CmbCPUsSelect(Sender: TObject);
    procedure CkbTimerBClick(Sender: TObject);
    procedure RdgPICTClick(Sender: TObject);
    procedure Ckb18FClick(Sender: TObject);
    procedure EdtCPUHzKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CmbDivPreDSelect(Sender: TObject);
    procedure EdtTimerIChange(Sender: TObject);
    procedure CmbDivProDSelect(Sender: TObject);
    procedure EdtCounterHzChange(Sender: TObject);
    procedure EdtCounterSChange(Sender: TObject);
    procedure EdtCounterCChange(Sender: TObject);
    procedure EdtCPUHzChange(Sender: TObject);
    procedure BtnProcurarClick(Sender: TObject);
    procedure RdgAjusteClick(Sender: TObject);
    procedure LtvAjusteSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure CkbCodigoIntClick(Sender: TObject);
    procedure BtnCodigoGerClick(Sender: TObject);
    procedure CkbCodigoManClick(Sender: TObject);
    procedure EdtSobreEClick(Sender: TObject);
    procedure EdtSobreSClick(Sender: TObject);
    procedure RdgFormulaClick(Sender: TObject);
  private
    { Private declarations }
    function GetPrefixoSI( Valor: Extended ): Int8;
    function SetPrefixoSI( Valor: Extended; Prefixo: TComboBox): String;
    function ExtractPrefixoSi( Prefixo: TComboBox): String;
    function ConvertToPrefixoSI( Valor: Extended; Prefixo: Int8): Extended;
    function ConvertFromPrefixoSI( Valor: Extended; Prefixo: Int8): Extended;
    procedure WMMouseWheel(var MessVal:TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure SetBist();
  public
    { Public declarations }
  end;

var
  FrmPicCalc: TFrmPicCalc;

implementation

{$R *.dfm}

{
(y) yocto
(z) zepto
(a) atto
(f) femto
(p) pico
(n) nano
(u) micro
(m) mili
---
(K) quilo
(M) Mega
(G) Giga
(T) Tera
(P) Peta
(E) Exa
(Z) Zetta
(Y) Yotta
}

//----------------------------------------------------------------------------//
procedure TFrmPicCalc.WMMouseWheel(VAR MessVal:TWMMouseWheel);
    procedure UpDown(Edit : TEdit);
    begin
        if (MessVal.WheelDelta > 0) then
           Edit.Text := FloatToStr( StrToFloat(Edit.Text) + 1 )
        else
           Edit.Text := FloatToStr( StrToFloat(Edit.Text) - 1 );
    end;

begin

    if (EdtTimerF.MouseInClient) then
    begin
        if (MessVal.WheelDelta > 0) then
        begin
             UpdTimerF.Position := UpdTimerF.Position + 1;
        end else begin
             UpdTimerF.Position := UpdTimerF.Position - 1;
        end;
    end else
    if  (EdtTimerI.Enabled)
    and (EdtTimerI.MouseInClient) then
    begin
        if (MessVal.WheelDelta > 0) then
        begin
             UpdTimerI.Position := UpdTimerI.Position + 1;
        end else begin
             UpdTimerI.Position := UpdTimerI.Position - 1;
        end;
    end;

end;
//----------------------------------------------------------------------------//
function TFrmPicCalc.GetPrefixoSI( Valor:Extended ): Int8;
var
   prefixo : Extended;
   c : Int8;
begin
    c := 0;
    repeat
        Prefixo := Power10( 1 , (c*3) - 24 );
        inc(c);
    until (Valor < Prefixo) or (c > 16) ;

    Result := c-2;
end;
//----------------------------------------------------------------------------//
function TFrmPicCalc.SetPrefixoSI( Valor: Extended; Prefixo: TComboBox): String;
begin
    Prefixo.ItemIndex := GetPrefixoSI(Valor);
    Valor := ConvertFromPrefixoSI( Valor, Prefixo.ItemIndex );
    Result := FormatFloat('', Valor);
end;
//----------------------------------------------------------------------------//
function TFrmPicCalc.ExtractPrefixoSi( Prefixo: TComboBox): String;
begin
   Result := '';
   if Prefixo.ItemIndex <> 8 then
      Result := Copy(Prefixo.Text,2,1);
end;
//----------------------------------------------------------------------------//
function TFrmPicCalc.ConvertToPrefixoSI( Valor: Extended; Prefixo: Int8):Extended;
begin
    Prefixo :=  (Prefixo*3) - 24;
    Result := Power10(Valor, Prefixo );
end;
//----------------------------------------------------------------------------//
function TFrmPicCalc.ConvertFromPrefixoSI( Valor: Extended; Prefixo: Int8):Extended;
begin
    Prefixo := 16 - Prefixo;
    Prefixo :=  (Prefixo*3) - 24;
    Result := Power10(Valor, Prefixo );
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.CmbCPUHzSelect(Sender: TObject);
var
   EditHz, EditS : TEdit;
   CombHz, CombS : TComboBox;
   Group : TGroupBox;
   Valor: Extended;
begin
    Group := TGroupBox(TComboBox(Sender).Parent);
    EditHz := TEdit(Group.Controls[2]);
    CombHz := TComboBox(Group.Controls[3]);
    EditS := TEdit(Group.Controls[4]);
    CombS := TComboBox(Group.Controls[5]);

    if  TryStrToFloat(EditS.Text, Valor)
    and (Valor <> 0) then
    begin
        Valor := ConvertToPrefixoSI( Valor , CombS.ItemIndex );
        Valor := 1 / Valor;
        Valor := ConvertFromPrefixoSI( Valor, CombHz.ItemIndex );
        EditHz.Text :=  FormatFloat('', Valor);
    end;
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.CmbCPUsSelect(Sender: TObject);
var
   EditHz, EditS : TEdit;
   CombHz, CombS : TComboBox;
   Group : TGroupBox;
   Valor: Extended;
begin
    Group := TGroupBox(TComboBox(Sender).Parent);
    EditHz := TEdit(Group.Controls[2]);
    CombHz := TComboBox(Group.Controls[3]);
    EditS := TEdit(Group.Controls[4]);
    CombS := TComboBox(Group.Controls[5]);

    if  TryStrToFloat(EditHZ.Text, Valor)
    and (Valor <> 0) then
    begin
        Valor := ConvertToPrefixoSI( Valor , CombHZ.ItemIndex );
        Valor := 1 / Valor;
        Valor := ConvertFromPrefixoSI( Valor, CombS.ItemIndex );
        EditS.Text :=  FormatFloat('', Valor);
    end;
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.EdtCPUHzChange(Sender: TObject);
var
   Valor : Extended;
begin
    if  TryStrToFloat(EdtCPUHz.Text, Valor)
    and (Valor <> 0) then
    begin
        Valor := ConvertToPrefixoSI( Valor , CmbCPUHz.ItemIndex );
        Valor := 1 / Valor;
        EdtCPUs.Text := SetPrefixoSI( Valor, CmbCPUS);
    end;

   CmbDivPreD.OnSelect(Sender);
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.CmbDivPreDSelect(Sender: TObject);
var
   Valor : Extended;
begin
    if  TryStrToFloat(EdtCPUHz.Text,Valor)
    and (Valor <> 0) then
    begin
        Valor := ConvertToPrefixoSI( Valor, CmbCPUHz.ItemIndex );
        Valor := Valor / 4;

        Valor := Valor / StrToInt( CmbDivPreD.Text );
        EdtDivPreHz.Text := SetPrefixoSI( Valor, CmbDivPreHz);

        Valor := 1 / Valor;
        EdtDivPreS.Text := SetPrefixoSI( Valor, CmbDivPreS);
    end else begin
        EdtDivPreHz.Clear;
        EdtDivPreS.Clear;
    end;

   EdtTimerI.OnChange(Sender);
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.EdtTimerIChange(Sender: TObject);
var
   Valor: Extended;
   I,F: Integer;
begin
    if  TryStrToFloat(EdtDivPreHz.Text,Valor)
    and TryStrToInt(EdtTimerI.Text,I)
    and TryStrToInt(EdtTimerF.Text,F)
    and (I > F)
    and (Valor <> 0) then
    begin
        Valor := ConvertToPrefixoSI( Valor, CmbDivPreHz.ItemIndex );

        Valor := Valor / ( I - F ) ;
        EdtTimerHz.Text := SetPrefixoSI( Valor, CmbTimerHz);

        Valor := 1 / Valor;
        EdtTimerS.Text := SetPrefixoSI( Valor, CmbTimerS);

    end else begin
        EdtTimerHz.Clear;
        EdtTimerS.Clear;
    end;

    CmbDivProD.OnSelect(Sender);
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.CmbDivProDSelect(Sender: TObject);
var
   Valor : Extended;
begin
    if  TryStrToFloat(EdtTimerHz.Text,Valor)
    and (Valor <> 0) then
    begin
        Valor := ConvertToPrefixoSI( Valor, CmbTimerHz.ItemIndex );

        Valor := Valor / StrToInt( CmbDivProD.Text );
        EdtDivProHz.Text := SetPrefixoSI( Valor, CmbDivProHz);

        Valor := 1 / Valor;
        EdtDivProS.Text := SetPrefixoSI( Valor, CmbDivProS);
    end else begin
        EdtDivProHz.Clear;
        EdtDivProS.Clear;
    end;

    EdtCounterHz.OnChange(Sender);
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.SetBist();
var
   Valor : Extended;
begin
    TryStrToFloat(EdtCounterC.Text,Valor);
    if Valor < 255 then
       SctCounterC.Caption := '8 bits'
    else if Valor < 65535 then
       SctCounterC.Caption := '16 bits'
    else if Valor < 4294967295 then
       SctCounterC.Caption := '32 bits'
    else
       SctCounterC.Caption := '64 bits'
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.EdtCounterHzChange(Sender: TObject);
var
   Valor1, Valor2 : Extended;
begin
    EdtCounterS.OnChange := nil;
    EdtCounterC.OnChange := nil;

    EdtCounterC.Clear;
    EdtCounterS.Clear;

    if  TryStrToFloat(EdtDivProHz.Text,Valor1)
    and TryStrToFloat(EdtCounterHz.Text,Valor2)
    and (Valor1 <> 0)
    and (Valor2 <> 0) then
    begin
        Valor1 := ConvertToPrefixoSI( Valor1, CmbDivProHz.ItemIndex );
        Valor2 := ConvertToPrefixoSI( Valor2, CmbCounterHz.ItemIndex );

        Valor1 :=  Valor1 / Valor2;
        EdtCounterC.Text := FormatFloat('', Valor1 );
        SetBist();

        Valor2 := 1 / Valor2;
        EdtCounterS.Text := SetPrefixoSI( Valor2, CmbCounterS);
    end;

    RdgFormula.OnClick(Sender);

    EdtCounterS.OnChange := EdtCounterSChange;
    EdtCounterC.OnChange := EdtCounterCChange;
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.EdtCounterSChange(Sender: TObject);
var
   Valor1, Valor2 : Extended;
begin

    EdtCounterHz.OnChange := nil;
    EdtCounterC.OnChange := nil;

    EdtCounterC.Clear;
    EdtCounterHz.Clear;

    if  TryStrToFloat(EdtDivProHz.Text,Valor1)
    and TryStrToFloat(EdtCounterS.Text,Valor2)
    and (Valor1 <> 0)
    and (Valor2 <> 0) then
    begin
        Valor1 := ConvertToPrefixoSI( Valor1, CmbDivProHz.ItemIndex );
        Valor2 := ConvertToPrefixoSI( Valor2, CmbCounterS.ItemIndex );

        Valor1 :=  Valor1 * Valor2;
        EdtCounterC.Text := FormatFloat('', Valor1 );
        SetBist();

        Valor2 := 1 / Valor2;
        EdtCounterHZ.Text := SetPrefixoSI( Valor2, CmbCounterHz);
    end;

    RdgFormula.OnClick(Sender);

    EdtCounterHz.OnChange := EdtCounterHzChange;
    EdtCounterC.OnChange := EdtCounterCChange;
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.EdtCounterCChange(Sender: TObject);
var
   Valor1, Valor2 : Extended;
begin
    EdtCounterHz.OnChange := nil;
    EdtCounterS.OnChange := nil;

    EdtCounterHz.Clear;
    EdtCounterS.Clear;

    if  TryStrToFloat(EdtDivProHz.Text,Valor1)
    and TryStrToFloat(EdtCounterC.Text,Valor2)
    and (Valor1 <> 0)
    and (Valor2 <> 0) then
    begin
        SetBist();

        Valor1 := ConvertToPrefixoSI( Valor1, CmbDivProHz.ItemIndex );

        Valor1 :=  Valor1 / Valor2;
        EdtCounterHZ.Text := SetPrefixoSI( Valor1, CmbCounterHz);

        Valor1 := 1 / Valor1;
        EdtCounterS.Text := SetPrefixoSI( Valor1, CmbCounterS);
    end;

    RdgFormula.OnClick(Sender);

    EdtCounterHz.OnChange := EdtCounterHzChange;
    EdtCounterS.OnChange := EdtCounterSChange;
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.RdgFormulaClick(Sender: TObject);
begin
    LblFormulaCPU.Caption := EdtCPUHz.Text + ' ' +ExtractPrefixoSi(CmbCPUHz) + 'Hz';
    LblFormulaHz.Caption := '4 * '+ CmbDivPreD.Text +' * ('+EdtTimerI.Text+' - '+EdtTimerF.Text+') ';

    if GrbDivPro.Enabled then
       LblFormulaHz.Caption := LblFormulaHz.Caption +' * '+ CmbDivProD.Text;

    LblFormulaInvert.Visible := False;
    case RdgFormula.ItemIndex of
        0: begin
               LblFormulaHz.Caption := LblFormulaHz.Caption + ' * ' + EdtCounterC.Text;
               LblFormulaResp.Caption := '= '+ EdtCounterHz.Text+' '+ExtractPrefixoSi(CmbCounterHz)+'Hz';
           end;
        1: begin
               LblFormulaHz.Caption := LblFormulaHz.Caption + ' * ' + EdtCounterC.Text;
               LblFormulaResp.Caption := ') = '+ EdtCounterS.Text +' '+ExtractPrefixoSi(CmbCounterS)+'s';
               LblFormulaInvert.Visible := True;
           end;
        2: begin
               LblFormulaHz.Caption := LblFormulaHz.Caption + ' * ' + EdtCounterHz.Text +' '+ ExtractPrefixoSi(CmbCounterHz)+'Hz';
               LblFormulaResp.Caption := '= '+ EdtCounterC.Text;
           end;
    end;




end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.BtnProcurarClick(Sender: TObject);
type
   TEncontrado = Record
            CPU: Extended;
         DivPre: Word;
           TMRI: LongWord;
           TMRF: LongWord;
         DivPro: Word;
           Calc: Extended;
          Valor: Extended;
    end;
var
    Encontrado: array of TEncontrado;
    DivPreItems: array of Word;
    DivPreI, DivPreM ,DivPreF,
    DivProI, DivProM ,DivProF,
    EncL : Word;
    TimerI, TimerF : LongWord;
    CPU, CPUHZ, DivPre, DivPro, Timer, Calc, Dec, Min : Extended;
begin

    if  TryStrToFloat(EdtCPUHz.Text,CPU)
    and (CPU <> 0) then
    begin
        CPU := ConvertToPrefixoSI( CPU, CmbCPUHz.ItemIndex );
        CPUHZ := CPU / 4;

        if CkbFixDivPre.Checked then
        begin
           DivPreI := CmbDivPreD.ItemIndex;
           DivPreF := CmbDivPreD.ItemIndex;
        end else begin
           DivPreI := 0;
           DivPreF := CmbDivPreD.Items.Count-1;
        end;

        if CkbFixDivPro.Checked then
        begin
           DivProI := CmbDivProD.ItemIndex;
           DivProF := CmbDivProD.ItemIndex;
        end else begin
           DivProI := 0;
           DivProF := CmbDivProD.Items.Count-1;
        end;

        if CkbTimerB.Checked then
           TimerI := 65536
        else
           TimerI := 256;

        case RdgAjuste.ItemIndex of
             0: begin
                    if  TryStrToFloat(EdtCounterHz.Text,Calc) then
                        Calc := ConvertToPrefixoSI( Calc, CmbCounterHz.ItemIndex );
                end;
             1: begin
                    TryStrToFloat(EdtCounterC.Text,Calc);
                end;
        end;

        SetLength(DivPreItems,CmbDivPreD.Items.Count );
        for EncL := 0 to CmbDivPreD.Items.Count-1 do
            DivPreItems[EncL] := StrToInt( CmbDivPreD.Items[EncL] );

        EncL := 0;
        Min := 1;
        for DivPreM := DivPreI to DivPreF do
        begin
            DivPre := CPUHZ / DivPreItems[DivPreM];
            for DivProM := DivProI to DivProF do
            begin
                DivPro := DivPre / DivPreItems[DivProM];
                for TimerF := 0 to TimerI-1 do
                begin
                    Timer := DivPro / (TimerI - TimerF);
                    Timer := Timer / Calc;
                    Dec := Timer - Trunc(Timer);

                    if Dec < Min then
                    begin
                        Min := Dec;
                        EncL := 0;
                        SetLength(Encontrado,EncL+1);
                        Encontrado[0].CPU := CPU;
                        Encontrado[0].DivPre := DivPreItems[DivPreM];
                        Encontrado[0].DivPro := DivPreItems[DivProM];
                        Encontrado[0].TMRI := TimerI;
                        Encontrado[0].TMRF := TimerF;
                        Encontrado[0].Calc := Calc;
                        Encontrado[0].Valor := Timer;
                    end else begin
                        if Dec = Min then
                        begin
                            inc(EncL);
                            SetLength(Encontrado,EncL+1);
                            Encontrado[EncL].CPU := CPU;
                            Encontrado[EncL].DivPre := DivPreItems[DivPreM];
                            Encontrado[EncL].DivPro := DivPreItems[DivProM];
                            Encontrado[EncL].TMRI := TimerI;
                            Encontrado[EncL].TMRF := TimerF;
                            Encontrado[EncL].Calc := Calc;
                            Encontrado[EncL].Valor := Timer;
                        end;//dec = min
                    end;//dec < min
                end;//TimerIndex
            end;//div pro
        end;//div pre

        LtvAjuste.Items.Clear;
        for TimerI := 0 to EncL do
        begin
            LtvAjuste.Items.Add;
            LtvAjuste.Items[TimerI].Caption := FloatToStr( Encontrado[TimerI].CPU );
            LtvAjuste.Items[TimerI].SubItems.Add( IntToStr(Encontrado[TimerI].DivPre) );
            LtvAjuste.Items[TimerI].SubItems.Add( IntToStr(Encontrado[TimerI].DivPro) );
            LtvAjuste.Items[TimerI].SubItems.Add( IntToStr(Encontrado[TimerI].TMRI) );
            LtvAjuste.Items[TimerI].SubItems.Add( IntToStr(Encontrado[TimerI].TMRF) );
            LtvAjuste.Items[TimerI].SubItems.Add( FloatToStr(Encontrado[TimerI].Calc) );
            LtvAjuste.Items[TimerI].SubItems.Add( FloatToStr(Encontrado[TimerI].Valor) );
        end;
        SetLength(Encontrado,0);
   end;//if cpuhz
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.LtvAjusteSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin

   EdtCPUHz.Text := SetPrefixoSI(StrToFloat(Item.Caption), CmbCPUHz);
   CmbDivPreD.ItemIndex := CmbDivPreD.Items.IndexOf(Item.SubItems[0]);
   CmbDivPreD.OnSelect(Sender);

   CmbDivProD.ItemIndex := CmbDivProD.Items.IndexOf(Item.SubItems[1]);
   CmbDivProD.OnSelect(Sender);

   EdtTimerI.Text := Item.SubItems[2];
   EdtTimerF.Text := Item.SubItems[3];

   if RdgAjuste.ItemIndex  = 0 then
   begin
       EdtCounterC.Text := Item.SubItems[5];
       EdtCounterHz.Text := SetPrefixoSI(StrToFloat(Item.SubItems[4]),CmbCounterHz);
   end else begin
       EdtCounterHz.Text := SetPrefixoSI(StrToFloat(Item.SubItems[5]),CmbCounterHz);
       EdtCounterC.Text := Item.SubItems[4];
   end;

end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.BtnCodigoGerClick(Sender: TObject);
var
    Valor : Extended;
    Texto : String;
begin

    RceCodigo.Lines.Clear;

    if CkbCodigoDel.Checked then
    begin
        TryStrToFloat(EdtCPUHz.Text,Valor);
        Valor :=  ConvertToPrefixoSI( Valor, CmbCPUHz.ItemIndex );
        RceCodigo.Lines.Add('#use delay(clock='+IntToStr(Trunc(Valor))+')');
        RceCodigo.Lines.Add('');
        RceCodigo.Lines.Add('');
    end;

    if CkbCodigoInt.Checked then
    begin

        if CkbCodigoDef.Checked then
        begin
            RceCodigo.Lines.Add('//----------------------------------------------------------------------------//');
            RceCodigo.Lines.Add('//defines');
            RceCodigo.Lines.Add('#define TIMER_AJUST '+EdtTimerF.Text);
            RceCodigo.Lines.Add('#define COUNTER_AJUST '+IntToStr(Trunc(StrToFloat(EdtCounterC.Text))));
            RceCodigo.Lines.Add('');
            RceCodigo.Lines.Add('');
        end;

        RceCodigo.Lines.Add('//----------------------------------------------------------------------------//');
        RceCodigo.Lines.Add('//Variaveis');
        if CkbCodigoFlg.Checked then
           RceCodigo.Lines.Add('boolean timer_Flag = FALSE;');

        TryStrToFloat(EdtCounterC.Text,Valor);
        if Valor < 255 then
           Texto := 'int8'
        else if Valor < 65535 then
           Texto := 'int16'
        else if Valor < 4294967295 then
           Texto := 'int32'
        else
           Texto := 'int64';

        Texto := Texto + ' Timer_Count = ';
        if CkbCodigoDef.Checked then
           Texto := Texto + 'COUNTER_AJUST;'
        else
           Texto := Texto + EdtCounterC.Text;
        RceCodigo.Lines.Add(Texto);

        Texto := IntToStr(RdgPICT.ItemIndex);
        RceCodigo.Lines.Add('');
        RceCodigo.Lines.Add('');
        RceCodigo.Lines.Add('//----------------------------------------------------------------------------//');
        RceCodigo.Lines.Add('#int_TIMER'+Texto);
        RceCodigo.Lines.Add('void TIMER'+Texto+'_isr(void)');
        RceCodigo.Lines.Add('{');

        if CkbCodigoDef.Checked then
           RceCodigo.Lines.Add('   set_timer'+Texto+'(TIMER_AJUST);')
        else
           RceCodigo.Lines.Add('   set_timer'+Texto+'('+EdtTimerF.Text+');');

        RceCodigo.Lines.Add('   if (Timer_Count == 0)');
        RceCodigo.Lines.Add('   {');

        if CkbCodigoFlg.Checked then
           RceCodigo.Lines.Add('      timer_Flag = TRUE;')
        else
           RceCodigo.Lines.Add('      // Codigo Aqui.');

        RceCodigo.Lines.Add('      // Interrupção a cada '+EdtCounterS.Text+ExtractPrefixoSi(CmbCounterS)+'s.');

        if CkbCodigoDef.Checked then
           RceCodigo.Lines.Add('      Timer_Count = COUNTER_AJUST;')
        else
           RceCodigo.Lines.Add('      Timer_Count = '+IntToStr(Trunc(StrToFloat(EdtCounterC.Text)))+';');

        RceCodigo.Lines.Add('   }else{');
        RceCodigo.Lines.Add('      Timer_Count--;');
        RceCodigo.Lines.Add('   }');
        RceCodigo.Lines.Add('}');
        RceCodigo.Lines.Add('//----------------------------------------------------------------------------//');

    end;

    if CkbCodigoMan.Checked then
    begin
        RceCodigo.Lines.Add('void MAIN(void)');
        RceCodigo.Lines.Add('{');
        if CkbCodigoSet.Checked then
        begin
            Texto := '   setup_timer_'+IntToStr(RdgPICT.ItemIndex);
            case RdgPICT.ItemIndex of
                 0: begin
                        Texto := Texto + '(RTCC_INTERNAL';
                        if Ckb18F.Checked and not CkbTimerB.Checked then
                           Texto := Texto + '|RTCC_8_BIT';
                        Texto := Texto + '|RTCC_DIV_'+CmbDivPreD.Text+');';
                    end;
             1,3,4: begin
                        Texto := Texto + '(T'+IntToStr(RdgPICT.ItemIndex)+'_INTERNAL|T'+IntToStr(RdgPICT.ItemIndex)+'_DIV_BY_'+CmbDivPreD.Text+');';
                    end;
                2: begin
                        Texto := Texto + '(T2_DIV_BY_'+CmbDivPreD.Text+','+EdtTimerF.Text+','+EdtTimerI.Text+');';
                    end;
            end;
            RceCodigo.Lines.Add(Texto);
        end;

        if CkbCodigoEna.Checked then
        begin
            RceCodigo.Lines.Add('   enable_interrupts(INT_TIMER'+IntToStr(RdgPICT.ItemIndex)+');');
        end;
        RceCodigo.Lines.Add('');
        RceCodigo.Lines.Add('   while(TRUE)');
        RceCodigo.Lines.Add('   {');
        if CkbCodigoFlg.Checked then
        begin
           RceCodigo.Lines.Add('      if (timer_Flag == TRUE)');
           RceCodigo.Lines.Add('      {');
           RceCodigo.Lines.Add('         timer_Flag = FALSE;');
           RceCodigo.Lines.Add('         //Codigo Aqui.');
           RceCodigo.Lines.Add('      }');
        end;
        RceCodigo.Lines.Add('   }');


        RceCodigo.Lines.Add('}');
        RceCodigo.Lines.Add('//----------------------------------------------------------------------------//');
    end;

end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.CkbTimerBClick(Sender: TObject);
begin

    LtvAjuste.Items.Clear;
    if CkbTimerB.Checked then
    begin
        UpdTimerI.Max := 65536;
        UpdTimerF.Max := 65535;
        UpdTimerI.Position := 65536;
        UpdTimerF.Position := 0;
    end else begin
        UpdTimerI.Max := 256;
        UpdTimerF.Max := 255;
        UpdTimerI.Position := 256;
        UpdTimerF.Position := 0;
    end;
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.Ckb18FClick(Sender: TObject);
begin
    LtvAjuste.Items.Clear;
    RdgPICT.Items.Clear;
    RdgPICT.Items.Add('TIMER0');
    RdgPICT.Items.Add('TIMER1');
    RdgPICT.Items.Add('TIMER2');
    RdgPICT.ItemIndex := 0;

    if Ckb18F.Checked then
    begin
       RdgPICT.Items.Add('TIMER3');
       RdgPICT.Items.Add('TIMER4');
    end;

    RdgPICT.OnClick(Sender);
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.RdgPICTClick(Sender: TObject);
begin
    LtvAjuste.Items.Clear;
    CmbDivPreD.Clear;
    GrbDivPro.Enabled := False;
    CmbDivProS.Enabled := False;
    CmbDivProD.Enabled := False;
    CmbDivProHz.Enabled := False;
    EdtTimerI.Enabled := False;
    UpdTimerI.Enabled := False;
    CkbTimerB.Enabled := False;
    CkbFixDivPro.Enabled := False;
    CkbFixDivPro.Checked := True;


    case RdgPICT.ItemIndex of
         0:begin
               CmbDivPreD.Items.Add('1');
               CmbDivPreD.Items.Add('2');
               CmbDivPreD.Items.Add('4');
               CmbDivPreD.Items.Add('8');
               CmbDivPreD.Items.Add('16');
               CmbDivPreD.Items.Add('32');
               CmbDivPreD.Items.Add('64');
               CmbDivPreD.Items.Add('128');
               CmbDivPreD.Items.Add('256');

               if Ckb18F.Checked then
               begin
                  CkbTimerB.Enabled := True;
               end else begin
                  CkbTimerB.Checked := False;
                  CkbTimerB.Enabled := False;
               end;
           end;
     1,3,4:begin
               CmbDivPreD.Items.Add('1');
               CmbDivPreD.Items.Add('2');
               CmbDivPreD.Items.Add('4');
               CmbDivPreD.Items.Add('8');
               CkbTimerB.Checked := True;

           end;
         2:begin
               CmbDivPreD.Items.Add('1');
               CmbDivPreD.Items.Add('4');
               CmbDivPreD.Items.Add('16');
               CkbTimerB.Checked := False;

               GrbDivPro.Enabled := True;
               CmbDivProS.Enabled := True;
               CmbDivProD.Enabled := True;
               CmbDivProHz.Enabled := True;
               CkbFixDivPro.Enabled := True;
               EdtTimerI.Enabled := True;
               UpdTimerI.Enabled := True;
           end;
    end;

    CmbDivPreD.ItemIndex:=0;
    CmbDivPreD.OnSelect(Sender);
    CmbDivProD.ItemIndex:=0;
    CmbDivProD.OnSelect(Sender);

    RdgFormula.OnClick(Sender);

end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.RdgAjusteClick(Sender: TObject);
begin
    case RdgAjuste.ItemIndex of
         0 : begin
                 LtvAjuste.Column[5].Caption := 'Hertz';
                 LtvAjuste.Column[6].Caption := 'Count';
             end;
         1 : begin
                 LtvAjuste.Column[5].Caption := 'Count';
                 LtvAjuste.Column[6].Caption := 'Hertz';
             end;
    end;
    LtvAjuste.Items.Clear;
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.EdtCPUHzKeyPress(Sender: TObject; var Key: Char);
begin
    case Key of
            '.',',' : Key := FormatSettings.DecimalSeparator;
            #8,
            '0'..'9',
            'E','e' : Key := Key;
    else
        Key := #0;
    end;
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.FormKeyPress(Sender: TObject; var Key: Char);
begin
     if Key = #13 then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.CkbCodigoIntClick(Sender: TObject);
begin
    CkbCodigoDef.Enabled := CkbCodigoInt.Checked;
    CkbCodigoFlg.Enabled := CkbCodigoMan.Checked and CkbCodigoInt.Checked;

    if not CkbCodigoInt.Checked then
    begin
       CkbCodigoDef.Checked := False;
       CkbCodigoFlg.Checked := False;
    end;
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.CkbCodigoManClick(Sender: TObject);
begin
    CkbCodigoSet.Enabled := CkbCodigoMan.Checked;
    CkbCodigoEna.Enabled := CkbCodigoMan.Checked;
    CkbCodigoFlg.Enabled := CkbCodigoMan.Checked and CkbCodigoInt.Checked;

    if not CkbCodigoMan.Checked then
    begin
       CkbCodigoSet.Checked := False;
       CkbCodigoEna.Checked := False;
       CkbCodigoFlg.Checked := False;
    end;
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.EdtSobreEClick(Sender: TObject);
begin
    ShellExecute(handle,'open','mailto:francomichel@gmail.com',nil,nil,0);
end;
//----------------------------------------------------------------------------//
procedure TFrmPicCalc.EdtSobreSClick(Sender: TObject);
begin
    ShellExecute(handle,'open','http://franco.freevar.com/',nil,nil,0);
end;
//----------------------------------------------------------------------------//

end.
