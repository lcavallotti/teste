;                         BOTÃO E LED - EXERCÍCIO 1
;                   ENGENHARIA ELÉTRICA ELETRÔNICA - AEDB 
;             DESENVOLVIDO POR LUCAS CAVALLOTTI CARVALHO - 13270064
;VERSÃO: 1.0                                                    DATA: 14/03/16
;______________________________________________________________________________    
;O CIRCUITO EXECUTARÁ A FUNÇÃO DE ACENDER O LED AO SER ACIONADO O BOTÃO DE
;CONTROLE.
;------------------------------------------------------------------------------    
;                         MODELO PARA PIC 16F628A
;
;------------------------------------------------------------------------------
;                          ARQUIVOS DE DEFINIÇÃO
    #INCLUDE<P16F628A.INC>              ;ARQUIVO PADRÃO MICROSHIP PARA 16F628A
    __CONFIG  _BOREN_ON & _CP_OFF & _PWRTE_ON & _WDT_OFF & _LVP_OFF & _MCLRE_ON & _XT_OSC

;------------------------------------------------------------------------------
;                           PAGINA DE MEMORIA
;DEFINIÇÃO DE COMANDOS DE USUÁRIOS PARA ALTERAÇÃO DA PÁGINA DE MEMÓRIA
    #DEFINE    BANK0    BCF  STATUS,RP0 ;SETA BANK 0 DE MEMÓRIA
    #DEFINE    BANK1    BSF  STATUS,RP0 ;SETA BANK 1 DE MEMÓRIA

;------------------------------------------------------------------------------
;                              VARIÁVEIS
;DEFINIÇÃO DOS NOMES E ENDEREÇOS DE TODAS AS VARIÁVEIS UTILIZADAS PELO SISTEMA
    CBLOCK    0x20                      ;ENDEREÇO INICIAL DA MEMÓRIA DE USUÁRIO
    ENDC                                ;FIM DO BLOCO DE MEMÓRIA

;------------------------------------------------------------------------------
;                            FLAGS INTERNOS
;DEFINIÇÃO DE TODOS OS FLAGS UTILIZADOS PELO SISTEMA

;------------------------------------------------------------------------------    
;                              CONSTANTES
;DEFINIÇÃO DE TODAS AS CONSTANTES UTILIZADOS PELO SISTEMA
   
;------------------------------------------------------------------------------    
;                               ENTRADAS
#DEFINE    BOTAO   PORTA,RA2               ;PORTA DO BOTÃO
                        			     ; 0 - PRESSIONADO
			 						     ; 1 - LIBERADO
  
;------------------------------------------------------------------------------    
;                               SAÍDAS
#DEFINE    LED   PORTB,RB0                 ;PORTA DO LED
                          				 ; 0 - APAGADO
			 							  ; 1 - ACESO
    
;------------------------------------------------------------------------------    
;                            VETOR DE RESET
    ORG    0x00                         ;ENDEREÇO INICIAL DE PROCESSAMENTO
    GOTO    INICIO
    
;------------------------------------------------------------------------------
;                         INICIO DA INTERRUPÇÃO
;ENDEREÇO DE DESVIO DAS INTERRUPÇÕES. A PRIMEIRA TAREFA É SALVAR OS
;VALORS DE "W" E "STATUS" PARA RECUPERAÇÃO FUTURA
    ORG      0x04                       ;ENDEREÇO INICIAL DA INTERRUPÇÃO
    RETFIE                             ;RETORNA DA INTERRUPÇÃO
    
;------------------------------------------------------------------------------
;                         ROTINA DE INTERRUPÇÃO
;AQUI SERÃO ESCRITAS AS ROTINAS DE RECONHECIMENTO E TRATAMENTO DAS
;INTERRUPÇÕES
    
;------------------------------------------------------------------------------
;                     ROTINA DE SAÍDA DA INTERRUPÇÃO
;OS VALORES DE "W" E "STATUS" DEVEM SER RECUPERADOS ANTES DE 
;RETORNAR DA INTERRUPÇÃO
    
;------------------------------------------------------------------------------
;                         ROTINAS E SUBROTINAS
;CADA ROTINA OU SUBROTINA DEVE POSSUIR A DESCRIÇÃO DE FUNCIONAMENTO
;E UM NOME COERENTE ÀS SUAS FUNÇÕES
    
;CORPO DA ROTINA

;------------------------------------------------------------------------------
;                           INICIO DO PROGRAMA
INICIO
   CLRF    PORTA                        ;LIMPA O PORTA
   CLRF    PORTB                        ; LIMPA O PORTB
   BANK1                                ;ALTERA PARA O BANCO 1
   MOVLW    B'00000100'
   MOVWF    TRISA                       ;DEFINE ENTRADAS E SAÍDAS PARA O PORTA
   MOVLW    B'00000000'
   MOVWF    TRISB                       ;DEFINE ENTRADAS E SAÍDAS PARA O PORTB
   MOVLW    B'10000000'
   MOVLW    B'10000100'
   MOVWF    OPTION_REG                  ;PRESCALER 1:2 NO TMR0
                                        ;PULL-UPS DESABILITADOS
					;AS DEMAIS CONFG. SÃO IRRELEVANTES
   MOVLW    B'00000000'
   MOVWF    INTCON                      ;DEFINE OPÇÕES DE INTERRUPÇÕES
   BANK0                                ;RETORNA PARA O BANCO
   MOVLW    B'00000111'
   MOVWF    CMCON                       ;DEFINE MODO DE OPERAÇÃO DO COMP. ANALG.
   
;------------------------------------------------------------------------------
;                      INICIALIZAÇÃO DAS VARIÁVEIS
   
;------------------------------------------------------------------------------
;                            ROTINA PRINCIPAL
MAIN
   BTFSS    BOTAO                       ;O BOTÃO ESTÁ PRESSIONADO?
   GOTO     BOTAO_LIB                   ;NÃO ENTÃO TRATA BOTÃO LIBERADO
   GOTO     BOTAO_PRES                  ;SIM ENTÃO TRATA BOTÃO PRESSIONADO

BOTAO_LIB
   BCF      LED                         ;APAGA O LED
   GOTO     MAIN                        ;RETORNA AO LOOP PRINCIPAL
   
BOTAO_PRES
   BSF      LED                         ;ACENDE O LED
   GOTO     MAIN                        ;RETORNA AO LOOP PRINCIPAL
   
;-----------------------------------------------------------------------------
;                             FIM DO PROGRAMA
   END
    