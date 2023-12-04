#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'


// Função principal que cria a interface gráfica
User Function MENUCAD()
    // Declaração de variáveis para armazenar informações do formulário
    Local cCod := Space(6) // e  o input para incluir o código do produto
    Local cDesc := Space(10) // e o input para incluir a descrição
    Local nQuantAT := Space(6) // e o input para incluir a quantidade atual
    Local nQuantMIN := Space(6) // e o input para incluir a quantidade mínima
    Local cUNID := Space(3) // e o input para incluir a unidade de medida
    Local cARMAZ := Space(6) // e o input para incluir o Armazém onde está o produto

    // Definindo variáveis privadas para manipular objetos de tela
    SetPrvt("oDlg2","cCod","nQuantAT","cDesc","nQuantMIN","cUNID", "cARMAZ", "cSalvar")

// TELA de Cadastro
    oDlg2 := MSDialog():New(094,225,600,500,"Cadastro de produto",,,.F.,,,,,,.T.,,,.T.)

// RÓTULOS DOS CAMPOS
    TSay():New(040,088,{||"Código do Produto"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
    TSay():New(068,088,{||"Quantidade Atual"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,055,008)
    TSay():New(096,088,{||"Descrição"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
    TSay():New(124,088,{||"Quantidade Mínima"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
    TSay():New(150,088,{||"Unidade de Medida"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,055,008)
    TSay():New(180,088,{||"Armazém"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)

    // CAMPOS DE ENTRADA
    cCod  := TGet():New(040,160,{|u| If(PCount()>0,cCod:=u,cCod)},oDlg2,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCod",,)
    nQuantAT := TGet():New(068,160,{|u| If(PCount()>0,nQuantAT:=u,nQuantAT)},oDlg2,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cQuantAT",,)
    cDesc := TGet():New(096,160,{|u| If(PCount()>0,cDesc:=u,cDesc)},oDlg2,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cDesc",,)
    nQuantMIN := TGet():New(124,160,{|u| If(PCount()>0,nQuantMIN:=u,nQuantMIN)},oDlg2,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cQuantMIN",,)
    cUNID := TGet():New(150,160,{|u| If(PCount()>0,cUNID:=u,cUNID)},oDlg2,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cUNID",,)
    cARMAZ := TGet():New(180,160,{|u| If(PCount()>0,cARMAZ:=u,cARMAZ)},oDlg2,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cARMAZ",,)

    // BOTÃO DE INTERAÇÃO
    cSalvar := TButton():New(208,160,"Salvar",oDlg2,{|u| fsalvar(cCod, nQuantAT, cDesc, nQuantMIN, cUNID, cARMAZ), cCod := Space(6), nQuantAT := Space(6), cDesc := Space(10), nQuantMIN := Space(6), cUNID := Space(3), cARMAZ := Space(6)  },037,012,,,,.T.,,"",,,,.F.)


    // Ativação da janela principal
    oDlg2:Activate(,,,.T.)

Return

// Função para incluir dados
Static Function fsalvar(cCod, nQuantAT, cDesc, nQuantMIN, cUNID, cARMAZ)
   
    dbSelectArea("ES2")

   if EMPTY(Alltrim(cCod)) .OR. EMPTY(Alltrim(nQuantAT)) .OR. EMPTY(Alltrim(cDesc)) .OR. EMPTY(Alltrim(nQuantMIN)) .OR. EMPTY(Alltrim(cUNID)) .OR. EMPTY(Alltrim(cARMAZ))
        Alert("Existem campos vazios, Favor preencher!")
    Else
        //GRAVA REGISTRO NO BANCO DE DADOS	
        dbSelectArea("ES2")
        ES2->(DBGOBOTTOM())
        RecLock("ES2",.T.)  
        ES2->ES2_COD    := ALLTRIM(cCod)
        ES2->ES2_DESC   := ALLTRIM(cDesc)
        ES2->ES2_QUANTA := Val(nQuantAT)
        ES2->ES2_QUANTM := Val(nQuantMIN)
        ES2->ES2_UND    := ALLTRIM(cUNID)
        ES2->ES2_ARMAZ  := ALLTRIM(cARMAZ)
        MsUnlock()

        MsgInfo("Inclusão concluída com sucesso!","AVISO!")
    ENDIF

Return

