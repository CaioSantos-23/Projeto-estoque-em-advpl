#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'


// Função principal que cria a interface gráfica
User Function MENU()
   // Declaração de variáveis para armazenar informações do formulário
   Local cCod := SPACE( 6 ) // e  o input para incluir o código do produto
   Local nQuantAT  := SPACE( 6 )// e o input para incluir a quantidade

   // Definindo variáveis privadas para manipular objetos de tela
   SetPrvt("oDlg1","oCod","oQuantAT", "oSalvar", "oVerific", "oVerifMin", "oCad", "oDelete")

   // TELA PRINCIPAL
   oDlg1 := MSDialog():New(094,225,500,400,"Controle de Estoque",,,.F.,,,,,,.T.,,,.T.)

   // NOME DOS CAMPOS
  oCod  := TSay():New(012,016,{||"Código do Produto"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,060,008)
  oQuantAT := TSay():New(032,016,{||"Quantidade Atual"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,050,008)

   // GETS PARA RECEPÇÃO DE VALORES
   oCod  := TGet():New(012,76,{|u| If(PCount()>0,cCod:=u,cCod)},oDlg1,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCod",,)
   oQuantAT := TGet():New(032,76,{|u| If(PCount()>0,nQuantAT:=u,nQuantAT)},oDlg1,060,010,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cQuantAT",,)


   // BOTÕES DE INTERAÇÃO
   oSalvar := TButton():New(080,016,"Salvar",oDlg1,{|u| fInclui(cCod,nQuantAT)},037,012,,,,.T.,,"",,,,.F.)
   oVerific := TButton():New(100,016,"Verificar estoque",oDlg1,{|u| fVerifEs(cCod)},048,012,,,,.T.,,"",,,,.F.)
   oVerifMin := TButton():New(120,016,"Verificar estoque minimo",oDlg1,{|u| fverifMin(cCod)},065,012,,,,.T.,,"",,,,.F.)
   oCad := TButton():New(140,016,"Cadastrar Produto",oDlg1,{|u| fcad()},053,012,,,,.T.,,"",,,,.F.)
   oDelete := TButton():New(160,016,"Excluir", oDlg1, {|u| fExclCod(cCod)}, 037,012,,,,.T.,,"",,,,.F.)
   
   // Ativação da tela principal
   oDlg1:Activate(,,,.T.)

Return
 
// Função para incluir dados
Static Function fInclui(cCod, nQuantAT) //OK
   Local nQuantidade := Val(nQuantAT) // Convertendo nQuantAT em um valor numérico

   // Atualiza o estoque
   DbSelectArea("ES2")
   ES2->(DbSetOrder(1))

   if !ES2->(DbSeek(xFilial("ES2") + cCod))
      MsgInfo("Produto não encontrado.")
   else
      // Verificando se o usuário deseja subtrair
      if nQuantidade < 0
         // Lógica para subtrair a quantidade
         RecLock("ES2", .F.)
         ES2->ES2_QUANTA := ES2->ES2_QUANTA + nQuantidade
         MsUnlock()
         MsgInfo("Estoque subtraído com sucesso.")
      else
         // Lógica para adicionar a quantidade
         RecLock("ES2", .F.)  
         ES2->ES2_QUANTA := ES2->ES2_QUANTA + nQuantidade
         MsUnlock()
         MsgInfo("Estoque atualizado com sucesso.")
      endif
   endif

Return

// Função para verificar estoque
Static Function fVerifEs(cCod) // OK
  
      //Selecionando a tabela 
      DbSelectArea("ES2")
      ES2->(DbSetOrder(1))
      ES2->(DbGoTop())
      
      // Verifique se o registro com o código do produto existe
      if ES2->(DbSeek(xFilial("ES2")+cCod))
         MsgInfo("CODIGO ->" + ES2->ES2_COD + ;
                  " Descrição ->" + ES2->ES2_DESC + ;
                  " Quantidade Atual ->" + Alltrim(Str(ES2->ES2_QUANTA)) + ;
                  " Quantidade mínima ->" + Alltrim(Str(ES2->ES2_QUANTM)))
      else
         MsgInfo("Registro com o código " + cCod + " não encontrado.")
      endif


Return

// Função para mostrar todos os dados que estão abaixo do estoque minimo
Static Function fverifMin(cCod) //OK
   
   dbSelectArea("ES2")
   If ES2->(dbseek(xFilial("ES2")+cCod))

   if (ES2->ES2_QUANTA) < (ES2->ES2_QUANTM)
         MsgInfo("Estes produtos estão abaixo da quantidade mínima: " + ;
                  "Código: " + ES2->ES2_COD + ;
                  "Descrição: " + ES2->ES2_DESC + ;
                  "Quantidade Atual: " + Alltrim(Str(ES2->ES2_QUANTA)) + ;
                  "Quantidade Mínima: " + Alltrim(Str(ES2->ES2_QUANTM)))
   else
      MsgInfo("Não há produto Abaixo do estoque minimo")
   
   endif
     
      
   EndIF
Return

// Função para cadastrar um produto novo
Static Function fcad()  //OK

   U_MENUCAD()

Return

// Função para excluir um registro com base no código do produto
Static Function fExclCod(cCod)  // OK
   
   
   dbSelectArea("ES2")

      // Verifique se o registro com o código do produto existe
      if ES2->(dbSeek(xFilial('ES2')+cCod))
         RecLock("ES2", .F.)
            ES2->(DbDelete())
         ES2->(MsUnlock())
         MsgInfo("Registro com o código " + cCod + " foi excluído.")
      else
         MsgInfo("Registro com o código " + cCod + " não encontrado.")
      endif
   
   
Return

