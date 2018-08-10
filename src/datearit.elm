module DateArit exposing (..)

import Date exposing (Date, Month(..), month, year)


-- TO implement a quarterly mode, we multiply the year by 4 and add the quarter -1 to the result. Voila: a stupid way to represent quarters.


floatToInternalYear : Float -> Int
floatToInternalYear year =
    let
        internalYear =
            (floor year) * 4

        decimal =
            ((floor (year * 10)) - ((floor year) * 10) - 1)
    in
        internalYear + decimal


dateToInternalYear : Date -> Int
dateToInternalYear date =
    let
        quarter =
            case month date of
                Jan ->
                    0

                Feb ->
                    0

                Mar ->
                    0

                Apr ->
                    1

                May ->
                    1

                Jun ->
                    1

                Jul ->
                    2

                Aug ->
                    2

                Sep ->
                    2

                Oct ->
                    3

                Nov ->
                    3

                Dec ->
                    3
    in
        year date |> (*) 4 |> (+) quarter


getYear : Int -> Int
getYear internalYear =
    if internalYear > 5000 then
        internalYear // 4
    else
        internalYear


getQuarter : Int -> Maybe Int
getQuarter internalYear =
    if internalYear > 5000 then
        rem internalYear 4 |> (+) 1 |> Maybe.Just
    else
        Maybe.Nothing


getDecimal : Float -> Int
getDecimal number =
    ((number * 10) - (toFloat (floor number)) * 10) |> floor
