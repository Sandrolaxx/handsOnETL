DECLARE   v_dataInicial           DATE;
          v_dataFinal                      DATE;
          v_data                              DATE;
          v_ano                               SMALLINT;
          v_mes                              SMALLINT;
          v_dia                                SMALLINT;
          v_diaSemana             SMALLINT;
          v_diaAno                SMALLINT;
          v_diaUtil               CHAR(1);
          v_fimSemana             CHAR(1);
          v_feriado               CHAR(1);
          v_preFeriado            CHAR(1);
          v_posFeriado            CHAR(1);
          v_nomeFeriado           VARCHAR(30);
          v_nomeDiaSemana         VARCHAR(15);
          v_nomeDiaSemanaAbrev    CHAR(3);
          v_nomeMes               VARCHAR(15);
          v_nomeMesAbrev          CHAR(3);
          v_bimestre              SMALLINT;
          v_trimestre             SMALLINT;
          v_nrSemanaMes           SMALLINT;
          v_estacaoAno            VARCHAR(15);
          v_dataPorExtenso        VARCHAR(50);
          v_skData                INTEGER;

BEGIN
  -- Didite o período que você deseja carregar na dimensão data
   v_dataInicial                      := '01/01/2000';
   v_dataFinal                        := '31/12/2020';
   
  WHILE (v_dataInicial <= v_dataFinal) 
  LOOP  
    v_data := v_dataInicial;
    v_ano := EXTRACT(YEAR FROM v_data);
    v_mes := EXTRACT(MONTH FROM v_data);
    v_dia := EXTRACT(DAY FROM v_data);
    v_skData := trim(v_ano) || trim(to_char(v_mes, '09')) || trim(to_char(v_dia, '09'));
   
