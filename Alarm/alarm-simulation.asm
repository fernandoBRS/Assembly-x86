$mod51
$title(PROJETO ALARME - USJT)

; RESETANDO P0 E P2 AO INICIAR
MOV P0, #000H
MOV P2, #0FFH

; FUNCOES:
; INICIO - INICIA P1 E P3 E VERIFICA SE O USUÁRIO PRESSIONOU O BOTÃO PARA PROSSEGUIR
; INTERVALO - ACIONA O LED 3.6E INICIA A CONTAGEM DE 10s
; ATRASO10 - VERIFICA SE A CHAVE DE EMERGÊNCIA FOI ACIONADA, DESLIGA O LED 3.6 E INICIA O ESTADO DE MONITORAMENTO
; MONITORACAO - AJUSTA O ATRASO EM R3, LIGA OS LEDs 3.4 e 3.5, VERIFICA SE O ALARME FOI DESLIGADO E SE O SENSOR FOI ACIONADO
; ATRASO05 - GERANDO ATRASO DE 0.5s PARA OS LEDs 3.4 e 3.5, VERIFICA SE O ALARME FOI DESLIGADO E SE O SENSOR FOI ACIONADO
; VERIFICA - VERIFICA SE O ALARME FOI DESLIGADO E SE O SENSOR FOI ACIONADO
; SENSOR - AJUSTA OS VALORES DE R1, R2 E R3 EM RELAÇÃO AO INTERVALO DE 10s
; ATRASO - DECREMENTA R1, R2 E R3 E DESLIGA O ALARME DENTRO DAS CONDIÇÕES
; SIRENE - ACIONA A SIRENE (LEDs) e ACIONA O BUZZER
; ATRASO4 - GERA ATRASO PARA OS LEDs E BUZZER
; ATRASO5 - DECREMENTA R1, R2 E R3 E VERIFICA SE O ALARME FOI DESLIGADO
; SETFIM - SETA OS VALORES PARA O ESTADO FINAL DO ALARME
; FIM - GERA ATRASO PARA AJUSTAR CH1, SETA P1 E RESETA P3


INICIO:  
           MOV P1, #0FFH
           MOV P3, #000H
           JNB P1.0, INTERVALO
           JB  P1.0, INICIO

INTERVALO:   
           SETB P3.6
           MOV R3, #04AH
           MOV R2, #0FFH
           MOV R1, #0FFH

ATRASO10:        
           DJNZ R1, ATRASO10
           JNB P1.1, SETFIM
	   DJNZ R2, ATRASO10
	   DJNZ R3, ATRASO10
	   CLR P3.6
	 
MONITORACAO:      
            MOV R3, #04H
            SETB P3.4
            CLR P3.5 
            JNB P1.0, SETFIM
            JNB P1.2, SENSOR

ATRASO05:       
            DJNZ R1, ATRASO05
            DJNZ R2, ATRASO05
            DJNZ R3, ATRASO05
            JNB P1.0, SETFIM
            JNB P1.2, SENSOR
            MOV R3, #04H
            CLR P3.4
            SETB P3.5

VERIFICA:    
            DJNZ R1, VERIFICA
            DJNZ R2, VERIFICA
            DJNZ R3, VERIFICA
            JNB P1.0, SETFIM
            JNB P1.2, SENSOR
            JMP MONITORACAO
	
SENSOR:      
            MOV R3, #04DH
	    MOV R2, #0FFH
	    MOV R1, #0FFH

ATRASO:     
            DJNZ R1, ATRASO
	    DJNZ R2, ATRASO
	    JNB P1.0, SETFIM
	    DJNZ R3, ATRASO

SIRENE:      
            CLR  P3.4
	    CLR  P3.5
	    CLR P3.6
	    SETB  P3.7
            MOV P2, #000H
            MOV R3, #08H
            MOV R2, #0FFH
	      MOV R1, #0FFH

ATRASOLED:     
            DJNZ R1, ATRASOLED
            JNB P1.0, SETFIM
            DJNZ R2, ATRASOLED
            DJNZ R3, ATRASOLED
            MOV P2, #0FFH
            MOV R3, #03H
            MOV R2, #0FFH
            MOV R1, #0FFH
            JNB P1.0, SETFIM 

ATRASOSIRENE:    
            DJNZ R1, ATRASOSIRENE
            JNB P1.0, SETFIM
            DJNZ R2, ATRASOSIRENE
            DJNZ R3, ATRASOSIRENE
            JNB P1.0, SETFIM
            JMP SIRENE

SETFIM:         
            MOV P2, #0FFH
       	    MOV R3, #04H               
	    MOV R2, #0FFH
	    MOV R1, #0FFH

FIM:
	    DJNZ R1, FIM
            DJNZ R2, FIM
            DJNZ R3, FIM
	    MOV P1, #0FFH
	    MOV P3, #000H
	    JMP INICIO                 		          
END
