/ Inclua aqui as bibliotecas ADVPL necessárias para a construção do executável

User Function Main()
    // Nome do arquivo Python principal que contém a interface
    local target_file := "estoquepoo.prg"

    // Dependências adicionais, como bibliotecas e arquivos
    local build_exe_options := {
        "packages": ["TKINTER", "XLSREAD"],
        "include_files": ["python310.dll", "data/Estoque_com_codigo_de_barras.xlsx"],
    }

    // Defina a base como "Win32GUI" para ocultar a janela de console no Windows
    local base := "Win32GUI"

    // Configuração do executável
    local executables := Executable(target_file, base)

    // Configuração do pacote
    Setup("Controle de Estoque", "1.0", "Programa para controle interno do estoque usando planilha com DB", {"build_exe" : build_exe_options}, {executables})

Return