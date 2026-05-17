(deffacts start "Начать опрос"
    (start-survey))


;; ДИСПЕТЧЕР — перезапускает (run), пока есть активные правила
(defrule auto-run "Автозапуск цепочки"
    (run-needed)          ;; факт-сигнал "нужен ещё один прогон"
    =>
    (retract *)           ;; убираем сигнал
    (run))                ;; запускаем следующий раунд


(deffunction ask-bin (?question)
    (printout t ?question " (1/2) ")
    (bind ?answer (read))
    (while (and (neq ?answer 1) (neq ?answer 2)) do
        (printout t "Пожалуйста, ответьте '1' или '2': ")
        (bind ?answer (read)))
    (return ?answer)
)

(deffunction ask-tern (?question)
    (printout t ?question " (1/2/3) ")
    (bind ?answer (read))
    (while (and (neq ?answer 1) (neq ?answer 2) (neq ?answer 3)) do
        (printout t "Пожалуйста, ответьте '1', '2' или '3': ")
        (bind ?answer (read)))
    (return ?answer)
)




(defrule question-1 "Удаленность от центра города"
    ?fact <- (start-survey)
    =>
    (bind ?answer (ask-bin "Удаленность от центра города: 1) большая или 2) небольшая?"))
    (retract ?fact)
    (if (eq ?answer 1)
        then (assert (q2))
        else (assert (q6))
    )
)

    (defrule question-2 "Наличие рядом Финского залива"
        ?fact <- (q2)
        =>
        (bind ?answer (ask-bin "Наличие рядом Финского залива: 1) важно или 2) не важно?"))
        (retract ?fact)
        (if (eq ?answer 1)
            then (assert (q4))
            else (assert (q3))
        )
    )

        (defrule question-3 "Хорошая экологическая обстановка или менее дорогое жилье?"
            ?fact <- (q3)
            =>
            (bind ?answer (ask-bin "Хорошая экологическая обстановка(1) или менее дорогое жилье(2)?"))
            (retract ?fact)
            (if (eq ?answer 1)
                then (assert (result "Пушкинский"))
                else (assert (result "Колпинский"))
            )
        )

        (defrule question-4 "Наличие рядом пляжа для купания"
            ?fact <- (q4)
            =>
            (bind ?answer (ask-bin "Наличие рядом пляжа для купания: 1) важно или 2) не важно?"))
            (retract ?fact)
            (if (eq ?answer 1)
                then (assert (result "Курортный"))
                else (assert (q5))
            )
        )

            (defrule question-5 "Предпочитаемый способ добираться до центра города"
                ?fact <- (q5)
                =>
                (bind ?answer (ask-bin "Предпочитаемый способ добираться до центра города: 1) автомобиль или 2) общественный транспорт?"))
                (retract ?fact)
                (if (eq ?answer 1)
                    then (assert (result "Кронштадтский"))
                    else (assert (result "Петродворцовый"))
                )
            )

    (defrule question-6 "Развитая инфраструктура городского транспорта"
        ?fact <- (q6)
        =>
        (bind ?answer (ask-bin "Развитая инфраструктура городского транспорта: 1) не сильно важна или 2) критически важна?"))
        (retract ?fact)
        (if (eq ?answer 1)
            then (assert (q7))
            else (assert (q13))
        )
    )

        (defrule question-7 "Стоимость жилья"
            ?fact <- (q7)
            =>
            (bind ?answer (ask-tern "Стоимость жилья: 1) ниже среднего, 2) средняя или 3) выше среднего?"))
            (retract ?fact)
            (if (eq ?answer 1)
                then (assert (q8))
                else (
                    if (eq ?answer 2)
                    then (assert (q11))
                    else (assert (q12))
                )
            )
        )

            (defrule question-8 "Важность наличия хорошей экологической обстановки"
                ?fact <- (q8)
                =>
                (bind ?answer (ask-bin "Важность наличия хорошей экологической обстановки: 1) важно или 2) не важно?"))
                (retract ?fact)
                (if (eq ?answer 1)
                    then (assert (result "Красносельский"))
                    else (assert (q9))
                )
            )

                (defrule question-9 "Удобство передвижения на личном транспорте"
                    ?fact <- (q9)
                    =>
                    (bind ?answer (ask-bin "Удобство передвижения на личном транспорте: 1) важно или 2) не важно?"))
                    (retract ?fact)
                    (if (eq ?answer 1)
                        then (assert (q10))
                        else (assert (result "Красногвардейский"))
                    )
                )

                    (defrule question-10 "Наличие ЗСД"
                        ?fact <- (q10)
                        =>
                        (bind ?answer (ask-bin "Наличие ЗСД: 1) важно или 2) не важно?"))
                        (retract ?fact)
                        (if (eq ?answer 1)
                            then (assert (result "Кировский"))
                            else (assert (result "Невский"))
                        )
                    )

            (defrule question-11 "Зависимость от метро"
                ?fact <- (q11)
                =>
                (bind ?answer (ask-bin "Зависимость от метро: 1) большая или 2) небольшая?"))
                (retract ?fact)
                (if (eq ?answer 1)
                    then (assert (result "Выборгский"))
                    else (assert (result "Калининский"))
                )
            )

            (defrule question-12 "Удобство передвижения на личном транспорте"
                ?fact <- (q12)
                =>
                (bind ?answer (ask-bin "Удобство передвижения на личном транспорте: 1) важно или 2) не важно?"))
                (retract ?fact)
                (if (eq ?answer 1)
                    then (assert (result "Приморский"))
                    else (assert (result "Василеостровский"))
                )
            )

        (defrule question-13 "Удобство передвижения на личном транспорте"
            ?fact <- (q13)
            =>
            (bind ?answer (ask-bin "Удобство передвижения на личном транспорте: 1) важно или 2) не важно?"))
            (retract ?fact)
            (if (eq ?answer 1)
                then (assert (q16))
                else (assert (q14))
            )
        )

            (defrule question-14 "Важность наличия хорошей экологической обстановки"
                ?fact <- (q14)
                =>
                (bind ?answer (ask-bin "Важность наличия хорошей экологической обстановки: 1) важно или 2) не важно?"))
                (retract ?fact)
                (if (eq ?answer 1)
                    then (assert (result "Петроградский"))
                    else (assert (q15))
                )
            )

                (defrule question-15 "Желание жить в более свободном от туристов месте"
                    ?fact <- (q15)
                    =>
                    (bind ?answer (ask-bin "Желание жить в более свободном от туристов месте: 1) есть или 2) нет?"))
                    (retract ?fact)
                    (if (eq ?answer 1)
                        then (assert (result "Адмиралтейский"))
                        else (assert (result "Центральный"))
                    )
                )

            (defrule question-16 "Стоимость жилья"
                ?fact <- (q16)
                =>
                (bind ?answer (ask-bin "Стоимость жилья: 1) высокая или 2) невысокая?"))
                (retract ?fact)
                (if (eq ?answer 1)
                    then (assert (result "Московский"))
                    else (assert (result "Фрунзенский"))
                )
            )




(defrule show-result "Показать результат"
    (result ?name)
    =>
    (printout t "--------" crlf "Район, который лучше всего вам подходит: " ?name crlf)
)



(reset)
(run)
(exit)