--    DBMS_OUTPUT.PUT_LINE(v_skData);
  
    SELECT TO_CHAR(v_data, 'D') into v_diaSemana from dual;
    SELECT TO_CHAR(v_data, 'DDD') into v_diaAno from DUAL;
    
    IF v_diaSemana IN (1,7) THEN
      v_fimSemana := 'S';
    ELSE
      v_fimSemana := 'N';
    END IF;  
      
      /* feriados locais, regionais e aqueles que não possuem data fixa
      (carnaval, páscoa e corpus cristis) devem ser adicionados */
      IF (v_mes = 1 AND v_dia = 1) OR (v_mes = 12 AND v_dia = 31) THEN--ano novo
        v_nomeFeriado := 'ano novo';
      ELSIF (v_mes = 4 AND v_dia = 21) THEN --tiradentes
        v_nomeFeriado := 'tiradentes';
      ELSIF (v_mes = 5 AND v_dia = 1) THEN --dia do trabalho
        v_nomeFeriado := 'dia do trabalho';
      ELSIF (v_mes = 9 AND v_dia = 7) THEN --independência do brasil
        v_nomeFeriado := 'independência do brasil';
      ELSIF (v_mes = 10 AND v_dia = 12) THEN --dia da nossa senhora aparecida
        v_nomeFeriado := 'dia da nossa senhora aparecida';
      ELSIF (v_mes = 11 AND v_dia = 2) THEN --finados
        v_nomeFeriado := 'finados';
      ELSIF (v_mes = 11 AND v_dia = 15) THEN --proclamação da república
        v_nomeFeriado := 'proclamação da república';
      ELSIF (v_mes = 12 AND v_dia = 25) THEN --natal
        v_nomeFeriado := 'natal';
      ELSE
         v_nomeFeriado  := NULL;
      END IF;
    
      IF  (v_mes = 12 AND v_dia = 31)   OR    --ano novo
          (v_mes = 4 AND v_dia = 20)    OR    --tiradentes
          (v_mes = 4 AND v_dia = 30)    OR    --dia do trabalho
          (v_mes = 9 AND v_dia = 6)     OR    --independência do brasil
          (v_mes = 10 AND v_dia = 11)   OR    --dia da nossa senhora aparecida
          (v_mes = 11 AND v_dia = 1)    OR    --finados
          (v_mes = 11 AND v_dia = 14)   OR    --proclamação da república
          (v_mes = 12 AND v_dia = 24)   THEN  --ano novo
            v_preFeriado := 'S';
      ELSE
            v_preFeriado := 'N';
      END IF;

      IF (v_mes = 1 AND v_dia = 1)    OR    --ano novo
         (v_mes = 4 AND v_dia = 21)   OR    --tiradentes
         (v_mes = 5 AND v_dia = 1)    OR    --dia do trabalho
         (v_mes = 9 AND v_dia = 7)    OR    --independência do brasil
         (v_mes = 10 AND v_dia = 12)  OR    --dia da nossa senhora aparecida
         (v_mes = 11 AND v_dia = 2)   OR    --finados
         (v_mes = 11 AND v_dia = 15)  OR    --proclamação da república
         (v_mes = 12 AND v_dia = 25) THEN   --ano novo
             v_feriado  := 'S';
      ELSE
             v_feriado  := 'N';
      END IF;       

      IF (v_mes = 1 AND v_dia = 2)    OR      --ano novo
         (v_mes = 4 AND v_dia = 22)   OR      --tiradentes
         (v_mes = 5 AND v_dia = 2)    OR      --dia do trabalho
         (v_mes = 9 AND v_dia = 8)    OR      --independência do brasil
         (v_mes = 10 AND v_dia = 13)  OR      --dia da nossa senhora aparecida
         (v_mes = 11 AND v_dia = 3)   OR      --finados
         (v_mes = 11 AND v_dia = 16)  OR      --proclamação da república
         (v_mes = 12 AND v_dia = 26)   THEN   --ano novo
              v_posFeriado := 'S';
      ELSE
              v_posFeriado := 'N';
      END IF;
      
              v_nomeMes :=
                    CASE
                      WHEN v_mes = 1 THEN         'janeiro'
                      WHEN v_mes = 2 THEN         'fevereiro'
                      WHEN v_mes = 3 THEN         'março'
                      WHEN v_mes = 4 THEN         'abril'
                      WHEN v_mes = 5 THEN         'maio'
                      WHEN v_mes = 6 THEN         'junho'
                      WHEN v_mes = 7 THEN         'julho'
                      WHEN v_mes = 8 THEN         'agosto'
                      WHEN v_mes = 9 THEN         'setembro'
                      WHEN v_mes = 10 THEN        'outubro'
                      WHEN v_mes = 11 THEN        'novembro'
                      WHEN v_mes = 12 THEN        'dezembro'
                  END;
                            
                v_nomeMesAbrev :=
                CASE
                  WHEN v_mes = 1 THEN             'jan'
                  WHEN v_mes = 2 THEN             'fev'
                  WHEN v_mes = 3 THEN             'mar'
                  WHEN v_mes = 4 THEN             'abr'
                  WHEN v_mes = 5 THEN             'mai'
                  WHEN v_mes = 6 THEN             'jun'
                  WHEN v_mes = 7 THEN             'jul'
                  WHEN v_mes = 8 THEN             'ago'
                  WHEN v_mes = 9 THEN             'set'
                  WHEN v_mes = 10 THEN            'out'
                  WHEN v_mes = 11 THEN            'nov'
                  WHEN v_mes = 12 THEN            'dez'
                END;
                
                IF v_fimSemana = 'S' OR v_feriado = 'S' THEN 
                  v_diaUtil := 'N';
                ELSE
                  v_diaUtil := 'S';
                END IF;  
                  
                  v_nomeDiaSemana :=
                    CASE
                      WHEN v_diaSemana = 1 THEN   'domingo'
                      WHEN v_diaSemana = 2 THEN   'segunda-feira'
                      WHEN v_diaSemana = 3 THEN   'terça-feira'
                      WHEN v_diaSemana = 4 THEN   'quarta-feira'
                      WHEN v_diaSemana = 5 THEN   'quinta-feira'
                      WHEN v_diaSemana = 6 THEN   'sexta-feira'
                      ELSE                        'sábado'
                    END; 
                                   
                                   
                  v_nomeDiaSemanaAbrev :=
                    CASE
                      WHEN v_diaSemana = 1 THEN       'dom'
                      WHEN v_diaSemana = 2 THEN       'seg'
                      WHEN v_diaSemana = 3 THEN       'ter'
                      WHEN v_diaSemana = 4 THEN       'qua'
                      WHEN v_diaSemana = 5 THEN       'qui'
                      WHEN v_diaSemana = 6 THEN       'sex'
                    ELSE                              'sab'
                    END;
                
                 v_bimestre :=
                    CASE
                      WHEN v_mes IN (1,2) THEN        1
                      WHEN v_mes IN (3,4) THEN        2
                      WHEN v_mes IN (5,6) THEN        3
                      WHEN v_mes IN (7,8) THEN        4
                      WHEN v_mes IN (9,10) THEN       5
                    ELSE                              6
                    END; 
                
                v_trimestre :=
                CASE
                  WHEN v_mes IN (1,2,3) THEN       1
                  WHEN v_mes IN (4,5,6) THEN       2
                  WHEN v_mes IN (7,8,9) THEN       3
                  ELSE   4
                END; 
                
                v_nrSemanaMes :=
                CASE
                  WHEN v_dia < 8 THEN                 1
                  WHEN v_dia < 15 THEN                2
                  WHEN v_dia < 22 THEN                3
                  WHEN v_dia < 29 THEN                4
                  ELSE                                5
                END; 
                
                IF (v_data >= (TO_DATE('23/09/' || TO_CHAR(v_ano)))) AND (v_data <= (TO_DATE('20/12/' || TO_CHAR(v_ano)))) THEN
                       v_estacaoAno := 'primavera';
                ELSIF (v_data >= (TO_DATE('21/03/' || TO_CHAR(v_ano)))) AND (v_data <= (TO_DATE('20/06/' || TO_CHAR(v_ano)))) THEN
                        v_estacaoAno := 'outono';
                ELSIF (v_data >= (TO_DATE('21/06/' || TO_CHAR(v_ano)))) AND (v_data <= (TO_DATE('22/09/' || TO_CHAR(v_ano)))) THEN
                        v_estacaoAno := 'inverno';
                ELSE -- v_data between 21/12 e 20/03
                        v_estacaoAno := 'verão';
                END IF; 
                
                          
                INSERT INTO DIM_VENDA_DATA
                        SELECT 
                          --SEQ_DIM_DATA.NEXTVAL,
                          v_skData,
                          v_data ,
                          v_ano ,
                          v_mes ,
                          v_dia ,
                          v_diaSemana ,
                          v_diaAno , 
                          CASE
                            WHEN MOD(v_ano,4) = 0
                            THEN 'S'
                            ELSE 'N'
                          END -- ANO_BISSEXTO
                          ,
                          v_diaUtil ,
                          v_fimSemana ,
                          v_feriado ,
                          v_preFeriado ,
                          v_posFeriado ,
                          v_nomeFeriado ,
                          v_nomeDiaSemana ,
                          v_nomeDiaSemanaAbrev ,
                          v_nomeMes ,
                          v_nomeMesAbrev ,
                          CASE
                            WHEN v_dia < 16
                            THEN 1
                            ELSE 2
                          END -- QUINZENA
                          ,
                          v_bimestre ,
                          v_trimestre ,
                          CASE
                            WHEN v_mes < 7
                            THEN 1
                            ELSE 2
                          END -- SEMESTRE
                          ,
                          v_nrSemanaMes ,
                          v_diaSemana, --NR_SEMANA_ANO
                          v_estacaoAno ,
                          lower(v_nomeDiaSemana || ', ' || TO_CHAR(v_dia) || ' de ' || v_nomeMes || ' de ' || TO_CHAR(v_ano)),  -- Data
                          v_dataInicial
                         FROM DUAL;                         
                         
                         commit;
    
    v_dataInicial := v_dataInicial + 1;
       
  END LOOP;
 END;