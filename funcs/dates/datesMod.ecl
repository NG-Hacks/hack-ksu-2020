IMPORT STD;

EXPORT datesMod := MODULE
    EXPORT UNSIGNED4 eightDays (UNSIGNED4 date) := FUNCTION
        // increment input date by 8 days
        RETURN STD.Date.AdjustDate(date, 0, 0, 8);
    END;

    EXPORT UNSIGNED4 sevenDays (UNSIGNED4 date) := FUNCTION
        // increment input date by 7 days
        RETURN STD.Date.AdjustDate(date, 0, 0, 7);
    END;

    EXPORT UNSIGNED4 oneMonth (UNSIGNED4 date) := FUNCTION
        // increment input date by 1 month
        RETURN STD.Date.AdjustDate(date, 0, 1, 0);
    END;

    EXPORT UNSIGNED4 endMonth (UNSIGNED4 date) := FUNCTION
        // increment input date by 1 month 
        // and decrement by 1 day
        RETURN STD.Date.AdjustDate(date, 0, 1, -1);
    END;
END;