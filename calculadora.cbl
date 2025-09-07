      ******************************************************************
      * Author: Edilson Salvador Ricci
      * Date: 06/09/2025
      * Purpose: Recapitulando aprendizados da linguagem
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCULADORA.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-PC.
       OBJECT-COMPUTER. IBM-PC.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  WS-MENU-OPCAO           PIC X(1).
       01  WS-CONTINUAR            PIC X(1) VALUE 'S'.
       01  WS-PRIMEIRO-NUMERO      PIC S9(10)V9(2).
       01  WS-SEGUNDO-NUMERO       PIC S9(10)V9(2).
       01  WS-RESULTADO            PIC S9(15)V9(2).
       01  WS-OPERADOR             PIC X(1).
       01  WS-EXPRESSAO            PIC X(50).
       01  WS-POSICAO              PIC 9(2).
       01  WS-TAMANHO              PIC 9(2).
       01  WS-CHAR                 PIC X(1).
       01  WS-NUMERO-STR           PIC X(15).
       01  WS-ERRO-FLAG            PIC X(1) VALUE 'N'.
       01  WS-CONTADOR             PIC 9(2).
       01  WS-TEMP-NUM             PIC S9(10)V9(2).
       01  WS-PRECEDENCIA-FLAG     PIC X(1).

       01  WS-DISPLAY-NUM1         PIC -ZZZ,ZZZ,ZZ9.99.
       01  WS-DISPLAY-NUM2         PIC -ZZZ,ZZZ,ZZ9.99.
       01  WS-DISPLAY-RESULT       PIC -ZZZ,ZZZ,ZZZ,ZZ9.99.

       01  WS-PILHA-NUMEROS.
           05  WS-PILHA-NUM        PIC S9(10)V9(2) OCCURS 20 TIMES.
           05  WS-PILHA-NUM-TOP    PIC 9(2) VALUE 0.

       01  WS-PILHA-OPERADORES.
           05  WS-PILHA-OP         PIC X(1) OCCURS 20 TIMES.
           05  WS-PILHA-OP-TOP     PIC 9(2) VALUE 0.

       PROCEDURE DIVISION.
       MAIN-PROGRAM.
           PERFORM EXIBIR-CABECALHO
           PERFORM UNTIL WS-CONTINUAR = 'N' OR WS-CONTINUAR = 'n'
               PERFORM EXIBIR-MENU
               PERFORM PROCESSAR-OPCAO
               IF WS-CONTINUAR NOT = 'N' AND WS-CONTINUAR NOT = 'n'
                   DISPLAY ' '
                   DISPLAY 'Deseja continuar? (S/N): '
                   ACCEPT WS-CONTINUAR
               END-IF
           END-PERFORM
           DISPLAY 'Calculadora encerrada. Obrigado!'
           STOP RUN.

       EXIBIR-CABECALHO.
           DISPLAY '========================================='
           DISPLAY '           CALCULADORA COBOL            '
           DISPLAY '========================================='
           DISPLAY ' '.

       EXIBIR-MENU.
           DISPLAY '1 - Operacao Simples (+ - * /)'
           DISPLAY '2 - Expressao Matematica'
           DISPLAY '3 - Sair'
           DISPLAY ' '
           DISPLAY 'Escolha uma opcao: ' WITH NO ADVANCING
           ACCEPT WS-MENU-OPCAO.

       PROCESSAR-OPCAO.
           EVALUATE WS-MENU-OPCAO
               WHEN '1'
                   PERFORM OPERACAO-SIMPLES
               WHEN '2'
                   PERFORM AVALIAR-EXPRESSAO-COMPLETA
               WHEN '3'
                   MOVE 'N' TO WS-CONTINUAR
               WHEN OTHER
                   DISPLAY 'Opcao invalida! Tente novamente.'
           END-EVALUATE.

       OPERACAO-SIMPLES.
           DISPLAY 'Digite o primeiro numero: ' WITH NO ADVANCING
           ACCEPT WS-PRIMEIRO-NUMERO

           DISPLAY 'Digite o operador (+, -, *, /): ' WITH NO ADVANCING
           ACCEPT WS-OPERADOR

           DISPLAY 'Digite o segundo numero: ' WITH NO ADVANCING
           ACCEPT WS-SEGUNDO-NUMERO

           PERFORM CALCULAR-RESULTADO

           IF WS-ERRO-FLAG = 'N'
               MOVE WS-PRIMEIRO-NUMERO TO WS-DISPLAY-NUM1
               MOVE WS-SEGUNDO-NUMERO TO WS-DISPLAY-NUM2
               MOVE WS-RESULTADO TO WS-DISPLAY-RESULT
               DISPLAY ' '
               DISPLAY 'Calculo: ' WS-DISPLAY-NUM1 ' ' WS-OPERADOR
                       ' ' WS-DISPLAY-NUM2 ' = ' WS-DISPLAY-RESULT
           END-IF.

       CALCULAR-RESULTADO.
           MOVE 'N' TO WS-ERRO-FLAG

           EVALUATE WS-OPERADOR
               WHEN '+'
                   ADD WS-PRIMEIRO-NUMERO TO WS-SEGUNDO-NUMERO
                       GIVING WS-RESULTADO
               WHEN '-'
                   SUBTRACT WS-SEGUNDO-NUMERO FROM WS-PRIMEIRO-NUMERO
                       GIVING WS-RESULTADO
               WHEN '*'
                   MULTIPLY WS-PRIMEIRO-NUMERO BY WS-SEGUNDO-NUMERO
                       GIVING WS-RESULTADO
               WHEN '/'
                   IF WS-SEGUNDO-NUMERO = 0
                       DISPLAY 'ERRO: Nao e possivel dividir por zero!'
                       MOVE 'S' TO WS-ERRO-FLAG
                   ELSE
                       DIVIDE WS-PRIMEIRO-NUMERO BY WS-SEGUNDO-NUMERO
                           GIVING WS-RESULTADO
                   END-IF
               WHEN OTHER
                   DISPLAY 'ERRO: Operador invalido!'
                   MOVE 'S' TO WS-ERRO-FLAG
           END-EVALUATE.

       AVALIAR-EXPRESSAO-COMPLETA.
           DISPLAY 'Digite a expressao (ex: 2+3*4-1): '
           ACCEPT WS-EXPRESSAO

           PERFORM PROCESSAR-EXPRESSAO

           IF WS-ERRO-FLAG = 'N'
               MOVE WS-RESULTADO TO WS-DISPLAY-RESULT
               DISPLAY 'Resultado: ' WS-DISPLAY-RESULT
           END-IF.

       PROCESSAR-EXPRESSAO.
           MOVE 'N' TO WS-ERRO-FLAG
           MOVE 0 TO WS-PILHA-NUM-TOP
           MOVE 0 TO WS-PILHA-OP-TOP
           MOVE 0 TO WS-RESULTADO

           INSPECT WS-EXPRESSAO TALLYING WS-TAMANHO FOR CHARACTERS
           MOVE 1 TO WS-POSICAO

           PERFORM UNTIL WS-POSICAO > WS-TAMANHO OR WS-ERRO-FLAG = 'S'
               MOVE WS-EXPRESSAO(WS-POSICAO:1) TO WS-CHAR

               IF WS-CHAR IS NUMERIC OR WS-CHAR = '.'
                   PERFORM PROCESSAR-NUMERO
               ELSE
                   IF WS-CHAR = '+' OR WS-CHAR = '-' OR
                      WS-CHAR = '*' OR WS-CHAR = '/'
                       PERFORM PROCESSAR-OPERADOR
                   ELSE
                       IF WS-CHAR NOT = ' '
                           DISPLAY 'ERRO: Caractere invalido: ' WS-CHAR
                           MOVE 'S' TO WS-ERRO-FLAG
                       ELSE
                           ADD 1 TO WS-POSICAO
                       END-IF
                   END-IF
               END-IF
           END-PERFORM

           IF WS-ERRO-FLAG = 'N'
               PERFORM PROCESSAR-OPERADORES-RESTANTES
           END-IF.

       PROCESSAR-NUMERO.
           MOVE SPACES TO WS-NUMERO-STR
           MOVE 0 TO WS-CONTADOR

           PERFORM UNTIL WS-POSICAO > WS-TAMANHO OR
                        (WS-CHAR NOT NUMERIC AND WS-CHAR NOT = '.')
               MOVE WS-EXPRESSAO(WS-POSICAO:1) TO WS-CHAR
               IF WS-CHAR IS NUMERIC OR WS-CHAR = '.'
                   ADD 1 TO WS-CONTADOR
                   MOVE WS-CHAR TO WS-NUMERO-STR(WS-CONTADOR:1)
                   ADD 1 TO WS-POSICAO
               END-IF
           END-PERFORM

           IF WS-CONTADOR > 0
               MOVE FUNCTION NUMVAL(WS-NUMERO-STR(1:WS-CONTADOR))
                    TO WS-TEMP-NUM
               PERFORM EMPILHAR-NUMERO
           END-IF.

       PROCESSAR-OPERADOR.
           PERFORM VERIFICAR-PRECEDENCIA-PROCESSAR

           IF WS-ERRO-FLAG = 'N'
               ADD 1 TO WS-PILHA-OP-TOP
               MOVE WS-CHAR TO WS-PILHA-OP(WS-PILHA-OP-TOP)
               ADD 1 TO WS-POSICAO
           END-IF.

       VERIFICAR-PRECEDENCIA-PROCESSAR.
           PERFORM UNTIL WS-PILHA-OP-TOP = 0 OR WS-ERRO-FLAG = 'S'
               PERFORM TEM-PRECEDENCIA
               IF WS-PRECEDENCIA-FLAG = 'S'
                   PERFORM APLICAR-OPERACAO-TOPO
               ELSE
                   EXIT PERFORM
               END-IF
           END-PERFORM.

       TEM-PRECEDENCIA.
           MOVE 'N' TO WS-PRECEDENCIA-FLAG

           IF WS-PILHA-OP(WS-PILHA-OP-TOP) = '*' OR
              WS-PILHA-OP(WS-PILHA-OP-TOP) = '/'
               MOVE 'S' TO WS-PRECEDENCIA-FLAG
           ELSE
               IF (WS-PILHA-OP(WS-PILHA-OP-TOP) = '+' OR
                   WS-PILHA-OP(WS-PILHA-OP-TOP) = '-') AND
                  (WS-CHAR = '+' OR WS-CHAR = '-')
                   MOVE 'S' TO WS-PRECEDENCIA-FLAG
               END-IF
           END-IF.

       EMPILHAR-NUMERO.
           ADD 1 TO WS-PILHA-NUM-TOP
           MOVE WS-TEMP-NUM TO WS-PILHA-NUM(WS-PILHA-NUM-TOP).

       DESEMPILHAR-NUMERO.
           IF WS-PILHA-NUM-TOP > 0
               MOVE WS-PILHA-NUM(WS-PILHA-NUM-TOP) TO WS-SEGUNDO-NUMERO
               SUBTRACT 1 FROM WS-PILHA-NUM-TOP
           ELSE
               DISPLAY 'ERRO: Pilha de numeros vazia!'
               MOVE 'S' TO WS-ERRO-FLAG
           END-IF.

       APLICAR-OPERACAO-TOPO.
           IF WS-PILHA-OP-TOP > 0 AND WS-PILHA-NUM-TOP > 1
               PERFORM DESEMPILHAR-NUMERO
               MOVE WS-SEGUNDO-NUMERO TO WS-TEMP-NUM
               PERFORM DESEMPILHAR-NUMERO
               MOVE WS-SEGUNDO-NUMERO TO WS-PRIMEIRO-NUMERO
               MOVE WS-TEMP-NUM TO WS-SEGUNDO-NUMERO
               MOVE WS-PILHA-OP(WS-PILHA-OP-TOP) TO WS-OPERADOR
               SUBTRACT 1 FROM WS-PILHA-OP-TOP
               PERFORM CALCULAR-RESULTADO
               IF WS-ERRO-FLAG = 'N'
                   MOVE WS-RESULTADO TO WS-TEMP-NUM
                   PERFORM EMPILHAR-NUMERO
               END-IF
           ELSE
               DISPLAY 'ERRO: Expressao invalida!'
               MOVE 'S' TO WS-ERRO-FLAG
           END-IF.

       PROCESSAR-OPERADORES-RESTANTES.
           PERFORM UNTIL WS-PILHA-OP-TOP = 0 OR WS-ERRO-FLAG = 'S'
               PERFORM APLICAR-OPERACAO-TOPO
           END-PERFORM

           IF WS-ERRO-FLAG = 'N'
               IF WS-PILHA-NUM-TOP = 1
                   MOVE WS-PILHA-NUM(1) TO WS-RESULTADO
               ELSE
                   DISPLAY 'ERRO: Expressao mal formada!'
                   MOVE 'S' TO WS-ERRO-FLAG
               END-IF
           END-IF.
