;                         BOT�O E LED - EXERC�CIO 1
;                   ENGENHARIA EL�TRICA ELETR�NICA - AEDB 
;             DESENVOLVIDO POR LUCAS CAVALLOTTI CARVALHO - 13270064
;VERS�O: 1.0                                                    DATA: 14/03/16
;______________________________________________________________________________    
;O CIRCUITO EXECUTAR� A FUN��O DE ACENDER O LED AO SER ACIONADO O BOT�O DE
;CONTROLE.
;------------------------------------------------------------------------------    
;                         MODELO PARA PIC 16F628A
;
;------------------------------------------------------------------------------
;                          ARQUIVOS DE DEFINI��O
    #INCLUDE<P16F628A.INC>              ;ARQUIVO PADR�O MICROSHIP PARA 16F628A
    __CONFIG  _BOREN_ON & _CP_OFF & _PWRTE_ON & _WDT_OFF & _LVP_OFF & _MCLRE_ON & _XT_OSC

;------------------------------------------------------------------------------
;                           PAGINA DE MEMORIA
;DEFINI��O DE COMANDOS DE USU�RIOS PARA ALTERA��O DA P�GINA DE MEM�RIA
    #DEFINE    BANK0    BCF  STATUS,RP0 ;SETA BANK 0 DE MEM�RIA
    #DEFINE    BANK1    BSF  STATUS,RP0 ;SETA BANK 1 DE MEM�RIA

;------------------------------------------------------------------------------
;                              VARI�VEIS
;DEFINI��O DOS NOMES E ENDERE�OS DE TODAS AS VARI�VEIS UTILIZADAS PELO SISTEMA
    CBLOCK    0x20                      ;ENDERE�O INICIAL DA MEM�RIA DE USU�RIO
    ENDC                                ;FIM DO BLOCO DE MEM�RIA

;------------------------------------------------------------------------------
;                            FLAGS INTERNOS
;DEFINI��O DE TODOS OS FLAGS UTILIZADOS PELO SISTEMA

;------------------------------------------------------------------------------    
;                              CONSTANTES
;DEFINI��O DE TODAS AS CONSTANTES UTILIZADOS PELO SISTEMA
   
;------------------------------------------------------------------------------    
;                               ENTRADAS
#DEFINE    BOTAO   PORTA,RA2               ;PORTA DO BOT�O
                        			     ; 0 - PRESSIONADO
			 						     ; 1 - LIBERADO
  
;------------------------------------------------------------------------------    
;                               SA�DAS
#DEFINE    LED   PORTB,RB0                 ;PORTA DO LED
                          				 ; 0 - APAGADO
			 							  ; 1 - ACESO
    
;------------------------------------------------------------------------------    
;                            VETOR DE RESET
    ORG    0x00                         ;ENDERE�O INICIAL DE PROCESSAMENTO
    GOTO    INICIO
    
;------------------------------------------------------------------------------
;                         INICIO DA INTERRUP��O
;ENDERE�O DE DESVIO DAS INTERRUP��ES. A PRIMEIRA TAREFA � SALVAR OS
;VALORS DE "W" E "STATUS" PARA RECUPERA��O FUTURA
    ORG      0x04                       ;ENDERE�O INICIAL DA INTERRUP��O
    RETFIE                             ;RETORNA DA INTERRUP��O
    
;------------------------------------------------------------------------------
;                         ROTINA DE INTERRUP��O
;AQUI SER�O ESCRITAS AS ROTINAS DE RECONHECIMENTO E TRATAMENTO DAS
;INTERRUP��ES
    
;------------------------------------------------------------------------------
;                     ROTINA DE SA�DA DA INTERRUP��O
;OS VALORES DE "W" E "STATUS" DEVEM SER RECUPERADOS ANTES DE 
;RETORNAR DA INTERRUP��O
    
;------------------------------------------------------------------------------
;                         ROTINAS E SUBROTINAS
;CADA ROTINA OU SUBROTINA DEVE POSSUIR A DESCRI��O DE FUNCIONAMENTO
;E UM NOME COERENTE �S SUAS FUN��ES
    
;CORPO DA ROTINA

;------------------------------------------------------------------------------
;                           INICIO DO PROGRAMA
INICIO
   CLRF    PORTA                        ;LIMPA O PORTA
   CLRF    PORTB                        ; LIMPA O PORTB
   BANK1                                ;ALTERA PARA O BANCO 1
   MOVLW    B'00000100'
   MOVWF    TRISA                       ;DEFINE ENTRADAS E SA�DAS PARA O PORTA
   MOVLW    B'00000000'
   MOVWF    TRISB                       ;DEFINE ENTRADAS E SA�DAS PARA O PORTB
   MOVLW    B'10000000'
   MOVLW    B'10000100'
   MOVWF    OPTION_REG                  ;PRESCALER 1:2 NO TMR0
                                        ;PULL-UPS DESABILITADOS
					;AS DEMAIS CONFG. S�O IRRELEVANTES
   MOVLW    B'00000000'
   MOVWF    INTCON                      ;DEFINE OP��ES DE INTERRUP��ES
   BANK0                                ;RETORNA PARA O BANCO
   MOVLW    B'00000111'
   MOVWF    CMCON                       ;DEFINE MODO DE OPERA��O DO COMP. ANALG.
   
;------------------------------------------------------------------------------
;                      INICIALIZA��O DAS VARI�VEIS
   
;------------------------------------------------------------------------------
;                            ROTINA PRINCIPAL
MAIN
   BTFSS    BOTAO                       ;O BOT�O EST� PRESSIONADO?
   GOTO     BOTAO_LIB                   ;N�O ENT�O TRATA BOT�O LIBERADO
   GOTO     BOTAO_PRES                  ;SIM ENT�O TRATA BOT�O PRESSIONADO

BOTAO_LIB
   BCF      LED                         ;APAGA O LED
   GOTO     MAIN                        ;RETORNA AO LOOP PRINCIPAL
   
BOTAO_PRES
   BSF      LED                         ;ACENDE O LED
   GOTO     MAIN                        ;RETORNA AO LOOP PRINCIPAL
   
;-----------------------------------------------------------------------------
;                             FIM DO PROGRAMA
   END
    