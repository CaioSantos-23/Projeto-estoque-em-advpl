#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/* Defini��o de uma tela de Cadastro */

// Fun��o principal que cria a interface gr�fica
User Function MENUCAD()
    // Declara��o de vari�veis para armazenar informa��es do formul�rio
    Local cCod := Space(6) // e  o input para incluir o c�digo do produto
    Local cDesc := Space(10) // e o input para incluir a descri��o
    Local cQuantAT := Space(6) // e o input para incluir a quantidade atual
    Local cQuantMIN := Space(6) // e o input para incluir a quantidade m�nima
    Local cUNID := Space(3) // e o input para incluir a unidade de medida
    Local cARMAZ := Space(6) // e o input para incluir o Armaz�m onde est� o produto

    // Definindo vari�veis privadas para manipular objetos de tela
    SetPrvt("oDlg2","cCod","cQuantAT","cDesc","cQuantMIN","cUNID", "cARMAZ", "cSalvar")

// TELA de Cadastro
    oDlg2 := MSDialog():New(094,225,600,500,"Cadastro de produto",,,.F.,,,,,,.T.,,,.T.)

// R�TULOS DOS CAMPOS
    TSay():New(040,088,{||"C�digo do Produto"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
    TSay():New(068,088,{||"Quantidade Atual"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,055,008)
    TSay():New(096,088,{||"Descri��o"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
    TSay():New(124,088,{||"Quantidade M�nima"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
    TSay():New(150,088,{||"Unidade de Medida"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,055,008)
    TSay():New(180,088,{||"Armaz�m"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)

    // CAMPOS DE ENTRADA
    cCod  := TGet():New(040,160,{|u| If(PCount()>0,cCod:=u,cCod)},oDlg2,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCod",,)
    cQuantAT := TGet():New(068,160,{|u| If(PCount()>0,cQuantAT:=u,cQuantAT)},oDlg2,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cQuantAT",,)
    cDesc := TGet():New(096,160,{|u| If(PCount()>0,cDesc:=u,cDesc)},oDlg2,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cDesc",,)
    cQuantMIN := TGet():New(124,160,{|u| If(PCount()>0,cQuantMIN:=u,cQuantMIN)},oDlg2,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cQuantMIN",,)
    cUNID := TGet():New(150,160,{|u| If(PCount()>0,cUNID:=u,cUNID)},oDlg2,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cUNID",,)
    cARMAZ := TGet():New(180,160,{|u| If(PCount()>0,cARMAZ:=u,cARMAZ)},oDlg2,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cARMAZ",,)

    // BOT�O DE INTERA��O
    cSalvar := TButton():New(208,160,"Salvar",oDlg2,{|u| fsalvar(cCod, cQuantAT, cDesc, cQuantMIN, cUNID, cARMAZ), cCod := Space(6), cQuantAT := Space(6), cDesc := Space(10), cQuantMIN := Space(6), cUNID := Space(3), cARMAZ := Space(6)  },037,012,,,,.T.,,"",,,,.F.)


    // Ativa��o da janela principal
    oDlg2:Activate(,,,.T.)

Return

// Fun��o para incluir dados
Static Function fsalvar(cCod, cQuantAT, cDesc, cQuantMIN, cUNID, cARMAZ)
   
    dbSelectArea("ES2")

   if EMPTY(Alltrim(cCod)) .OR. EMPTY(Alltrim(cQuantAT)) .OR. EMPTY(Alltrim(cDesc)) .OR. EMPTY(Alltrim(cQuantMIN)) .OR. EMPTY(Alltrim(cUNID)) .OR. EMPTY(Alltrim(cARMAZ))
        Alert("Existem campos vazios, Favor preencher!")
    Else
        //GRAVA REGISTRO NO BANCO DE DADOS	
        dbSelectArea("ES2")
        ES2->(DBGOBOTTOM())
        RecLock("ES2",.T.)  
        ES2->ES2_COD    := cCod
        ES2->ES2_DESC   := cDesc
        ES2->ES2_QUANTA := cQuantAT
        ES2->ES2_QUANTM := cQuantMIN
        ES2->ES2_UND    := cUNID
        ES2->ES2_ARMAZ  := cARMAZ
        MsUnlock()

        MsgInfo("Inclus�o conclu�da com sucesso!","AVISO!")
    ENDIF

Return

