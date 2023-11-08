/#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'

USER FUNCTION MODELUM()

Local cAlias :="SB1" // tabela de produtos  
Local cTitulo := "Controle de Estoque" // titulo 
Local cFunExc := "U_MODELUMA()" // função de excluir os itens 
Local cFunAlt := "U_MODELUMB()" // função de alterar 
Local cFunCad := "U_MODELUMC()" // função de Cadastrar um produto novo 
Local cFunCad := "U_MODELUMQUANT()" // função de verificar o estoque
Local cFunCad := "U_MODELUMin()" // função de verificar o estoque minimo 

AxCadastro(cAlias, cTitulo, cFunExc, cFunAlt) //aqui eu estou criando a tela e chamando as variasveis 

RETURN

USER Function MODELUMA() //Crei a função de exluir um cadastro 

Local lRet := MsgBox("Tem certeza que dejesa exluir o registro selecionado?", "Confimação", "YESNO")
    
Return lRet

USER function MODELUMB() // Criei a função de alterar o caadastro

Local lRet := .F.
Local cMsg := ""

If INCLUI
    cMsg := "Confirma inclusão do produto?"
else
    cMsg := "Confirmar a alteração do registro"
EndIf

lRet := MsgBox(cMsg, "Confirmação", "YESNO")

RETURN lRet

USER FUNCTION MODELUMC()  // função de cadastrar um novo Produto

    Local lRet := .F.
    Local cMsg := ""

    cMsg := "Confirma cadastro de um novo produto?"

    lRet := MsgBox(cMsg, "Confirmação", "YESNO")

    IF lRet
        // Aqui vocÃª pode adicionar a lÃ³gica de consulta e validaÃ§Ã£o antes do cadastro.
        
    Local cCodigoBarras := InputGet("Informe o Código de Barras do novo produto:")
     
        Query := "SELECT * FROM SB1020 WHERE SB1_COD = '" + cCodigoBarras + "'"
         IF DbUseArea(.T., "cadastro", .F., .T.) // Use a tabela "cadastro" para consulta
             DbSeek(cCodigoBarras)
             IF Found()
                 MsgBox("CÃ³digo de Produto jÃ¡ existe. NÃ£o Ã© possÃ­vel cadastrar duplicatas.", "Erro", "ERROR")
             ELSE
                 // Aqui vocÃª pode continuar com a lÃ³gica de cadastro, inserindo o novo registro na tabela "cadastro".
             ENDIF
             DbCloseArea()
         ELSE
             MsgBox("Erro ao acessar a tabela de cadastro.", "Erro", "ERROR")
         ENDIF
        
        // Certifique-se de ajustar a lÃ³gica de consulta e cadastro de acordo com a estrutura da sua tabela "cadastro" e suas necessidades.

        MsgBox("Cadastro realizado com sucesso!", "Sucesso", "INFO")
    ENDIF

    RETURN lRet

    USER FUNCTION MODELUMQUANT() // função de verificar estoque e atualizar a qunatidade 

     LOCAL lRet := .F.
    LOCAL cMsg := ""

    IF INCLUI
        cMsg := "Confirma atualização das quantidades?"
    ELSE
        cMsg := "Confirma a alteração das quantidades?"
    ENDIF

    lRet := MsgBox(cMsg, "Confirmação", "YESNO")

    IF lRet
        // Aqui vocÃª pode adicionar a lÃ³gica para atualizar as quantidades mÃ­nimas e atuais do produto.
        LOCAL nQuantidade := InputGet("Informe a quantidade a ser adicionada/subtraida: ")
        LOCAL nQuantidadeMinima := InputGet("Informe a nova quantidade mi­nima:")

        IF nQuantidade >= 0
            // Atualiza quantidade atual e entrada de estoque
            // (Aqui vocÃª deve substituir 'nQuantidade' pelo campo adequado na tabela "cadastro".)
            nQuantidadeAtual := nQuantidadeAtual + nQuantidade
            nEntradaEstoque := nEntradaEstoque + nQuantidade
        ELSE
            // Atualiza quantidade atual e saÃ­da de estoque
            // (Aqui vocÃª deve substituir 'nQuantidade' pelo campo adequado na tabela "cadastro".)
            nQuantidadeAtual := nQuantidadeAtual + nQuantidade
            nSaidaEstoque := nSaidaEstoque + Abs(nQuantidade)
        ENDIF

        // Atualiza a quantidade mÃ­nima
        // (Aqui vocÃª deve substituir 'nQuantidadeMinima' pelo campo adequado na tabela "cadastro".)
        nQuantidadeMinima := nQuantidadeMinima

        IF nQuantidadeAtual <= nQuantidadeMinima
            MsgBox("Estoque baixo para o produto", "Aviso", "INFO")
        ENDIF

        MsgBox("Quantidades atualizadas com sucesso!", "Sucesso", "INFO")
    ENDIF


    RETURN lRet

    USER FUNCTION U_MODELUMin()

    LOCAL lRet := .F.
    LOCAL cMsg := ""



    RETURN


