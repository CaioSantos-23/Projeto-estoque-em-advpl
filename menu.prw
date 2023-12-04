#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'




// Fun��o principal que cria a interface gr�fica
User Function MENU()
   // Declara��o de vari�veis para armazenar informa��es do formul�rio
   Local cCod := space(6) // e  o input para incluir o c�digo do produto
   Local cQuantAT := SPACE(20) // e o input para incluir a quantidade

   // Definindo vari�veis privadas para manipular objetos de tela
   SetPrvt("oDlg1","oCod","oQuantAT", "oSalvar", "oVerific", "oVerifMin", "oCad", "oDelete")

   // TELA PRINCIPAL
   oDlg1 := MSDialog():New(094,225,500,400,"Controle de Estoque",,,.F.,,,,,,.T.,,,.T.)

   // NOME DOS CAMPOS
  oCod  := TSay():New(012,016,{||"C�digo do Produto"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
  oQuantAT := TSay():New(032,016,{||"Quantidade Atual"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,050,008)

   // GETS PARA RECEP��O DE VALORES
   oCod  := TGet():New(012,76,{|u| If(PCount()>0,cCod:=u,cCod)},oDlg1,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCod",,)
   oQuantAT := TGet():New(032,76,{|u| If(PCount()>0,cQuantAT:=u,cQuantAT)},oDlg1,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cQuantAT",,)


   // BOT�ES DE INTERA��O
   oSalvar := TButton():New(080,016,"Salvar",oDlg1,{|u| fInclui(cCod,cQuantAT),cCod := Space(6),cQuantAT := Space(20) },037,012,,,,.T.,,"",,,,.F.)
   oVerific := TButton():New(100,016,"Verificar estoque",oDlg1,{|u| fVerifEs(cCod)},048,012,,,,.T.,,"",,,,.F.)
   oVerifMin := TButton():New(120,016,"Verificar estoque minimo",oDlg1,{|u| fverifMin(cCod)},065,012,,,,.T.,,"",,,,.F.)
   oCad := TButton():New(140,016,"Cadastrar Produto",oDlg1,{|u| fcad()},053,012,,,,.T.,,"",,,,.F.)
   oDelete := TButton():New(160,016,"Excluir", oDlg1, {|u| fExclCod(cCod)}, 037,012,,,,.T.,,"",,,,.F.)
   
   // Ativa��o da tela principal
   oDlg1:Activate(,,,.T.)

Return

// Fun��o para incluir dados
Static Function fInclui(cCod, cQuantAT)
   Local nQuantidade := Val(cQuantAT) // estou convertendo cQuanat em um valor n�merico

   // Verificando se  o usuario deseja subtrair
   if SubStr(cQuantAT, 1, 1) == "-"
      nQuantidade := -nQuantidade
   endif 

   // Atualiza o estoque
   dbSelectArea("ES2") // Estou selecionando a tabela ES1

   if !ES2->(DbSeek(cCod)) // Se o c�digo n�o existir, mostra uma mensagem
      MsgInfo("Produto n�o encontrado.")
   else
      // Atualiza a quantidade no estoque
      RecLock("ES2", .F.)  
      ES2->ES2_QUANTA := ES2->ES2_QUANTA + nQuantidade
      MsUnlock()

      MsgInfo("Estoque Atualizado com sucesso.")
   endif

Return

// Fun��o para verificar estoque
Static Function fVerifEs(cCod) // OK
  
      //Selecionando a tabela 
      DbSelectArea("ES2")
      ES2->(DbSetOrder(1))
      ES2->(DbGoTop())
      
      // Verifique se o registro com o c�digo do produto existe
      if ES2->(DbSeek(xFilial("ES2")+cCod))
         MsgInfo("CODIGO ->" + ES2->ES2_COD + ;
                  " Descri��o ->" + ES2->ES2_DESC + ;
                  " Quantidade Atual ->" + ES2->ES2_QUANTA + ;
                  " Quantidade m�nima ->" + ES2->ES2_QUANTM)
      else
         MsgInfo("Registro com o c�digo " + cCod + " n�o encontrado.")
      endif

   // POSICIONA NO PRIMEIRO REGISTRO
   //if !ES2->(DbGoTop())
     // Alert("N�O H� DADOS PARA EXIBIR!","ATEN��O!")
  
   //else
      //do while !ES2->(EOF())
         
         // Move para o pr�ximo registro
        // ES2->(DbSkip())
     // enddo

   //endif

Return

// Fun��o para mostrar todos os dados que est�o abaixo do estoque minimo
Static Function fverifMin(cCod) //OK
   
   dbSelectArea("ES2")
   If ES2->(dbseek(xFilial("ES2")+cCod))

   if Val(ES2->ES2_QUANTA) < Val(ES2->ES2_QUANTM)
         MsgInfo("Estes produtos est�o abaixo da quantidade m�nima:" + ;
                  "C�digo: " + ES2->ES2_COD + ;
                  "Descri��o: " + ES2->ES2_DESC + ;
                  "Quantidade Atual: " + ES2->ES2_QUANTA + ;
                  "Quantidade M�nima: " + es2->ES2_QUANTM)
   else
      MsgInfo("N�o h� produto Abaixo do estoque minimo")
   endif
      MsgInfo("N�o h� produtos cadastrados")
      
   //else
      //alert('nao encontrei')
   EndIF
Return

// Fun��o para cadastrar um produto novo
Static Function fcad()  //OK

   U_MENUCAD()

Return

// Fun��o para excluir um registro com base no c�digo do produto
Static Function fExclCod(cCod)
   
   
   dbSelectArea("ES2")

      // Verifique se o registro com o c�digo do produto existe
      if ES2->(dbSeek(xFilial('ES2')+cCod))
         RecLock("ES2", .F.)
            ES2->(DbDelete())
         ES2->(MsUnlock())
         MsgInfo("Registro com o c�digo " + cCod + " foi exclu�do.")
      else
         MsgInfo("Registro com o c�digo " + cCod + " n�o encontrado.")
      endif
   
   
Return

