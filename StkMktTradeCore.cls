/*********************************************************************
   File        : StkMktTradeCore.cls
   Description : Stock Market Trading Core Class
   Author(s)   : Karikalan
********************************************************************
                         Modification History
********************************************************************  
 
********************************************************************/
USING System.*                     FROM ASSEMBLY.
USING System.IO.*                  FROM ASSEMBLY.
USING System.Text.*                FROM ASSEMBLY.
USING System.Windows.Forms.*       FROM ASSEMBLY.

ROUTINE-LEVEL ON ERROR UNDO, THROW.
 
CLASS StkMktTradeCore USE-WIDGET-POOL:
   
   DEFINE TEMP-TABLE ttExchangeData NO-UNDO
          FIELD StkSymbol AS CHAR
          FIELD SType     AS CHAR
          FIELD LastDiv   AS DECIMAL
          FIELD FixDiv    AS DECIMAL
          FIELD ParVal    AS DECIMAL
          FIELD DivYield  AS DECIMAL
          FIELD PERatio   AS DECIMAL 
          FIELD GeoMean   AS DECIMAL
          FIELD VWStkPri  AS DECIMAL 
          FIELD TradedPri AS DECIMAL
          FIELD Qty       AS INTEGER
          INDEX idxMain IS PRIMARY StkSymbol.
                     
   DEFINE PUBLIC PROPERTY dvPriceVal AS DECIMAL NO-UNDO
        GET():
            RETURN dvPriceVal.
        END GET.
        SET(INPUT cValue AS DECIMAL):
            ASSIGN dvPriceVal = cValue.
        END SET.

    CONSTRUCTOR STATIC StkMktTradeCore (  ):
  
    END CONSTRUCTOR.

    METHOD PUBLIC VOID CalcResults(oCalc AS StkMktTradeCore):
        
        DEF VAR iCnt AS INTE NO-UNDO.
        CREATE ttExchangeData.
        ASSIGN ttExchangeData.StkSymbol = "TEA"
               ttExchangeData.SType     = "Common"
               ttExchangeData.LastDiv   = 0
               ttExchangeData.FixDiv    = 0 
               ttExchangeData.TradedPri = 10.5
               ttExchangeData.Qty       = 8
               ttExchangeData.ParVal    = 100.
               
       CREATE ttExchangeData.
       ASSIGN ttExchangeData.StkSymbol = "POP"
              ttExchangeData.SType     = "Common"
              ttExchangeData.LastDiv   = 8
              ttExchangeData.FixDiv    = 0 
              ttExchangeData.TradedPri = 12
              ttExchangeData.Qty       = 6
              ttExchangeData.ParVal    = 100.
           
       CREATE ttExchangeData.
       ASSIGN ttExchangeData.StkSymbol = "ALE"
              ttExchangeData.SType     = "Common"
              ttExchangeData.LastDiv   = 23
              ttExchangeData.FixDiv    = 0 
              ttExchangeData.ParVal    = 60
              ttExchangeData.TradedPri = 7
              ttExchangeData.Qty       = 4.
               
        CREATE ttExchangeData.
        ASSIGN ttExchangeData.StkSymbol = "GIN"
               ttExchangeData.SType     = "Preferred"
               ttExchangeData.LastDiv   = 8
               ttExchangeData.FixDiv    = 2 
               ttExchangeData.ParVal    = 100
               ttExchangeData.TradedPri = 10.5
               ttExchangeData.Qty       = 8.
                   
        CREATE ttExchangeData.
        ASSIGN ttExchangeData.StkSymbol = "JOE"
               ttExchangeData.SType     = "Common"
               ttExchangeData.LastDiv   = 13
               ttExchangeData.FixDiv    = 0 
               ttExchangeData.ParVal    = 250               
               ttExchangeData.TradedPri = 14
               ttExchangeData.Qty       = 11.
               
         FOR EACH ttExchangeData:
           ASSIGN iCnt = iCnt + 1. 
           ASSIGN ttExchangeData.DivYield = IF ttExchangeData.SType = "Common" THEN (ttExchangeData.LastDiv / StkMktTradeCore.dvPriceVal)
                                                                  ELSE ((ttExchangeData.FixDiv * ttExchangeData.ParVal ) / StkMktTradeCore.dvPriceVal)) 
                  ttExchangeData.PERatio  = StkMktTradeCore.dvPriceVal / ttExchangeData.LastDiv
                  ttExchangeData.GeoMean  = EXP(StkMktTradeCore.dvPriceVal, iCnt)
                  ttExchangeData.VWStkPri = ttExchangeData.VWStkPri + ((ttExchangeData.TradedPri * ttExchangeData.Qty) / ttExchangeData.Qty).
         END.    
        
        CATCH ex AS Progress.Lang.Error:
            UNDO, THROW ex.
        END CATCH.

    END METHOD.
  
END CLASS.

